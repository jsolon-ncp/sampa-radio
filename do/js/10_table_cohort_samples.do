/* 10table_cohort_samples.do 
Juan Solon
2025 Feb 

Purpose : show number of samples and images collected per cohort

Output files : 
fig_upset_1.png
fig_upset_2.png

*/
version 18.5

*CLEAR
clear all
set more off

* GLOBALS
global dropboxsampa "~/Cox working group Dropbox/TB Nutrition working group/Sampa"
global samparadio "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Analysis/Radiology"
* global sampadata "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Management/04-data-delivered-v2/ALL/STATA"
global sampadata "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Monitoring/data/sampa"
global ghsamparadio = "~/Documents/GitHub/sampa-radio"

* LOCAL FOR DO FILE
local dofilename "10table_cohort_samples.do "

cd $ghstata
* WORKING DIRECTORY

cd "$ghsamparadio"
*cd "$dropboxsampa"
*cd "$sampadata"

* LOG

capture log close _all
capture cmdlog close
capture log using "./log/jslog.txt", replace text

** TEMPS


* USE

local dataset "All_combined_sampa_data.dta"

*. Use dataset /* revise as use*/
cd "$sampadata"
* use "../../Data Monitoring/data/sampa/All_combined_sampa_data.dta", clear
use "All_combined_sampa_data.dta", clear

cd "$ghsamparadio"

**# Generate recruitment and sample variables
gen recruited = 1
	la var recruited "Recruited"

gen assay_fe = 1 if fecal_elastase !=. & fecal_elastase >0
	replace assay_fe = 0 if fecal_elastase==. 
	la var assay_fe "Fecal Elastase"

gen assay_lip = 1 if lipase !=. & lipase >0
	replace assay_lip = 0 if lipase ==.
	la var assay_lip "Lipase"

gen assay_tryp = 0
replace assay_tryp = 1 if assay_tryp ==.
la var assay_tryp "Trypsinogen"

clonevar radio2 = radio_exam
	replace radio2 = 0 if radio_exam==.
	la var radio2 "Ultrasound"

clonevar ct2 = ct_scan
	replace ct2 = 0 if ct_scan==.
	la var ct2 "CT Scan"

egen epi_binary = cut(fecal_elastase), at(0,200,601) icodes
	la var epi_binary "EPI"
	recode epi_binary 0 = 1 1 = 0
	

	label define epi_binary 0 "Without EPI" 1 "With EPI"
	label values epi_binary epi_binary
	

egen epi_ordinal = cut(fecal_elastase), at(0,100,200, 601) icodes
	la var epi_ordinal "EPI Levels"
	recode epi_ordinal 0 = 3 1 = 2 2 = 1 

	label define epi_ordinal 1 "Without EPI" 2 "Mild-Moderate EPI" 3 "Severe EPI"
	label values epi_ordinal epi_ordinal


**#  TABLE CONFIGURATION 

local title "Samples and Images per Cohort"
local cat "1.assay_f 1.assay_l 1.radio2 1.ct2"
local notes1 "Pending Lipase and Trypsinogen"
local notes2 ""
local notes3 
local notes4 "Remove in final : Created with "`dofilename'" on "`c(current_date)'" at "`c(current_time)'"  based on  "`c(filename)'"" 

**# TABLE CODE

   
table (cohort), /// 
stat(fvfrequency 1.assay_f 1.assay_l 1.radio2 1.ct2) 
     
	collect title "`title'"
	
	collect label levels var 1.assay_fe "Elastase", modify
	collect label levels var 1.assay_lip "Lipase" 1.radio2 "USS" 1.ct2 "CT Scan"
	collect style header, level(label)
	collect style column, width(equal)
	
	**# TABLE LAYOUT

    collect style row stack, nobinder nospacer // * Stack levels of each variable , places/removes space between variables ; 

    collect style cell border_block, border(right, pattern(nil)) // Remove vertical line after variables
	
*** TABLE SPACES / WIDTH
collect style cell, margin(all, width(10)) // Define space b/w text and cell margins ;  default space in points is 1.5 between text and cell margin 

collect style column, width(asis) // Revise column width (equal or asis)
    
*** TABLE TEXT

* Table title styles
collect style title, font(, bold)

	
cd 03-tables

collect export table_cohort_samples.html, as(html) replace
collect export table_cohort_samples.docx, as(docx) replace
html2docx table_cohort_samples.html , saving(tab_h_cohort_samples.docx) replace



table (cohort), /// 
stat(fvfrequency 1.assay_f) ///
 stat(fvfrequency 1.assay_l) ///
  stat(fvfrequency 1.radio2) ///
   stat(fvfrequency 1.ct2) 
   