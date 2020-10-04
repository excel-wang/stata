*! version 1.0, Chao Wang, 03/10/2020
program define rcs, rclass
	version 11
	syntax newvarlist(max=1)

	// get the original variable before transformation
	* local var "`: word 1 of `: rownames r(knots)''"
	local rownms: rowname r(knots)
	local var: word 1 of `rownms'

	local num=`r(N_knots)'-2
	local kn=r(knots)[1,`r(N_knots)']
	local kn1=r(knots)[1,`r(N_knots)'-1]
	local k1=r(knots)[1,1]
	matrix knots=r(knots)

	drop `varlist'*
	fgen `varlist'1=`var'
	forvalues i=1/`num' {
		local j=`i'+1
		local ki=knots[1,`i']

		fgen `varlist'`j'=(max((`var'-`ki'),0)^3 - (`kn'-`kn1')^(-1)* /// 
			(max((`var'-`kn1'),0)^3 * (`kn'-`ki') - ///
			max((`var'-`kn'),0)^3 * (`kn1'-`ki'))) ///
			/ (`kn'-`k1')^2
	}

	di "Use this command to set up the f_able after running an estimation model: f_able, nlvar(`varlist'*)"
	return local f_able="f_able, nlvar(`varlist'*)"

end