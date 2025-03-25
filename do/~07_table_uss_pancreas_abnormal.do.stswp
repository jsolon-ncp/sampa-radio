/* 07_table_uss_pancreas_abnormal
Juan Solon
2025 Feb 

Purpose : Clean Ultrasound Data 
pan_contour pan_contour_problem pan_parenchyma pan_paren_inflam pan_paren_fibrosis pan_paren_steatosis pan_duct pan_duct_stones pan_duct_mass pan_calci

Logic:
There are USS variables that are meant to capture specific findings

 REFERENCE VARIABLES
These are the USS Variables
pan_shape pan_shape_problem pan_shape_prob_specify 
pan_contour pan_contour_problem pan_contour_prob_specify 
pan_parenchyma 
pan_paren_inflam 
pan_paren_fibrosis 
pan_paren_steatosis 
pan_duct 
pan_dupan_stones 
pan_dupan_mass 
pan_calci 
pan_calci_place 
pan_cyst_yes 
pan_oth_abnormal pan_oth_abn_specify

Output : pan_findings
*/


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
local dofilename "7_table_uss_pancreas_abnormal.do"


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

* Inspect labels 
local cat "pan_contour pan_contour_problem pan_parenchyma pan_paren_inflam pan_paren_fibrosis pan_paren_steatosis pan_duct pan_duct_stones pan_duct_mass pan_calci"

foreach x in "`cat'" {
		d `x'	
		label list `x'
		}
* relevant factor level for pan_contour pan_parenhyma, pan_duct ==2, for the rest it is 1
		
/* note that ct_pan_duct_stones ct_pan_duct_mass are empty strings */


 **# CREATE TABLE USING DTABLE
cd "$ghsamparadio"
cd 03-tables

**#  TABLE CONFIGURATION 
collect clear

local title "Supplement Table. Pancreas Findings on Ultrasound(n=1784)"
local col "ever_mal"
local colhead2 `"0 "NPM" 1 "PM""'
local cat1 "2.pan_contour 2.pan_parenchyma 1.pan_paren_steatosis"
local cat2 "1.pan_paren_inflam 1.pan_paren_fibrosis 2.pan_duct 1.pan_duct_stones 1.pan_duct_mass 1.pan_calci"
local notes1 "Values are N(%). Fishers or Chi-square test p values are shown."
local notes2 
local notes3 
local notes4 
**# TABLE CODE

dtable () `filter', by(`col', test nototals) ///
    factor(`cat1', statistics(fvfrequency fvpercent) test(pearson)) ///
	factor(`cat2', statistics(fvfrequency fvpercent) test(fisher)) ///
    title("`title'") ///
    note(`notes1') 

**# TABLE LAYOUT

    collect style row stack, nobinder nospacer // * Stack levels of each variable , places/removes space between variables ; 

    collect style cell border_block, border(right, pattern(nil)) // Remove vertical line after variables
	
*** TABLE SPACES / WIDTH
collect style cell, margin(all, width(10)) // Define space b/w text and cell margins ;  default space in points is 1.5 between text and cell margin 

collect style column, width(asis) // Revise column width (equal or asis)
    
*** TABLE TEXT

* Table title styles
collect style title, font(, bold)

* MODIFY row text

label list ct_pan_paren_fibrosis ct_pan_parenchyma ct_pan_paren_inflam ct_pan_paren_steatosis ct_pan_duct

    collect label levels var _N "With Ultrasound", modify
    collect label levels pan_contour 2 "Lobulated", modify
	collect label levels pan_parenchyma 2 "Abnormal Parenchyma",  modify
	collect label levels pan_paren_inflam 1 "Inflammation",  modify
	collect label levels pan_paren_fibrosis 1 "Fibrosis",  modify
	collect label levels pan_paren_steatosis 1 "Steatosis",  modify
	collect label levels pan_duct 2 "Duct Abnormality",  modify
	collect label levels pan_duct_stones 1 "Duct Stones" ,  modify
	collect label levels pan_duct_mass 1 "Duct Mass" ,  modify
	collect label levels pan_calci 1 "Calcification" ,  modify
		
  
* Modify Header Text
    collect label levels ever_mal 0 "NPM" 1 "PM", modify
    collect style header ever_mal#result,title(hide)	
    
	collect style header var, title(hide)
 * REMOVE VARIABLE NAME IN ROW 
 
 *  collect label dim var "Organs", modify
 
 local cat1 "2.pan_contour 2.pan_parenchyma 1.pan_paren_steatosis"
 
 foreach x in "`cat1'" {
		collect style header var[`x'], title(hide)
	}
	
local cat2 "1.pan_paren_inflam 1.pan_paren_fibrosis 2.pan_duct 1.pan_duct_stones 1.pan_duct_mass 1.pan_calci"
 
 foreach x in "`cat2'" {
		collect style header var[`x'], title(hide)
	}

   
   **#  SAVE COLLECTION 

collect save ./tables/pan_findings, replace

**# EXPORT

collect export ./tables/pan_findings.html, as(html) replace
html2docx ./tables/pan_findings.html , saving(pan_findings.docx) replace
collect export ./tables/pan_findings_ms.docx, as(docx) replace

