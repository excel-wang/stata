*! version 1, Chao Wang, 17/07/2018
* plot Detrended Normal Q-Q Plot
program qnormdev

version 14.2
syntax varlist(max=1) [if] [in] [, *]
marksample touse

quietly count if `touse'
if `r(N)'==0 {
 error 2000
}

tempvar i pi qi dev

preserve
quietly keep if `touse'
sort `varlist'
gen `i'=_n
quietly count if !missing(`varlist')
gen `pi'=`i'/(r(N)+1)  /* the Weibull position */
gen `qi'=invnormal(`pi')

egen `varlist'_z=std(`varlist')
gen `dev'=`varlist'_z-`qi'
label variable `dev' "Deviation from normal"

* scatter qi `varlist'    /* Q-Q plot - similar to qnorm */
scatter `dev' `varlist', yline(0) `options'
restore

end
