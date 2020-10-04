{smcl}
{* *! version 1.0 Chao Wang 03/10/2020}{...}
{cmd:help rcstest}
{hline}

{title:Title}

{pstd}{hi:rcstest} {hline 2} A program to test the nonlinearity of variables 
in a model using restricted cubic spline

{title:Syntax}

{pstd}{cmd:rcstest} [{cmd:,} {it:options}]

{title:Description}

{pstd}{cmd:rcstest} compares a recent fitted model with linear predictors with 
a model using restricted cubic spline for each preditor.

{title:Options}

{pstd} Default options for knots used in {cmd:mkspline} were used. Alternatively
specify the knots options: {opt nk:nots} and {opt k:nots}.

{title:Author}

{pstd}Chao Wang, BEng MSc DIC PhD, Senior Lecturer, Kingston University and St George's, excelwang@gmail.com.
