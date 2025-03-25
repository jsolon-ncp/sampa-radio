/* figc.do 
Sampa
J Solon
March 20 2025
Figure 3 Faecal elastase distribution by cohort and malnutrition status."

*/

set scheme stsj


*--- v4 works

tempfile graphlist
local graphlist "" // Clear the graphlist
local i = 1
forvalues c = 0/5 {
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


**** v5 reorders the cohort for Africa on top

tempfile graphlist
local graphlist ""
local i = 1

local cohort_order "2 4 3 1 6 5" // Define the desired order

foreach c of local cohort_order {
    local grtitle : label cohort `c'
    
	gr box fecal_elastase if cohort == `c', over(ever_mal) title("`grtitle'") ///
	ytitle("")

    tempfile temp_graph_`i'
    gr save "`temp_graph_`i''.gph", replace

    display "`temp_graph_`i''.gph"

    local graphlist "`graphlist' `temp_graph_`i''.gph"

    local i = `i' + 1
}

display "`graphlist'"

gr combine `graphlist', rows(2) cols(3) l1title("Faecal Elastase (mcg/g)")

gr export ./figures/figc.png, as(png) replace






