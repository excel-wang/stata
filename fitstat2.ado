*! version 1.0, Chao Wang, 06/05/2022
program fitstat2, rclass

syntax varlist(min=2 numeric) [if] [in]

gettoken depvar indepvar : varlist
local varnum: word count `indepvar'

tempvar residual
tempname result
matrix `result'=J(`varnum',4,.)
matrix rownames `result'=`indepvar'
matrix colnames `result'="Mean AE" "Median AE" "RMSE" "sMAPE (%)"

qui gen `residual'=.
forvalues i = 1/`varnum' {
	local var2calc: word `i' of `indepvar'
	
	// MAE
	qui replace `residual'=abs(`depvar'-`var2calc')
	qui sum `residual' `if' `in', detail
	matrix `result'[`i',1]=r(mean)
	
	// Median AE
	matrix `result'[`i',2]=r(p50)
	
	// RMSE
	qui replace `residual'=(`depvar'-`var2calc')^2
	qui sum `residual'	`if' `in'
	matrix `result'[`i',3]=sqrt(r(mean))
	
	// sMAPE
	qui replace `residual'= 2*abs(`depvar'-`var2calc')/(abs(`depvar')+abs(`var2calc'))*100
	qui sum `residual' `if' `in'
	matrix `result'[`i',4]=r(mean)

}

* matrix list `result', noheader
local seps: di _dup(`varnum') "&"
matlist `result', cspec(& %12s | %9.4g & %9.4g & %9.4g & %9.4g o2&) rspec(&-`seps')

return matrix result `result'

end
