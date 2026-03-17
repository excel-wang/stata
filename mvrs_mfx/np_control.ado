*! version 1.0.0
*! Calculates linear prediction excluding specified variables of interest

program define np_control
    version 19.0 // Compatible with Stata 12 and newer

    // 1) Define the syntax: requires the 'vars' option with a numeric varlist
    syntax , vars(varlist numeric)

    // Ensure the command is being run after a model has been estimated
    if "`e(cmd)'" == "" {
        display as error "np_control must be run after an estimation command."
        exit 301
    }

    // 2) Check if _control already exists to prevent accidental overwrites
    capture confirm new variable _control
    if _rc {
        display as error "Variable _control already exists. Please drop or rename it before proceeding."
        exit 110
    }

    // Generate a temporary variable for the full linear prediction (a + b1*x1 + b2*x2...)
    tempvar full_xb
    quietly predict double `full_xb', xb

    // Initialize the new _control variable
    quietly generate double _control = `full_xb'

    // Loop through the variables specified in the vars() option
    foreach v in `vars' {
        // Capture checks if the variable actually has an estimated coefficient in the model
        capture local coef = _b[`v']
        
        if _rc == 0 {
            // Subtract the specific variable's contribution from the total prediction
            quietly replace _control = _control - (`coef' * `v')
        }
        else {
            // Provide a warning if the user includes a variable not found in the model
            display as text "Warning: `v' not found in the model's coefficients. It may have been dropped or omitted."
        }
    }

    display as text "Variable {bf:_control} successfully generated."
end