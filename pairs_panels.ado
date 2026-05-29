*! version 1.0.3
*! A program to mimic R's psych::pairs.panels in Stata
program define pairs_panels
    version 14.0
    syntax varlist(numeric min=2) [if] [in] [, ///
        SMOOTHing(string) /// Options: lowess (default), linear, or none
        Method(string)    /// Options: pearson (default) or spearman
        STars             /// Adds significance stars
        ]

    if "`smoothing'" == "" local smoothing "lowess"
    if "`method'" == "" local method "pearson"

    marksample touse
    
    local nvars : word count `varlist'
    local graphs ""

    forvalues i = 1/`nvars' {
        local yvar : word `i' of `varlist'
        
        forvalues j = 1/`nvars' {
            local xvar : word `j' of `varlist'
            local gname "g_`i'_`j'"

            // --- Axis Label Logic ---
            // Y-axis labels only for the leftmost column, rotated vertically
            if `j' == 1 local ylab "ylabel(#4, nogrid angle(vertical))"
            else local ylab "ylabel(, nolabels nogrid)"
            
            // X-axis labels only for the bottom row
            if `i' == `nvars' local xlab "xlabel(#4, nogrid)"
            else local xlab "xlabel(, nolabels nogrid)"

            // --- DIAGONAL: Histograms ---
            if `i' == `j' {
                twoway (histogram `xvar' if `touse', density fcolor(cyan%80) lcolor(black)) ///
                       (kdensity `xvar' if `touse', lcolor(black)), ///
                       legend(off) ytitle("") xtitle("") ///
                       title("`xvar'", size(medsmall) color(black)) ///
                       `ylab' `xlab' ///
                       nodraw name(`gname', replace)
            }
            
            // --- BELOW DIAGONAL: Scatter plots ---
            else if `i' > `j' {
                local plotstr "(scatter `yvar' `xvar' if `touse', mcolor(black) msize(vsmall))"
                
                if "`smoothing'" == "linear" {
                    local plotstr "`plotstr' (lfit `yvar' `xvar' if `touse', lcolor(red))"
                }
                else if "`smoothing'" == "lowess" {
                    local plotstr "`plotstr' (lowess `yvar' `xvar' if `touse', lcolor(red))"
                }
                
                twoway `plotstr', legend(off) ytitle("") xtitle("") ///
                       `ylab' `xlab' ///
                       nodraw name(`gname', replace)
            }
            
            // --- ABOVE DIAGONAL: Correlation Coefficients ---
            else {
                if "`method'" == "spearman" {
                    quietly spearman `yvar' `xvar' if `touse'
                    local rho = r(rho)
                    local pval = r(p)
                }
                else {
                    quietly pwcorr `yvar' `xvar' if `touse', sig
                    tempname Cmat Smat
                    matrix `Cmat' = r(C)
                    matrix `Smat' = r(sig)
                    local rho = `Cmat'[2,1]
                    local pval = `Smat'[2,1]
                }

                local rhostr = string(`rho', "%4.2f")
                local starstr ""
                
                if "`stars'" != "" {
                    if `pval' < 0.001 local starstr "***"
                    else if `pval' < 0.01 local starstr "**"
                    else if `pval' < 0.05 local starstr "*"
                }

                twoway (scatteri 0 0 "`rhostr'`starstr'", msymbol(i) mlabpos(0) mlabsize(huge) mlabcolor(black)), ///
                       legend(off) ytitle("") xtitle("") ///
                       yscale(off) xscale(off) ///
                       ylabel(, nolabels nogrid) xlabel(, nolabels nogrid) /// Keep correlation panels blank
                       nodraw name(`gname', replace)
            }
            
            local graphs "`graphs' `gname'"
        }
    }

    graph combine `graphs', rows(`nvars') cols(`nvars') imargin(zero) graphregion(color(white))

    graph drop `graphs'
end