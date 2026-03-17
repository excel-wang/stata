*! version 1.0.0  16mar2026
program define get_base_vars, rclass
    version 14 // ustrregexra requires Stata 14 or later
    
    // Accept any list of words passed to the command
    syntax anything(name=mylist)
    
    // Initialize empty list
    local baselist ""
    
    // Loop and clean
    foreach v of local mylist {
        local base = ustrregexra("`v'", "_[0-9]+$", "")
        local baselist "`baselist' `base'"
    }
    
    // Remove duplicates
    local baselist : list uniq baselist
    
    // Return the clean list so the user can use it
    return local baselist "`baselist'"
    
    // Display the result to the console
    di as text "Base variables: " as result "`baselist'"
end