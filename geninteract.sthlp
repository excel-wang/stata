{smcl}
{* *! version 1.0 Chao Wang 27/09/2018}{...}
{cmd:help geninteract}
{hline}

{title:Title}

{pstd}{hi:geninteract} {hline 2} Generate N-way interaction terms

{title:Syntax}

{pstd}{cmd:geninteract} {varlist} [{cmd:,} {opt n(integer)} {opt s:eparate(string)} {opt max(integer)}]

{title:Description}

{pstd}{cmd:geninteract} generates N-way interaction terms for variables in {varlist}.

{pstd} While this program works for any numerical {varlist}, it is particularly
useful for polynomials. It has recently been shown that neural networks
(NNs) are essentially polynomial regression models and the latter has advantages
such as fewer turning parameters and convergence issues. While polynomial terms for an
individual variable can be generated fairly easily using {cmd:fp generate} in Stata,
it is less straightforward to generate interaction terms, especially for
large number of predictor variables. This program aims to facilitate this by quickly
generating interactions with desired level of complexity.

{title:Options}

{pstd}{opt n(integer)} specifies N-way interactions; the default is 2. 
{opt s:eparate(string)} specifies separator to serve as punctuation between 
original variable names; the default is "_".

{pstd}{opt max(integer)} may only be used for polynomial terms generated by 
{cmd:fp generate}, i.e. {it:term}_# ({it:term}_1, {it:term}_2...). It specifies
the maximum of total # in an interaction. This option is useful to restrict the
number of output interaction terms by controlling the degree of the terms (see
the example below. For irregular set of powers one however must be careful to 
choose an appropriate value for this option). Specifying this option also removes
those that are not actual interactions in the case of multiple polynomial 
variables in {varlist} (e.g. {it:term}_1*{it:term}_2). The value of {opt max} 
must be positive otherwise this option has no effect.

{title:Examples}

{pstd} As a simple illustration, the following generates polynomial terms of degree
three from two predictor variables as described by Cheng et al. (2018) (page 24).

{phang}{stata "sysuse auto, clear": . sysuse auto, clear}{p_end}
{phang}{stata "fp generate mpg^(1/3), scale": . fp generate mpg^(1/3), scale}{p_end}
{phang}{stata "fp generate headroom^(1/3), scale": . fp generate headroom^(1/3), scale}{p_end}
{phang}{stata "geninteract mpg_* headroom_*, max(3)": . geninteract mpg_* headroom_*, max(3)}{p_end}

{title:Reference}

{pstd} Cheng, X., Khomtchouk, B., Matloff, N., & Mohanty, P. (2018). Polynomial Regression As an Alternative to Neural Nets. Retrieved from https://arxiv.org/abs/1806.06850v2.

{pstd} Also see their presentation: http://heather.cs.ucdavis.edu/polygrail.pdf

{title:Author}

{pstd}Chao Wang, BEng MSc DIC PhD, Senior Lecturer in Health & Social Care Statistic, Faculty of Health, Social Care and Education,
Kingston University and St George's, University of London, excelwang@gmail.com.