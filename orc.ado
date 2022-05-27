*! version 1.0, Chao Wang, 27/05/2022
* calculates ordinal c-index (ORC)
* see: Van Calster, B., Van Belle, V., Vergouwe, Y. and Steyerberg, E.W. (2012), Discrimination ability of prediction models for ordinal outcomes: Relationships between existing measures and a new measure. Biom. J., 54: 674-685. https://doi.org/10.1002/bimj.201200026
program orc, rclass

syntax varlist(min=2 max=2 numeric) [if] [in]
marksample touse

quietly count if `touse'
if `r(N)'==0 {
 error 2000
}

gettoken depvar indepvar : varlist

tempvar outcome
qui tab `depvar', gen(__outcome)
local num_levels=r(r)

local orc=0
local n=0
forvalues i = 1/`num_levels' {
	forvalues j = 1/`num_levels' {
		if `j'>`i' {
			qui roctab __outcome`j' `indepvar' if (`depvar'==`i' | `depvar'==`j') & `touse'
			local orc=`orc'+`r(area)'
			local n=`n'+1
		}
	} 
}

di as text "The ordinal c-index (ORC) = " as result %5.3f `orc'/`n'
return scalar orc=`orc'/`n'

drop __outcome*

end
