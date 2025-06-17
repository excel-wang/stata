# Stata tools
Some useful Stata programs developed by the author. Some of these programs are available at SSC. In Stata, type: ssc describe *commandname*.

## Installtion:
Type the following within Stata and follow the instructions (replace _commandname_ to the command you would like to install):
```stata
net describe commandname, from(https://raw.githubusercontent.com/excel-wang/stata/master/)
```
- medsurv: Calculate the median survival time from Cox/Poisson regression
- fscore: Calculate F-score
- lrtest2: Likelihood-ratio test for each individual covariate after a regression
- qnormdev: Detrended Normal Q-Q Plot
- geninteract: Generate N-way interaction terms
- rcs: A program to convert the mkspline generated variables
- rcstest: A program to test the nonlinearity of variables in a model using restricted cubic spline
- fitstat2: calculates a series of model goodness-of-fit measures, including mean absolute error (MAE), median absolute error (median AE), root mean squared error (RMSE), and symmetric mean absolute percentage error (sMAPE).
- pdi: calculates the polytomous discrimination index (PDI).
- orc: calculates the ordinal c-index (ORC).
- tmle: Targeted maximum likelihood estimation
