/* figc.do 
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
	ytitle("Faecal Elastase (mcg/g)")

    tempfile temp_graph_`i'
    gr save "`temp_graph_`i''.gph", replace

    display "`temp_graph_`i''.gph"

    local graphlist "`graphlist' `temp_graph_`i''.gph"

    local i = `i' + 1
}

display "`graphlist'"

gr combine `graphlist', rows(2) cols(3)

gr save "./figures/rearranged_cohorts", replace

gr export ./figures/figc.png, as(png) replace













local c "1"

gr box fecal_elastase if cohort ==`c', over(ever_mal) title(`c')
gr save ./figures/ `c'

// Get the label of the value stored in local c
local clabel : label cohort `c'

// Generate the box plot with the correct title
gr box fecal_elastase if cohort == `c', over(ever_mal) title("`cohort_label'")
gr save ./figures/`cohort_label', replace //use replace, or change the name each time







forvalues c = 1/6 {
	gr box fecal_elastase if cohort ==`c', over(ever_mal) 
gr save ./figures/`c'
}
/*

scatter mpg weight,
             caption("{bf:Source}: {it:Consumer Reports}, used with permission")
			 
			   . twoway function y = 2*exp(-2*x), range(0 2)
           title("{&function}(x)=2e{superscript:-2x}")
		   
		    scatter mpg weight, title("Here are {stSerif:serif},
        {stSans:sans serif}, and {stMono:monospace}")
		
		The SMCL tags that are useful in graph text are the following:
SMCL tag
{bf}
{it}
{superscript}
{sup}
{subscript}
{sub}
{stSans}
{stSerif}
{stMono}
{stSymbol}
{fontface "fontname"} {char code} {&symbolname}
Description
Make text bold
Make text italic
Display text as a superscript
Synonym for {superscript}
Display text as a subscript
Synonym for {subscript}
Display text with the default sans serif font
Display text with the default serif font
Display text with the default monospace (fixed-width) font Display text with the default symbol font
Display text with the specified fontname
Display ASCII character
Display a Greek letter, math symbol, or other symbo


textboxstyle
  heading
  subheading
  body
  smbody
Description
large text suitable for headings medium text suitable for subheadings medium text
small text

