*! version 1.0, Chao Wang, 03/10/2020
program rcstest, rclass

version 16
syntax [,*]
preserve
quietly keep if e(sample)

estimate store original
local N=e(N)

local cmdline=e(cmdline)
local cmd=e(cmd)
local varlist: list cmdline-cmd
gettoken depvar indepvar : varlist
gettoken indepvar : indepvar, parse(",") // remove options in cmdline
fvrevar `indepvar', list
local varnum: word count `r(varlist)'
local newvarlist="`r(varlist)'"

tempname result
matrix `result'=J(`varnum',6,.)
matrix rownames `result'=`newvarlist'
matrix colnames `result'="LR-chi2" "df" "p-value" "ΔAIC" "ΔBIC" "p best model"

forvalues i = 1/`varnum' {
 local var2remove: word `i' of `newvarlist'
 local newmodel: subinstr local cmdline "`var2remove'" "_sp*", all
 capture qui mkspline _sp = `var2remove', cubic `options'
 if _rc==0 {
	capture quietly `newmodel'
	if _rc==0 {
	quietly lrtest . original
	matrix `result'[`i',1]=r(chi2)
	matrix `result'[`i',2]=r(df)
	matrix `result'[`i',3]=r(p)
	matrix `result'[`i',4]=-r(chi2)+2*r(df)
	matrix `result'[`i',5]=-r(chi2)+ln(`N')*r(df)
	matrix `result'[`i',6]=exp(-0/2)/(exp(-0/2)+exp(-abs(-r(chi2)+ln(`N')*r(df))/2))
	// di "p-value of `var2remove' =" r(p) 
	}
 }
 capture drop _sp*

}
ereturn clear

* matrix list `result', noheader
local seps: di _dup(`varnum') "&"
matlist `result', cspec(& %12s | %9.4g & %5.0g & %9.4g & %9.4g & %9.4g & %12.4g o2&) rspec(&-`seps')

di ""
di "ΔAIC/ΔBIC: change in AIC/BIC after using the restricted cubic spline"
di "p best model: probability of the best model (i.e. null if ΔBIC>0)."
matrix `result'=`result''
return matrix result `result'

restore
end
