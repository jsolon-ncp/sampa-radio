/* table_uss_pancreas_abnormal
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
collect clear 
set more off

* Inspect vars, labels, missings 

local cat "pan_contour pan_contour_problem pan_parenchyma pan_paren_inflam pan_paren_fibrosis pan_paren_steatosis pan_duct pan_duct_stones pan_duct_mass pan_calci"

foreach x in "`cat'" {
		d `x'	
		label list `x'
		missings report `x'
		}
* relevant factor level for pan_contour pan_parenhyma, pan_duct ==2, for the rest it is 1
		
/* note that ct_pan_duct_stones ct_pan_duct_mass are empty strings */


 **# CREATE TABLE USING DTABLE

**#  TABLE CONFIGURATION 
collect clear


count if radio3==1

local obs = r(N)

local title "Supplement Table. Pancreas Findings on Ultrasound(n=`obs')"
local col "ever_mal"
local colhead2 `"0 "NPM" 1 "PM""'
local cat1 "2.pan_contour 2.pan_parenchyma 1.pan_paren_steatosis"
local cat2 "1.pan_paren_inflam 1.pan_paren_fibrosis 2.pan_duct 1.pan_duct_stones 1.pan_duct_mass 1.pan_calci"
local notes1 "Numbers are Frequency(%) . Fishers or Chi-square test p values are shown."
local notes2 "All but 1 with steatosis were also desccribed as having abnormal parenchyma."
local notes3 
local notes4 
**# TABLE CODE

local filter "if radio3==1"

dtable () `filter', by(`col', test nototals) ///
    factor(`cat1', statistics(fvfrequency fvpercent) test(pearson)) ///
	factor(`cat2', statistics(fvfrequency fvpercent) test(fisher)) ///
    title("`title'") ///
    note(`notes1') ///
	note(`notes2') 

**# TABLE LAYOUT
	collect style row stack, nobinder nospacer // * Stack levels of each variable , places/removes space between variables ; 

    collect style cell border_block, border(right, pattern(nil)) // Remove vertical line after variables
	
*** TABLE SPACES / WIDTH
	collect style cell, margin(all, width(1.5)) //  space b/w text and cell margins default is 1.5 points 

	collect style column, width(equal) // Revise column width (equal or asis)
    
*** TABLE TEXT

* Table Styles
	collect style cell, font(Arial, size(11))
	collect style notes, font(Arial, size(11))

* Table title styles
	collect style title, font(Arial, size(11) bold)

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

* REMOVE Levels NAME IN ROW 
 
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
   
collect rename DTable uss_findings, replace
collect save ./tables/uss_findings, replace

**# EXPORT
collect export ./tables/uss_findings.html, as(html) replace
html2docx ./tables/uss_findings.html , saving(pan_findings.docx) replace
collect export ./tables/uss_findings_ms.docx, as(docx) replace

