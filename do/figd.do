/* figd.do 
Sampa
2025 March 21
*** FIGURE D USS CT

local fig4 "./figures/uss_ct_corr.png"
local fig4head "Figure 4 Ultrasound Measurement by PM or NPM in each cohort."

local fig4text "a) axial anterior-posterior and transverse head diameters, b) coronal cranio-caudal head diameter, c) coronal cranio-caudal body diameters, d) axial anterior-posterior body and tail diameters, body, and d) length of body and tail."

*/


set scheme stsj

local uss "pan_head_ap pan_head_trans pan_tail_trans pan_body_trans"

tempfile graphlist
local graphlist "" // Clear the graphlist

foreach var of varlist `uss' {
    local grtitle : variable label `var'
    gr box `var', over(ever_mal) over(cohort) ///
        ytitle("") ///
        title("`grtitle'", size(medium)) ///
        ylabel(0(1)5, angle(0) format(%2.0f)) ///
        xsize(10) ysize(8) ///
        name(g_`var', replace)
    
    local graphlist "`graphlist' g_`var'"
}

gr combine `graphlist', rows(2) cols(2) ///
    ycommon ///
    l1title("Diameter (cm)", size(medium))
    
gr save "./figures/uss_ct_corr", replace
gr export "./figures/uss_ct_corr.png", as(png) width(2400) replace
