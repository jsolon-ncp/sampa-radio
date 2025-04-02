/* figc_all_enzymes.do 
Sampa
J Solon
March 20 2025

output
gr export ./figures/figc_a_1.png, as(png) replace
gr export ./figures/figc_a_2.png, as(png) replace
gr export ./figures/figc_b.png, as(png) replace
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

** Gr box 4 enzymes

local enzymes "fecal_elastase ul_amylp ngml_trypsinogen lipase"
local i = 1
foreach var of varlist `enzymes' {
	kwallis `var', by(ever_mal) 
	mystats

	local chi2 = string(r(Chi2), "%4.2f")
	local p = string(r(p), "%4.3f")
	local grtitle : variable label `var'
	
	if "`var'" == "lipase" {
		local subtitle "DIVIDS only"
		local ymax = 60
		local ytitle "Lipase U/L"
	}
	else if "`var'" == "ngml_trypsinogen" {
		local subtitle "CT Scan subset"
		local ymax = 250
		local ytitle = "Trypsinogen (ng/ml)"
	}
	else if "`var'" == "ul_amylp" {
		local subtitle "All except DIVIDS"
		local ymax = 150
		local ytitle = "Amylase (U/L)"
	}
	else {
		local subtitle "All cohorts"
		local ymax = 650
		local ytitle "Fecal Elastase (ug/g)"
	}
	
	gr box `var', over(ever_mal) title("`grtitle'") subtitle("`subtitle'") ytitle("`ytitle'") ///
		xsize(10) ysize(8) ///
		marker(1, msize(vsmall)) ///
		medline(lwidth(thin)) ///
		text(`ymax' 5 "Chi2 = `chi2'" "p = `p'", size(vsmall) just(left)) ///
		name(box_`i', replace)
		
	local ++i
}

* FE-1 AND amylase only
gr combine box_1 box_2 , rows(1) 
gr export ./figures/figc_a_1.png, as(png) replace

* all four enzymes 
gr combine box_1 box_2 box_3 box_4, rows(2) cols(2)
gr export ./figures/figc_a_2.png, as(png) replace

* FE-1 scatter

tempfile g1 g2 g3 g4

local enzymes "fecal_elastase amylase_ul trypsinogen_ngml"  
local i = 1
foreach var of varlist `enzymes' {
	 local grtitle : variable label `var'
	 local volabel : variable label ct_pan_vol
	 
	 spearman `var' ct_pan_vol
	 local rho = string(r(rho), "%4.2f")
	 local p = string(r(p), "%4.3f")
	 
	 scatter `var' ct_pan_vol if ever_mal==0, msymbol(circle) mcolor(blue%50) msize(small) || ///
	 scatter `var' ct_pan_vol if ever_mal==1, msymbol(diamond) mcolor(red%50) msize(small) ///
	 title("`grtitle'") ///
	 legend(order(1 "`:label (ever_mal) 0'" 2 "`:label (ever_mal) 1'")) ///
	 text(200 150 "ρ = `rho'" "p = `p'", size(vsmall) just(left)) ///
	 xtitle("Pancreatic volume, ml") ///
	 name(g_`i', replace)
	 
	 local ++i
}

* Lipase separately since it uses different x variable
spearman lipase pan_head_ap
local rho = string(r(rho), "%4.2f")
local p = string(r(p), "%4.3f")

local liplabel : variable label lipase
local headlabel : variable label pan_head_ap
scatter lipase pan_head_ap if ever_mal==0, msymbol(circle) mcolor(blue%50) msize(small) || ///
scatter lipase pan_head_ap if ever_mal==1, msymbol(diamond) mcolor(red%50) msize(small) ///
title("`liplabel'") ///
legend(order(1 "`:label (ever_mal) 0'" 2 "`:label (ever_mal) 1'")) ///
text(60 4 "ρ = `rho'" "p = `p'", size(vsmall) just(left)) ///
xtitle("Pancreatic Head AP length, cm") ///
name(g_4, replace)

gr combine g_1 g_2 g_3 g_4, rows(2) cols(2)

gr export ./figures/figc_b.png, as(png) replace


