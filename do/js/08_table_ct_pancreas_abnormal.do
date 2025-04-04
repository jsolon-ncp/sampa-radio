/* 08_table_ct_pancreas_abnormal.do
Juan Solon
2025 Feb 

Purpose : Review CT Binary data

Logic:
There are ct variables that are meant to capture specific findings

These are the CT Variables
ct_scan ct_date ct_time ct_pan_size_qual ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head 


1. ct_pan_shape ct_pan_shape_problem ct_pan_shape_prob_spec 
2. ct_pan_contour ct_pan_contour_problem ct_pan_contour_prob_spec 
3. ct_pan_parenchyma ct_pan_paren_inflam ct_pan_paren_fibrosis ct_pan_paren_steatosis 
4. ct_pan_duct ct_pan_duct_stones ct_pan_duct_mass 
5. ct_pan_calci ct_pan_calci_place 


ct_pan_oth_abnormal ct_pan_oth_abn_spec 
ct_image_qual ct_problem ct_problem_why name_ct sig_ct sig_ct_upload file_ct file_ct2 file_ct3 file_ct4 file_ct5 file_ct6 file_ct7 file_ct8 file_ct9 file_ct10 ct_pan_vol


This code generates specific findings per organ based on regexm 
Clinical input is made as to what the relevant categories are (further input here from team)
The organs are the liver, gallbladder, spleen, kidney 
There is initially  a variable called other_findings for those temporaraily classified (eg worms - to GI, etc)
and general_findings for other issues re ID, etc

Output: ct_findings
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

* LOCAL DO FILE
local dofilename "08_table_ct_pancreas_abnormal.do"

* cd $ghstata
* WORKING DIRECTORY

cd "$ghsamparadio"
*cd "$dropboxsampa"
*cd "$sampadata"

* LOG

capture log close _all
capture cmdlog close
capture log using "./log/jslog.txt", replace text

** TEMPS

tempfile 1 2 3 4 5 6 

* USE

local dataset "All_combined_sampa_data.dta"

*. Use dataset /* revise as use*/
cd "$sampadata"
* use "../../Data Monitoring/data/sampa/All_combined_sampa_data.dta", clear
use "All_combined_sampa_data.dta", clear

cd "$ghsamparadio"


local cat "ct_pan_shape ct_pan_shape_problem ct_pan_parenchyma ct_pan_paren_inflam ct_pan_paren_fibrosis ct_pan_paren_steatosis ct_pan_duct ct_pan_duct_stones ct_pan_duct_mass ct_pan_calci"

