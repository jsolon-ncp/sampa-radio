
*--- v4 works. Fecal Elastase

kwallis fecal_elastase, by(ever_mal) 
mystats

local chi2 = string(r(Chi2), "%4.2f")
local p = string(r(p), "%4.3f")
local grtitle : variable label fecal_elastase

gr box fecal_elastase, over(ever_mal) title("`grtitle'") subtitle("All cohorts") ///
        xsize(10) ysize(8) ///
        marker(1, msize(vsmall)) ///
        medline(lwidth(thin)) ///
		text(620 5 "Chi2 = `chi2'" "p = `p'", size(vsmall) just(left)) 
		
		
*--- v4 works. Amylase

kwallis ul_amylp, by(ever_mal) 
mystats

local chi2 = string(r(Chi2), "%4.2f")
local p = string(r(p), "%4.3f")
local grtitle : variable label ul_amylp

gr box ul_amylp, over(ever_mal) title("`grtitle'") subtitle("All cohorts") ///
        xsize(10) ysize(8) ///
        marker(1, msize(vsmall)) ///
        medline(lwidth(thin)) ///
		text(150 5 "Chi2 = `chi2'" "p = `p'", size(vsmall) just(left)) 

*--- v4 works. LIPASE 

kwallis lipase, by(ever_mal) 
mystats

local chi2 = string(r(Chi2), "%4.2f")
local p = string(r(p), "%4.3f")
local grtitle : variable label lipase

gr box lipase, over(ever_mal) title("`grtitle'") subtitle("DIVIDS only") ///
        xsize(10) ysize(8) ///
        marker(1, msize(vsmall)) ///
        medline(lwidth(thin)) ///
		text(60 5 "Chi2 = `chi2'" "p = `p'", size(vsmall) just(left)) 
		

*--- v4 works. Trypsinogen
 
kwallis ngml_trypsinogen, by(ever_mal) 
mystats

local chi2 = string(r(Chi2), "%4.2f")
local p = string(r(p), "%4.3f")
local grtitle : variable label ngml_trypsinogen

gr box ngml_trypsinogen, over(ever_mal) title("`grtitle'") subtitle("CT Scan subset") ///
        xsize(10) ysize(8) ///
        marker(1, msize(vsmall)) ///
        medline(lwidth(thin)) ///
		text(250 5 "Chi2 = `chi2'" "p = `p'", size(vsmall) just(left)) 

gr export ./figures/figc_a.png, as(png) replace
set scheme tab2
