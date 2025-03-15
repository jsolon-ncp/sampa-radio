/*
SAMPA
cr_categorical_independent.do
March 3 2025
J Solon

Creates categorical variables for indedpendent variables

Reusable with
	1.  Access to Dropbox
	2.  Define globals and paths
	3.  A working directory with 
	data
	data-temp
	tables
	do
	figures
	log 
	
*/

* Any radiology variables


* Cohort subcategorizations these are for creating graphs 

generate subcoh_child_adult = 1 if cohort ==1 | cohort ==2
	replace subcoh_child_adult = 2 if cohort ==3 | cohort ==4 | cohort ==5 | cohort ==6
	la var subcoh_child_adult "Cohort Population"

generate subcoh_geography =1 if cohort == 2 | cohort == 3 | cohort ==4
replace subcoh_geography =2 if cohort == 1 | cohort == 5 | cohort ==6
la var subcoh_geography "Cohort Geography"

label define subcoh_child_adult 1 "Child" 2 "Adult"
label values subcoh_child_adult subcoh_child_adult


label define subcoh_geography 1 "Africa" 2 "Asia"
label values subcoh_geography subcoh_geography


generate exposuretime = 1 if cohort ==1 | cohort ==2 | cohort ==6
	replace exposuretime = 2 if cohort ==4 | cohort ==5 | cohort ==3
label define exposuretime 1 "Exposure in Childhood" 2 "Exposure as Adults"
label values exposuretime exposuretime
	la var exposuretime "Exposure Time"
	
gen fec_cohort = 1 if cohort ==1
replace fec_cohort = 2 if cohort == 5
replace fec_cohort = 3 if cohort ==6
replace fec_cohort = 4 if cohort == 2
replace fec_cohort = 5 if cohort ==3
replace fec_cohort = 6 if cohort == 4

la var fec_cohort "Cohort"
label define fec_cohort 1 "DIVIDS" 2 "St-ATT" 3 "CLHNS" 4 "SAM" 5 "CICADA" 6 "NUSTART"
label values fec_cohort fec_cohort

label define ever_mal 0 "NPM" 1 "PM", modify
label values ever_mal ever_mal