foreach var of varlist ct_pan_shape ct_pan_shape_problem ct_pan_parenchyma ct_pan_paren_inflam ct_pan_paren_fibrosis ct_pan_paren_steatosis ct_pan_duct ct_pan_duct_stones ct_pan_duct_mass ct_pan_calci {
	tab `var' ever_mal, mis col row
} 

* Recode prior to tabulation *
*clonevar ct_pan_paren_fibrosis_new = ct_pan_paren_fibrosis
*replace ct_pan_paren_fibrosis_new = 0 if ct_pan_paren_fibrosis ==.

*tab ct_pan_paren_fibrosis_new ever_mal, mis col row 
* Parenchymal inflammation 
tab ct_pan_paren_inflam ever_mal,  mis col row
clonevar ct_pan_paren_inflam_new = ct_pan_paren_inflam
replace ct_pan_paren_inflam_new = 0 if ct_pan_paren_inflam ==.
tab ct_pan_paren_inflam_new ever_mal, mis col row

* Steatosis

tab ct_pan_paren_steatosis ever_mal,  mis col row
clonevar ct_pan_paren_steatosis_new = ct_pan_paren_steatosis
replace ct_pan_paren_steatosis_new = 0 if ct_pan_paren_steatosis ==.
tab ct_pan_paren_steatosis_new ever_mal, mis col row


/* note that ct_pan_duct_stones ct_pan_duct_mass are empty strings */


 **# CREATE TABLE USING DTABLE
cd "$ghsamparadio"
cd 03-tables

**#  TABLE CONFIGURATION 
local filter 	"if ct_scan==1"
local title "Supplement Table. Pancreas Findings on CT Scan (n=235)"
local col "ever_mal"
local colhead2 `"0 "NPM" 1 "PM""'
local cat "2.ct_pan_shape 3.ct_pan_shape 2.ct_pan_parenchyma 3.ct_pan_parenchyma 1.ct_pan_paren_inflam_new 1.ct_pan_paren_fibrosis 1.ct_pan_paren_steatosis_new 2.ct_pan_duct  2.ct_pan_duct 1.ct_pan_calci"
local notes1 "No significant difference in any findings between groups; Chi-square test"
local notes2 ""
local notes3 ""
local notes4 "Remove in final : Created with "`dofilename'" on "`c(current_date)'" at "`c(current_time)'"  based on  "`c(filename)'"" 

**# TABLE CODE

dtable () `filter', by(`col', test nototals) ///
    factor(`cat', statistics(fvfrequency fvpercent) test(pearson)) ///
    title("`title'") ///
    note(`notes1') ///
	note(`notes4')   


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

    collect label levels var _N "With CT Scans", modify
    collect label levels ct_pan_shape 1 "Normal Shape" 2 "Small Pancreas" 3 "Enlarged Pancreas", modify
	collect label levels ct_pan_parenchyma 2 "Abnormal Parenchyma" 3 "Not well visualized",  modify
	collect label levels ct_pan_paren_inflam_new 1 "Edema or Inflammation",  modify
	collect label levels ct_pan_paren_fibrosis 1 "Fibrosis",  modify
	collect label levels ct_pan_paren_steatosis_new 1 "Steatosis",  modify
	collect label levels ct_pan_duct 2 "Duct Abnormality" 3 "Duct not visualized",  modify
	collect label levels ct_pan_calci 1 "Calcifications",  modify
  
* Modify Header Text
    collect label levels ever_mal 0 "NPM" 1 "PM", modify
    collect style header ever_mal#result,title(hide)	
    
 * REMOVE VARIABLE NAME IN ROW 
 
   collect label dim var "Organs", modify
   
   collect style header var, title(hide) // hides the label of the dimension var
   
	   * collect style header var, title(label) // shows the label of the dimension var which is now "Organs"
	   * collect style header var, title(name) // shows the name of the dimension var, which is var
 
 * LAYOUT to apply to  LEVELS OF A DIMENSION 
   
   collect style header var, level(label) // SHOW the label of ALL LEVELS of dimension var 
   
		* collect style header var, level(hide) // HIDES the labels of ALL LEVELS the levels of dimension var which includes the levels of the dimension and its levels
   
  
 * LAYOUT FOR EACH LEVEL implemented in a foreach loop that HIDES the title of the level but keeps labels of level
   * collect style header var[1.ct_lung], title(label) // hides the title or name of levels of the dimension leaving on the level's labels modified above

	local varlevel "2.ct_pan_shape 3.ct_pan_shape 2.ct_pan_parenchyma 3.ct_pan_parenchyma 1.ct_pan_paren_inflam_new 1.ct_pan_paren_fibrosis 1.ct_pan_paren_steatosis_new 2.ct_pan_duct  2.ct_pan_duct 1.ct_pan_calci"
   
    foreach x in "`varlevel'" {
		collect style header var[`x'], title(hide)
	}

/* Check Table
    collect export organs.html, as(html) replace
    html2docx organs.html , saving(organs.docx) replace
*/
 
**# Create Composite Column so that counts and percentages are in separate columns
collect preview
collect composite define col1 = frequency fvfrequency
collect composite define col2 = fvpercent

* Clear autolevels
collect style autolevels result frequency percent fvfrequency fvpercent col4, clear

collect preview

**# Remove p values and replace with stars (from https://www.statalist.org/forums/forum/general-stata-discussion/general/1721778-dtable-formatting-problem #5)
* Note that this removes p values from the original dimension and moves it into new dimensoins

* the p-values are in composite _dtable_test: pearson 

collect query composite _dtable_test

* define stars rules using the p-value results

* collect stars pearson .05 "*" .01 "**" .001 "***", dimension shownote

	* -collect stars- above added a new dimension, attaching -stars[value]-
	* to every existing item, and adding new items for the stars labels
	* tagged with -stars[label]-; but we don't need to see it's label or
	* levels in the header
	
collect style header stars, title(hide) level(hide)

* change the layout to show the stars instead of the p-values


* collect layout (var) (ever_mal#result[col1 col2 pearson]#stars) // shows p values and stars
collect layout (var) (ever_mal#result[col1 col2]) // no p value or stars


/* p value options
collect layout (var) (ever_mal#result[col1 col2 pearson]#stars[value]) // shows p values only

collect layout (var) (ever_mal#result[col1 col2 pearson]#stars[value]#stars[label]) // shows p values and stars

collect layout (var) (ever_mal#result[col1 col2 pearson]#stars[value]#stars[label]) // shows p values and stars
*/

**#  SAVE COLLECTION 


collect save ct_findings, replace

**# EXPORT

collect export ct_findings.html, as(html) replace
html2docx ct_findings.html , saving(ct_findings.docx) replace
collect export ct_findings_ms.docx, as(docx) replace

