*! version 1.0.1
*! Calculate marginal effects post-mfp using f_able, handles scaled variables
program define mfp_mfx, rclass
    version 14.0 
    
    syntax [, vars(string) *]
	
	// Check for f_able dependency
    capture which f_able
    if _rc {
        display as error "The package 'f_able' is required but not installed."
        display as text "You can install it by typing: {stata ssc install f_able}"
        exit 198
    }
    
    // Feature 1: Default to all variables "*" if vars() is not specified
    if "`vars'" == "" {
        local vars "*"
    }
    
    // Capture the transformed variables left by mfp
    cap unab fpvars : I*__?
    if _rc {
        cap unab fpvars : I*__*
        if _rc {
            di as err "No transformed variables (I*__?) found in the dataset."
            exit 111
        }
    }
    
    local orig_varlist ""
    
    foreach v of local fpvars {
        local lbl : variable label `v'
        
        // Parse the label assuming format "formula: X = orig_var/scale"
        if regexm("`lbl'", "^(.*):[ ]*X[ ]*=[ ]*(.*)$") {
            local formula = regexs(1)
            local x_def   = trim(regexs(2)) // e.g., "weight/1000" or "weight"
            
            // Extract the true variable name by matching only Stata-allowed characters
            if regexm("`x_def'", "^([a-zA-Z_][a-zA-Z0-9_]*)(.*)$") {
                local orig     = regexs(1) // e.g., "weight"
                local modifier = trim(regexs(2)) // e.g., "/1000" or ""
                
                // Add base original variable to our list uniquely
                local orig_varlist : list orig_varlist | orig
                
                // Step 1: Format the substitution for X appropriately
                if "`modifier'" != "" {
                    // If there is scaling, wrap it in parentheses
                    local x_sub "(`x_def')" 
                }
                else {
                    // If no scaling, just use the variable name
                    local x_sub "`orig'" 
                }
                
                // Replace "X" with our formatted string in the formula
                local newlbl = subinstr("`formula'", "X", "`x_sub'", .)
                
                // Update the variable label
                label var `v' "`newlbl'"
            }
        }
    }
    
    // Step 2: Output the local macro as an rclass object
    return local varlist = "`orig_varlist'"
    
    // Step 3: Re-run the underlying mfp model
    local est_cmd = e(cmd)
    local dep_var = e(depvar)
    
    // Grab all current covariates 
    tempname b
    matrix `b' = e(b)
    local allvars : colnames `b'
    local allvars : list uniq allvars
    local cons "_cons"
    local allvars : list allvars - cons
    local othervars : list allvars - fpvars
    
    // Run the model without the mfp prefix, adding o.(`orig_varlist') 
	preserve
	qui keep if e(sample)
	local final_varlist = "o." + subinstr("`orig_varlist'", " ", " o.", .)
    `est_cmd' `dep_var' `othervars' `final_varlist' I*__?
    
    // Step 4: Declare transformed variables using f_able
    f_able, nlvar(I*__?)
    
    // Step 5 & Feature 2: Calculate marginal effects
    margins, dydx(`vars') nochain numerical `options'
    
	restore
end