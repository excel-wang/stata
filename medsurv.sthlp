{smcl}
{* *! version 1.0 Chao Wang 12/09/2017}{...}
{cmd:help medsurv}
{hline}

{title:Title}

{pstd}{hi:medsurv} {hline 2} Calculate the median survival time from Cox/Poisson
regression

{title:Syntax}

{pstd}{cmd:medsurv}{cmd:,} {opt id(varname)} {opt riskset(varname)}

{title:Description}

{pstd}{cmd:medsurv} calculates the median survival time from Cox/Poisson model. A
Poisson model must be fit before running this command (see below for an example).

{title:Options}

{pstd}{opt id(varname)} specifies the subject variable. {opt riskset(varname)} 
specifies the risk sets which can be generated from the {cmd:stsplit} (see below).

{title:Examples}

{phang}{stata "use http://www.stata-press.com/data/cggm3/hip2, clear": . use http://www.stata-press.com/data/cggm3/hip2, clear}{p_end}
{phang}{stata "stset time1, id(id) time0(time0) failure(fracture)": . stset time1, id(id) time0(time0) failure(fracture)}{p_end}
{phang}{stata "stsplit, at(failures) riskset(interval)": . stsplit, at(failures) riskset(interval)}{p_end}
{phang}{stata "generate time_exposed = _t - _t0": . generate time_exposed = _t - _t0}{p_end}
{phang}{stata "poisson _d ibn.interval protect age calcium, exposure(time_exposed) noconstant irr": . poisson _d ibn.interval protect age calcium, exposure(time_exposed) noconstant irr}{p_end}
{phang}{stata "medsurv, id(id) riskset(interval)": . medsurv, id(id) riskset(interval)}{p_end}

{title:Author}

{pstd}Chao Wang, BEng MSc DIC PhD, Statistician, Queen Mary University of London,
excelwang@gmail.com.
