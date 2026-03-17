*! version 1.0.0  16mar2026
program define mvrs_mfx, rclass
    version 19
    
    // Ensure the command is being run after an estimation command
    if "`e(cmd)'" == "" {
        di as error "This command must be run after an estimation command (like mvrs)."
        exit 301
    }

    // ----------------------------------------------------------------------
    // STEP 1: Identify all non-linear variables
    // ----------------------------------------------------------------------
    // Suppress output so ds doesn't print to the screen
    quietly ds *_?
    
    // Pass the matching variables to the custom command we built earlier
    get_base_vars `r(varlist)'
    
    // Note: Using "" instead of = prevents truncation if the list is very long
    local nonlinear_list "`r(baselist)'"

    // ----------------------------------------------------------------------
    // STEP 2: Capture dependent variable and original independent covariates
    // ----------------------------------------------------------------------
    // Grab the dependent variable from the stored estimation results
    local depvar "`e(depvar)'"
    
    // Grab all variables used in the regression from the estimation matrix (e(b))
    local model_vars : colnames e(b)
    
    // Remove the constant (_cons) from the list
    local cons "_cons"
    local model_vars : list model_vars - cons
    
    // Use get_base_vars to strip suffixes and leave only the original covariates
    qui get_base_vars `model_vars'
    local indvars "`r(baselist)'"

    // ----------------------------------------------------------------------
    // STEP 3: Create the linear variables list
    // ----------------------------------------------------------------------
    // Subtract the non-linear list from the total independent variables list
    local linear_list : list indvars - nonlinear_list

    // ----------------------------------------------------------------------
    // STEP 4: Calculate marginal effects for linear variables
    // ----------------------------------------------------------------------
    di as text ""
    di as text "============================================================"
    di as text "Calculating Margins for Linear Variables: `linear_list'"
    di as text "============================================================"
    
    if "`linear_list'" != "" {
        margins, dydx(`linear_list')
		qui etable, margins
    }
    else {
        di as text "No purely linear variables found in the model."
    }

    // ----------------------------------------------------------------------
    // STEP 5: Calculate marginal effects for non-linear variables
    // ----------------------------------------------------------------------
    di as text ""
    di as text "============================================================"
    di as text "Calculating Margins for Non-Linear Variables: `nonlinear_list'"
    di as text "============================================================"
    
    if "`nonlinear_list'" != "" {
        qui np_control, vars(`nonlinear_list')
        npregress series `depvar' `nonlinear_list', asis(_control) criterion(aic)
		qui etable, append
    }
    else {
        di as text "No non-linear variables found in the model."
    }
	
	qui collect layout (colname#result[_r_b _r_se]) (stars) ()
	collect title "Marginal effects"
	collect preview
    
    // Optional: Return lists in case the user wants to use them later
    return local linear_vars "`linear_list'"
    return local nonlinear_vars "`nonlinear_list'"
    return local depvar "`depvar'"
    
end