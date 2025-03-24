/* figc_all_enzymes.do 
Sampa
J Solon
March 20 2025

Creates Fig
local fig3 "./figures/fe1_coh_mn.png"
local fig3head "Figure 3 Faecal elastase distribution by cohort and malnutrition status."

local fig3text "a) axial anterior-posterior and transverse head diameters, b) coronal cranio-caudal head diameter, c) coronal cranio-caudal body diameters, d) axial anterior-posterior body and tail diameters, body, and d) length of body and tail."

schemename Foreground s2color color
s2mono monochrome s2gcolor color s2manual monochrome s2gmanual monochrome
For instance, you might type
Background
white white white white white

s1 family s1rcolor
  s1color
  s1mono
  s1manual
Foreground
color
color monochrome monochrome
Background
black white white white
set scheme tab2
set scheme stmono
set scheme sj
set scheme stcolor 

sj
*/

cap prog drop mystats
program mystats, rclass
return scalar p_adj= chi2tail(r(df), r(chi2_adj))
return scalar Chi2_adj =  r(chi2_adj)
return scalar  DF =  r(df)
return scalar p= chi2tail(r(df), r(chi2))
return scalar  Chi2 =   r(chi2)
end

set scheme stsj

		
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


		
local enzymes "fecal_elastase ul_amylp ngml_trypsinogen"  
foreach var of varlist `enzymes' {
	 local grtitle : variable label `var'
	 local volabel : variable label ct_pan_vol
	 local mallabel : value label ever_mal
	 scatter `var' ct_pan_vol if ever_mal==0, msymbol(circle) mcolor(blue) || ///
	 scatter `var' ct_pan_vol if ever_mal==1, msymbol(diamond) mcolor(red) ///
	 title("`grtitle' vs `volabel'") ///
	 legend(order(1 "`:label (`mallabel') 0'" 2 "`:label (`mallabel') 1'"))
}

set scheme tab2

* FE-1 scatter

spearman fecal_elastase ct_pan_vol
local rho = string(r(rho), "%4.2f")
local p = string(r(p), "%4.3f")

scatter fecal_elastase ct_pan_vol if ever_mal==0, msymbol(circle) mcolor(blue) || ///
scatter fecal_elastase ct_pan_vol if ever_mal==1, msymbol(diamond) mcolor(red) ///
legend(order(1 "`:label (ever_mal) 0'" 2 "`:label (ever_mal) 1'")) ///
       text(200 150 "ρ = `rho'" "p = `p'", size(vsmall) just(left)) 

* Amylase scatter
	   
spearman ul_amylp ct_pan_vol
local rho = string(r(rho), "%4.2f")
local p = string(r(p), "%4.3f")

scatter ul_amylp ct_pan_vol if ever_mal==0, msymbol(circle) mcolor(blue) || ///
scatter ul_amylp ct_pan_vol if ever_mal==1, msymbol(diamond) mcolor(red) ///
legend(order(1 "`:label (ever_mal) 0'" 2 "`:label (ever_mal) 1'")) ///
       text(150 150 "ρ = `rho'" "p = `p'", size(vsmall) just(left)) 

* Trypsinogen scatter

spearman ngml_trypsinogen ct_pan_vol
local rho = string(r(rho), "%4.2f")
local p = string(r(p), "%4.3f")

scatter ngml_trypsinogen ct_pan_vol if ever_mal==0, msymbol(circle) mcolor(blue) || ///
scatter ngml_trypsinogen ct_pan_vol if ever_mal==1, msymbol(diamond) mcolor(red) ///
legend(order(1 "`:label (ever_mal) 0'" 2 "`:label (ever_mal) 1'")) ///
text(200 150 "ρ = `rho'" "p = `p'", size(vsmall) just(left)) 

* Lipase scatter

spearman lipase pan_head_ap
local rho = string(r(rho), "%4.2f")
local p = string(r(p), "%4.3f")

local liplabel : variable label lipase
local headlabel : variable label pan_head_ap
scatter lipase pan_head_ap if ever_mal==0, msymbol(circle) mcolor(blue) || ///
scatter lipase pan_head_ap if ever_mal==1, msymbol(diamond) mcolor(red) ///
title("`liplabel' vs `headlabel'") ///
legend(order(1 "`:label (ever_mal) 0'" 2 "`:label (ever_mal) 1'")) ///
       text(60 4 "ρ = `rho'" "p = `p'", size(vsmall) just(left)) 

