{smcl}
{* *! version 1.0.3  29may2026}{...}
{viewerjumpto "Syntax" "pairs_panels##syntax"}{...}
{viewerjumpto "Description" "pairs_panels##description"}{...}
{viewerjumpto "Options" "pairs_panels##options"}{...}
{viewerjumpto "Examples" "pairs_panels##examples"}{...}
{viewerjumpto "Stored results" "pairs_panels##results"}{...}
{viewerjumpto "Author" "pairs_panels##author"}{...}
{title:Title}

{phang}
{bf:pairs_panels} {hline 2} Scatterplot matrix with histograms, densities, and correlations (mimics R's psych::pairs.panels)


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:pairs_panels}
{varlist}
{ifin}
[{cmd:,} {it:options}]

{synoptset 22 tabbed}{...}
{synopthdr}
{synoptline}
{synopt:{opt smooth:ing(string)}}specify the smoothing line for scatterplots: {cmd:lowess} (default), {cmd:linear}, or {cmd:none}{p_end}
{synopt:{opt m:ethod(string)}}specify the correlation method: {cmd:pearson} (default) or {cmd:spearman}{p_end}
{synopt:{opt st:ars}}add statistical significance stars to correlation coefficients{p_end}
{synoptline}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
{cmd:pairs_panels} generates a comprehensive N x N scatterplot matrix for a specified list of numeric variables. It is designed to replicate the layout and functionality of the {cmd:pairs.panels} function from the {cmd:psych} package in R.

{pstd}
The resulting matrix figure displays:

{p 4 8 2} o Histograms overlaid with kernel density curves on the diagonal.{p_end}
{p 4 8 2} o Bivariate scatterplots below the diagonal, with optional lowess or linear smoothing lines.{p_end}
{p 4 8 2} o Correlation coefficients centrally scaled above the diagonal.{p_end}
{p 4 8 2} o Value labels properly formatted on the bottom and left-most axes to prevent crowding.{p_end}
{p 4 8 2} o Missing values are handled via listwise deletion based on the specified {it:varlist} and {it:if}/{it:in} conditions.{p_end}


{marker options}{...}
{title:Options}

{phang}
{opt smoothing(string)} determines the type of fit line overlaid on the sub-diagonal scatterplots. The default is {cmd:lowess}, which provides a locally weighted scatterplot smoothing curve in red. Alternatively, you can specify {cmd:linear} for a simple linear regression line, or {cmd:none} to omit the fit line entirely.

{phang}
{opt method(string)} specifies the type of correlation coefficient to calculate and display above the diagonal. The default is {cmd:pearson}. You can also specify {cmd:spearman} for Spearman's rank correlation.

{phang}
{opt stars} requests that statistical significance stars be appended to the displayed correlation coefficients. The significance levels are denoted as follows: {bf:***} for p < 0.001, {bf:**} for p < 0.01, and {bf:*} for p < 0.05.


{marker examples}{...}
{title:Examples}

{pstd}Setup: Load the built-in auto dataset{p_end}
{phang2}{stata "sysuse auto, clear"}{p_end}

{pstd}Basic usage with default options (Pearson correlations, lowess smoothing, no stars){p_end}
{phang2}{stata "pairs_panels price mpg weight length"}{p_end}

{pstd}Add significance stars to the correlation coefficients{p_end}
{phang2}{stata "pairs_panels price mpg weight length, stars"}{p_end}

{pstd}Use Spearman correlation and linear smoothing lines{p_end}
{phang2}{stata "pairs_panels price mpg weight length, method(spearman) smoothing(linear) stars"}{p_end}


{marker results}{...}
{title:Stored results}

{pstd}
As a graphical wrapper command, {cmd:pairs_panels} focuses strictly on generating visual output. It does not store any statistical results or matrix objects in {cmd:r()} (rclass) or {cmd:e()} (eclass) memory. 


{marker author}{...}
{title:Author}

{pstd}
Dr Chao Wang {break}
Associate Professor in Health & Social Care Statistics {break}
Kingston University {break}
{p_end}