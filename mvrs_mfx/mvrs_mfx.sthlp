{smcl}
{* *! version 1.0.0 16mar2026}{...}
{vieweralsosee "[R] margins" "help margins"}{...}
{vieweralsosee "[R] npregress" "help npregress"}{...}
{viewerjumpto "Syntax" "mvrs_mfx##syntax"}{...}
{viewerjumpto "Description" "mvrs_mfx##description"}{...}
{viewerjumpto "Examples" "mvrs_mfx##examples"}{...}
{viewerjumpto "Stored results" "mvrs_mfx##results"}{...}
{viewerjumpto "Author" "mvrs_mfx##author"}{...}
{title:Title}

{phang}
{bf:mvrs_mfx} {hline 2} Calculate marginal effects after a spline model using the mvrs command


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:mvrs_mfx}

{pstd}
{cmd:mvrs_mfx} requires the user-written commands {cmd:mvrs}, {cmd:get_base_vars} and {cmd:np_control} to be installed. It must be run immediately following an estimation command.


{marker description}{...}
{title:Description}

{pstd}
{cmd:mvrs_mfx} is a post-estimation command designed to automate the calculation of marginal effects after fitting a model with non-linear effects using the {cmd:mvrs} (multivariable regression splines) command. 

{pstd}
The {cmd:mvrs} command saves variables with non-linear effects using a specific suffix format (e.g., {it:varname_1}, {it:varname_2}). {cmd:mvrs_mfx} automatically parses the variables used in the preceding model, identifies which are purely linear and which are non-linear transformations, and calculates their respective marginal effects.

{pstd}
Specifically, the command performs the following routine:
{break}1. Calculates marginal effects for purely linear variables using standard {helpb margins:margins, dydx()}.
{break}2. Calculates marginal effects for non-linear variables using the non-parametric {helpb npregress} series command, mediated by {cmd:np_control}.


{marker examples}{...}
{title:Examples}

{pstd}
Note: The following examples assume that {cmd:mvrs} and {cmd:get_base_vars} are installed. Click the commands below to run them in your Stata command window.

{pstd}Setup: Load the auto dataset{p_end}
{phang2}{stata "sysuse auto, clear":. sysuse auto, clear}{p_end}

{pstd}Fit a multivariable regression spline model predicting price{p_end}
{phang2}{stata "mvrs regress price weight mpg foreign":. mvrs regress price weight mpg foreign}{p_end}

{pstd}Calculate marginal effects automatically{p_end}
{phang2}{stata "mvrs_mfx":. mvrs_mfx}{p_end}


{marker results}{...}
{title:Stored results}

{pstd}
{cmd:mvrs_mfx} stores the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:r(depvar)}}Name of the dependent variable from the estimation model{p_end}
{synopt:{cmd:r(linear_vars)}}List of purely linear independent variables{p_end}
{synopt:{cmd:r(nonlinear_vars)}}List of non-linear base variables{p_end}
{p2colreset}{...}


{marker author}{...}
{title:Author}

{pstd}
Dr Chao Wang {break}
Associate Professor in Health & Social Care Statistics {break}
Kingston University {break}