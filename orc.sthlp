{smcl}
{* *! version 1.0 Chao Wang 27/05/2022}{...}
{cmd:help orc}
{hline}

{title:Title}

{pstd}{hi:orc} {hline 2} This command calculates the ordinal c-index (ORC).

{title:Syntax}

{pstd}{cmd:orc} {varlist} {ifin}

{title:Description}

{pstd}
{cmd:orc} 
calculates the ordinal c-index (ORC), proposed by Van Calster et al. (2012). The {varlist}  
must include two variables: the outcome variable as the first variable with outcome categories in the format of 1, 2, 3... etc. This is followed by the linear prediction (xb).

{title:Examples}

{phang}{stata "webuse fullauto, clear": . webuse fullauto, clear}{p_end}
{phang}{stata "ologit rep77 foreign length mpg": . ologit rep77 foreign length mpg}{p_end}
{phang}{stata "predict pr_xb, xb": . predict pr_xb, xb}{p_end}
{phang}{stata "orc rep77 pr_xb": . orc rep77 pr_xb}{p_end}

{title:Reference}

{pstd} Van Calster, B., Van Belle, V., Vergouwe, Y. and Steyerberg, E.W. (2012), Discrimination ability of prediction models for ordinal outcomes: Relationships between existing measures and a new measure. Biom. J., 54: 674-685. https://doi.org/10.1002/bimj.201200026
{p_end}

{title:Author}

{pstd} Chao Wang, BEng MSc DIC PhD, Senior Lecturer at Kingston University, UK. Email: excelwang@gmail.com.
{p_end}