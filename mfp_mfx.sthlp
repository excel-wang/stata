{smcl}
{* *! version 1.0.1  09mar2026}{...}
{vieweralsosee "[R] margins" "mansection R margins"}{...}
{vieweralsosee "mfp" "help mfp"}{...}
{vieweralsosee "f_able" "help f_able"}{...}
{viewerjumpto "Syntax" "mfp_mfx##syntax"}{...}
{viewerjumpto "Description" "mfp_mfx##description"}{...}
{viewerjumpto "Options" "mfp_mfx##options"}{...}
{viewerjumpto "Examples" "mfp_mfx##examples"}{...}
{viewerjumpto "Saved results" "mfp_mfx##saved_results"}{...}
{viewerjumpto "Author" "mfp_mfx##author"}{...}
{title:Title}

{phang}
{bf:mfp_mfx} {hline 2} Calculate marginal effects after multivariable fractional polynomial (mfp) models using f_able


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:mfp_mfx}
[{cmd:,}
{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt vars(varlist)}}specify variables for which marginal effects are to be calculated; default is all covariates ({cmd:vars(*)}){p_end}
{synopt:{it:margins_options}}any additional options valid for the {helpb margins} command (e.g., {opt post}){p_end}
{synoptline}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
{cmd:mfp_mfx} is a post-estimation command designed to seamlessly calculate marginal effects for non-linear models fitted using Stata's {helpb mfp} prefix, leveraging the {helpb f_able} package. 

{pstd}
When {cmd:mfp} fits a model, it creates transformed variables (e.g., {cmd:Iweig__1}) and stores the fractional polynomial formulas in their variable labels (e.g., {cmd:X^3: X = weight/1000}). It may be essential to specify {opt center(no)} option 
as otherwise f_able may report error ("The function stored in label or note for variable ... does not reproduce the original variable please verify that information is correct"). 

{pstd}
{cmd:mfp_mfx} automates the following steps:
{break}1. Parses the variable labels of the transformed variables to extract the original variable names and any scaling factors.
{break}2. Updates the variable labels to mathematically standard formulas (e.g., {cmd:(weight/1000)^3}).
{break}3. Re-runs the underlying estimation command without the {cmd:mfp} prefix, safely injecting the original un-transformed variables as omitted base variables ({cmd:o.varname}) alongside the transformed variables.
{break}4. Initializes the transformed variables for marginal effect calculation using {cmd:f_able, nlvar()}.
{break}5. Calculates the marginal effects using {cmd:margins, nochain numerical}.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt vars(string)} allows you to specify a subset of variables for which the marginal effects ({cmd:dydx}) should be calculated. By default, {cmd:mfp_mfx} calculates marginal effects for all covariates in the model (equivalent to {cmd:vars(*)}).

{phang}
{it:margins_options} allows you to pass any valid options directly to the underlying {cmd:margins} command. For example, specifying {cmd:post} will cause {cmd:margins} to post its results to {cmd:e()}, allowing you to use commands like {cmd:lincom} or {cmd:test} afterward.


{marker examples}{...}
{title:Examples}

{pstd}Setup using standard Stata dataset{p_end}
{phang2}{stata "sysuse auto, clear"}{p_end}

{pstd}Fit an mfp model (mpg and weight with fractional polynomials){p_end}
{phang2}{stata "mfp, center(no): regress price weight mpg"}{p_end}

{pstd}Calculate marginal effects for all covariates{p_end}
{phang2}{stata "mfp_mfx"}{p_end}

{pstd}Calculate marginal effects for 'weight' only{p_end}
{phang2}{stata "margins, dydx(weight) nochain numerical"}{p_end}

{pstd}Calculate marginal effects for 'weight' and 'mpg', and post results{p_end}
{phang2}{stata "margins, dydx(weight mpg) nochain numerical post"}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:mfp_mfx} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(varlist)}}list of the original (untransformed) fractional polynomial variables detected in the model{p_end}
{p2colreset}{...}


{marker author}{...}
{title:Author}

{pstd}Dr Chao Wang{p_end}
{pstd}Associate Professor in Health & Social Care Statistics{p_end}
{pstd}Kingston University{p_end}
