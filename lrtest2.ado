*! version 1.0, Chao Wang, 15/03/2018
program lrtest2, eclass

version 14.2
syntax
preserve
quietly keep if e(sample)

estimate store full

local cmdline=e(cmdline)
local cmd=e(cmd)
local varlist: list cmdline-cmd
gettoken depvar indepvar : varlist
gettoken indepvar : indepvar, parse(",") // remove options in cmdline
fvrevar `indepvar', list
local varnum: word count `r(varlist)'
local newvarlist="`r(varlist)'"

tempname result
tempvar constant
matrix `result'=J(`varnum',3,.)
matrix rownames `result'=`newvarlist'
matrix colnames `result'="LR-chi2" "df" "p-value"

gen `constant'=1
forvalues i = 1/`varnum' {
 local var2remove: word `i' of `newvarlist'
 local restricted_model: subinstr local cmdline "`var2remove'" "`constant'", all
 quietly `restricted_model'
 quietly lrtest . full
 matrix `result'[`i',1]=r(chi2)
 matrix `result'[`i',2]=r(df)
 matrix `result'[`i',3]=r(p)
 // di "p-value of `var2remove' =" r(p)
}
ereturn clear

matrix list `result', noheader
matrix `result'=`result''
ereturn matrix result `result'
ereturn local cmd="lrtest2"
restore
end
