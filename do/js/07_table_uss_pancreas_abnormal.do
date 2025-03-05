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
local filter 	"if radio_exam==1"
local title "Supplement Table. Pancreas Findings on Ultrasound(n=1784)"
local col "ever_mal"
local colhead2 `"0 "NPM" 1 "PM""'
local cat "2.pan_contour 2.pan_parenchyma 1.pan_paren_inflam 1.pan_paren_fibrosis 1.pan_paren_steatosis 2.pan_duct 1.pan_duct_stones 1.pan_duct_mass 1.pan_calci"
local notes1 "Pancreas contour : 14 were lobulated ; 5 with irregular borders or unclear margins."
local notes2 "No significant differences between groups on Chi-square test (p>0.05)"
local notes3 
local notes4 "Remove in final : Created with "`dofilename'" on "`c(current_date)'" at "`c(current_time)'"  based on  "`c(filename)'"" 

**# TABLE CODE

dtable () `filter', by(`col', notest nototals) ///
    factor(`cat', statistics(fvfrequency fvpercent) test(pearson)) ///
    title("`title'") ///
    note(`notes1') ///
	note(`notes2') ///
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

    collect label levels var _N "With Ultrasound", modify
    collect label levels pan_contour 1 "Normal" 2 "Irregular / Lobulated" 3 "Not well visualized", modify
	collect label levels pan_parenchyma 2 "Abnormal Parenchyma" 3 "Not well visualized",  modify
	collect label levels pan_paren_inflam 1 "Inflammation",  modify
	collect label levels pan_paren_fibrosis 1 "Fibrosis",  modify
	collect label levels pan_paren_steatosis 1 "Steatosis",  modify
	collect label levels pan_duct 2 "Duct Abnormality" 3 "Duct not visualized",  modify
	collect label levels pan_duct_stones 1 "Duct Stones" ,  modify
	collect label levels pan_duct 1 "Duct Mass" ,  modify
	collect label levels pan_calci 1 "Calcification" ,  modify
		
  
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

	local varlevel "2.pan_contour 2.pan_parenchyma 1.pan_paren_inflam 1.pan_paren_fibrosis 1.pan_paren_steatosis 2.pan_duct 1.pan_duct_stones 1.pan_duct_mass 1.pan_calci"
   
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

collect stars pearson .05 "*" .01 "**" .001 "***", dimension // shownote removed

	* -collect stars- above added a new dimension, attaching -stars[value]-
	* to every existing item, and adding new items for the stars labels
	* tagged with -stars[label]-; but we don't need to see it's label or
	* levels in the header
	
collect style header stars, title(hide) level(hide)

* change the layout to show the stars instead of the p-values


collect layout (var) (ever_mal#result[col1 col2 pearson]#stars) // shows p values and stars


/* p value options
collect layout (var) (ever_mal#result[col1 col2 pearson]#stars[value]) // shows p values only

collect layout (var) (ever_mal#result[col1 col2 pearson]#stars[value]#stars[label]) // shows p values and stars

collect layout (var) (ever_mal#result[col1 col2 pearson]#stars[value]#stars[label]) // shows p values and stars
*/

**#  SAVE COLLECTION 

collect save pan_findings, replace

**# EXPORT

collect export pan_findings.html, as(html) replace
html2docx pan_findings.html , saving(pan_findings.docx) replace
collect export pan_findings_ms.docx, as(docx) replace

