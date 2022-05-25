{smcl}
{* *! version 1.0 Chao Wang 06/05/2022}{...}
{cmd:help fitstat2}
{hline}

{title:Title}

{pstd}{hi:fitstat2} {hline 2} This command calculates a series of model goodness-of-fit measures.

{title:Syntax}

{pstd}{cmd:fitstat2} {varlist}

{title:Description}

{pstd}{cmd:fitstat2} calculates a series of model goodness-of-fit measures, including mean absolute error (MAE), median absolute error (median AE), root mean squared error (RMSE), symmetric mean absolute percentage error (sMAPE, see Makridakis et             al., 2020). The first variable in the {varlist} will be compared with the rest of variables.
{p_end}

{title:Examples}

{phang}{stata "sysuse auto, clear": . sysuse auto, clear}{p_end}
{phang}{stata "reg price mpg": . reg price mpg}{p_end}
{phang}{stata "predict yhat1": . predict yhat1}{p_end}
{phang}{stata "reg price mpg i.foreign": . reg price mpg i.foreign}{p_end}
{phang}{stata "predict yhat2": . predict yhat2}{p_end}
{phang}{stata "fitstat2 price yhat1 yhat2": . fitstat2 price yhat1 yhat2}{p_end}

{title:Reference}

{pstd} Makridakis, S., Spiliotis, E., & Assimakopoulos, V. (2020). The M4 Competition: 100,000 time series and 61 forecasting methods. International Journal of Forecasting, 36(1). https://doi.org/10.1016/j.ijforecast.2019.04.014 
{p_end}

{title:Author}
{pstd} Chao Wang, BEng MSc DIC PhD, Senior Lecturer, Kingston University and St George's, excelwang@gmail.com.
{p_end}