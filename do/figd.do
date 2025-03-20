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

local
d `uss'

gr box pan_body_trans, over(ever_mal) over(cohort) title

*--- v4 works

tempfile graphlist
local graphlist "" // Clear the graphlist
local i = 1
forvalues u = 0/3 {
    local grtitle : label cohort `i'
    gr box fecal_elastase if cohort == `i', over(ever_mal) title("`grtitle'")

    tempfile temp_graph_`i'
    gr save "`temp_graph_`i''.gph", replace

    display "`temp_graph_`i''.gph"

    local graphlist "`graphlist' `temp_graph_`i''.gph"

    local i = `i' + 1
}

display "`graphlist'"

gr combine `graphlist', rows(2) cols(3)
gr save "./figures/combined_cohorts", replace
gr export ./figures/figc.png, as(png) replace
