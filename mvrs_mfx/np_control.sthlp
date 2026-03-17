{smcl}
{* *! version 1.0.0  06mar2026}{...}
{viewerjumpto "Syntax" "np_control##syntax"}{...}
{viewerjumpto "Description" "np_control##description"}{...}
{viewerjumpto "Options" "np_control##options"}{...}
{viewerjumpto "Examples" "np_control##examples"}{...}
{title:Title}

{phang}
{bf:np_control} {hline 2} Calculates the linear prediction excluding specified variables of interest

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:np_control}{cmd:,} {opt vars(varlist)}

{marker description}{...}
{title:Description}

{pstd}
{cmd:np_control} is a post-estimation command that generates a new variable named {bf:_control}. 
This variable represents the full linear prediction (the fitted index) of the previously estimated model, 
minus the estimated contribution of the specific variables listed in the {opt vars()} option. 

{pstd}
For example, if your estimated regression model is {it:y = a + b1*x1 + b2*x2 + b3*x3}, and you 
specify {cmd:vars(x1)}, the resulting {bf:_control} variable will contain the values for {it:a + b2*x2 + b3*x3}.

{pstd}
This command is particularly useful after fitting models with non-linear effects, such as fractional 
polynomials using {cmd:mfp}. By isolating the linear effect of the background covariates into {bf:_control}, 
you can more easily plot or calculate the isolated marginal effects of your variables of interest.

{pstd}
{bf:Note:} {cmd:np_control} requires that an estimation command (like {cmd:regress}, {cmd:logit}, or {cmd:mfp}) 
has been run immediately prior. It will return an error if a variable named {bf:_control} already exists in your dataset.

{marker options}{...}
{title:Options}

{phang}
{opt vars(varlist)} is required. It specifies the list of numeric variables whose effects you want to subtract 
from the total linear prediction. 

{pmore}
{bf:Important:} If you used a transformation command like {cmd:mfp}, you must supply the exact names of the 
newly generated transformed variables (e.g., {bf:Iweight_1}, {bf:Iweight_2}) rather than the original untransformed variable name.

{marker examples}{...}
{title:Examples}

{pstd}Setup a basic dataset{p_end}
{phang2}{cmd:. sysuse auto, clear}{p_end}

{pstd}{bf:Example 1: Basic linear regression}{p_end}
{phang2}{cmd:. regress price mpg weight length}{p_end}

{pstd}Calculate the control prediction, isolating the effect of {cmd:mpg}{p_end}
{phang2}{cmd:. np_control, vars(mpg)}{p_end}

{pstd}Verify the result manually{p_end}
{phang2}{cmd:. generate manual_control = _b[_cons] + _b[weight]*weight + _b[length]*length}{p_end}
{phang2}{cmd:. compare _control manual_control}{p_end}


{pstd}{bf:Example 2: Using np_control after mfp}{p_end}
{pstd}Drop the previous _control variable first{p_end}
{phang2}{cmd:. drop _control}{p_end}

{pstd}Run a fractional polynomial regression{p_end}
{phang2}{cmd:. mfp: regress price mpg weight length}{p_end}

{pstd}Because {cmd:mfp} creates transformed variables, check your variable list for the new names 
(e.g., {cmd:Iweig__1}). Use these exact names in the vars() option. In this case weight is found to be non-linear.{p_end}
{phang2}{cmd:. np_control, vars(Iweig__1)}{p_end}
{phang2}{cmd:. npregress series price weight, asis(_control)}{p_end}
