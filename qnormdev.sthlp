{smcl}
{* *! version 1 Chao Wang 17/07/2018}{...}
{cmd:help qnormdev}
{hline}

{title:Title}

{pstd}{hi:qnormdev} {hline 2} Detrended Normal Q-Q Plot

{title:Syntax}

{pstd}{cmd:qnormdev} {varname} {ifin} [{cmd:,} {it:options}]

{title:Description}

{pstd} This program draws Detrended Normal Q-Q Plot as in SPSS.

{title:Options}

{pstd} Options for {cmd:scatter} can be used.

{title:Examples}

{phang}{stata "sysuse auto": . sysuse auto}{p_end}
{phang}{stata "qnormdev price": . qnormdev price}{p_end}

{title:Author}

{pstd}Chao Wang, BEng MSc DIC PhD, Senior Lecturer in Health & Social Care Statistic, Faculty of Health, Social Care and Education,
Kingston University and St George's, University of London, excelwang@gmail.com.

{pstd} Please cite this program if used in your research.
