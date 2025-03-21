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

label variable pan_head_ap "Head, AP"
label variable pan_head_trans  "Head, Transverse" 
label variable pan_body_trans  "Body, Transverse"
label variable pan_tail_trans  "Tail, Transverse"



* Cohort subcategorizations these are for creating graphs 

generate child = 1 if cohort ==1 | cohort ==2
	replace child = 2 if cohort ==3 | cohort ==4 | cohort ==5 | cohort ==6
	la var child "Adult or Child Population"

	label define child 1 "Child" 2 "Adult"
    label values child child

	
generate africa =1 if cohort == 2 | cohort == 3 | cohort ==4
	replace africa =2 if cohort == 1 | cohort == 5 | cohort ==6
	la var africa "Africa or Asia"

	label define africa 1 "Africa" 2 "Asia"
	label values africa africa


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
