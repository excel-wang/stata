{smcl}
{* *! version 1.0 Chao Wang 10/03/2014}{...}
{cmd:help fscore}
{hline}

{title:Title}

{pstd}{hi:fscore} {hline 2} Calculate F-score

{title:Syntax}

{pstd}{cmd:fscore} {depvar} {indepvars} {ifin} [{cmd:,} beta({it:real}{cmd:)}]

{pstd}{cmd:by} is allowed

{title:Description}

{pstd}{cmd:fscore} calculate the F-score ({browse "http://en.wikipedia.org/wiki/F_score":http://en.wikipedia.org/wiki/F_score}). 
The {depvar} indicates the actual outcome; while {indepvars} are classifiers. For both
{depvar} and {indepvars}, 0/1 coding is required. Multiple {indepvars} are allowed.

{title:Options}

{phang}{opt beta(real)} specifies the beta value. The default is 1.

{title:Examples}

{phang}{stata "webuse lbw, clear": . webuse lbw, clear}{p_end}
{phang}{stata "logit low age lwt i.race smoke ptl ht ui": . logit low age lwt i.race smoke ptl ht ui}{p_end}
{phang}{stata "predict p": . predict p}{p_end}
{phang}{stata "gen p_outcome=(p>0.5) if !missing(p)": . gen p_outcome=(p>0.5) if !missing(p)}{p_end}
{phang}{stata "fscore low p_outcome": . fscore low p_outcome}{p_end}

{title:Author}

{pstd}Chao Wang, BEng MSc DIC PhD, Research Statistician, University of Oxford,
excelwang@gmail.com.
