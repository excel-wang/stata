*! version 1.0, Chao Wang, 10/03/2014
program fscore, rclass byable(recall)

version 13.1
syntax varlist(min=2 numeric) [if] [in] [, beta(real 1)]
marksample touse, novarlist

quietly count if `touse'
if `r(N)'==0 {
 error 2000
}

local depvar: word 1 of `varlist'  // actual outcome
local indepvar: list varlist-depvar  // predicted outcomes
tempname precision recall tp fp fn tn fscore

foreach i in `indepvar' {
 quietly count if `depvar'==1 & `i'==1 & `touse'
 scalar `tp' = r(N)
 quietly count if `depvar'==1 & `i'==0 & `touse'
 scalar `fn'=r(N)
 quietly count if `depvar'==0 & `i'==1 & `touse'
 scalar `fp'=r(N)
 quietly count if `depvar'==0 & `i'==0 & `touse'
 scalar `tn'=r(N)
 
 scalar `precision'=`tp'/(`tp'+`fp')
 scalar `recall'=`tp'/(`tp'+`fn')
 
 scalar `fscore' = (1+`beta'^2)*`precision'*`recall'/((`beta'^2*`precision')+`recall')
 return scalar fscore = `fscore'
 
 display as text _dup(36) "-"
 display as result "Classifier: `i'"
 display "N = " `tp'+`fp'+`fn'+`tn'
 display "Precision: " `precision'
 display "Recall: " `recall'
 display "F`beta' score: " `fscore'
}

end
