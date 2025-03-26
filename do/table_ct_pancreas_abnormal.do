/* table_ct_pancreas_abnormal.do
Juan Solon
2025 Feb 

Purpose : Review CT Binary data
Logic:
There are ct variables that are meant to capture specific findings in the panrease
These are the CT Variables
ct_scan ct_date ct_time ct_pan_size_qual ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head 


1. ct_pan_shape ct_pan_shape_problem ct_pan_shape_prob_spec 
2. ct_pan_contour ct_pan_contour_problem ct_pan_contour_prob_spec 
3. ct_pan_parenchyma ct_pan_paren_inflam ct_pan_paren_fibrosis ct_pan_paren_steatosis 
4. ct_pan_duct ct_pan_duct_stones ct_pan_duct_mass 
5. ct_pan_calci ct_pan_calci_place 

Two variables are generated for recoding results. ct_pan_paren_inflam_new ct_pan_paren_steatosis_new
These are dropped at the end 
Output: ct_findings
*/
version 18.5

collect clear
* Inspect 
		local cat "ct_pan_shape ct_pan_shape_problem ct_pan_parenchyma ct_pan_paren_inflam ct_pan_paren_fibrosis ct_pan_paren_steatosis ct_pan_duct ct_pan_duct_stones ct_pan_duct_mass ct_pan_calci"

		foreach var of varlist ct_pan_shape ct_pan_shape_problem ct_pan_parenchyma ct_pan_paren_inflam ct_pan_paren_fibrosis ct_pan_paren_steatosis ct_pan_duct ct_pan_duct_stones ct_pan_duct_mass ct_pan_calci {
			tab `var' ever_mal, mis col row
		} 

* Recode prior to tabulation *
	*clonevar ct_pan_paren_fibrosis_new = ct_pan_paren_fibrosis
	*replace ct_pan_paren_fibrosis_new = 0 if ct_pan_paren_fibrosis ==.

	*tab ct_pan_paren_fibrosis_new ever_mal, mis col row 
	capture drop ct_pan_paren_inflam_new ct_pan_paren_steatosis_new
	
* Parenchymal inflammation 

	tab ct_pan_paren_inflam ever_mal,  mis col row
	
	clonevar ct_pan_paren_inflam_new = ct_pan_paren_inflam
	replace ct_pan_paren_inflam_new = 0 if ct_pan_paren_inflam ==.
	
	tab ct_pan_paren_inflam_new ever_mal, mis col row

* Steatosis

	tab ct_pan_paren_steatosis ever_mal,  mis col row
	clonevar ct_pan_paren_steatosis_new = ct_pan_paren_steatosis
	replace ct_pan_paren_steatosis_new = 0 if ct_pan_paren_steatosis ==.
	tab ct_pan_paren_steatosis_new ever_mal, mis row 

/* note that ct_pan_duct_stones ct_pan_duct_mass are empty strings */

**# CREATE TABLE USING DTABLE

**#  TABLE CONFIGURATION 

count if ct2==1

local obs = r(N)

local title "Supplement Table. Pancreas Findings on CT Scan (n=`obs')"
local col "ever_mal"
local colhead2 `"0 "NPM" 1 "PM""'
local cat "2.ct_pan_shape 3.ct_pan_shape 2.ct_pan_parenchyma 3.ct_pan_parenchyma 1.ct_pan_paren_inflam_new 1.ct_pan_paren_fibrosis 1.ct_pan_paren_steatosis_new 2.ct_pan_duct  2.ct_pan_duct 1.ct_pan_calci"
local notes1 "Numbers are N(%)"
local notes2 "No significant difference in any findings between groups; Fisher's Exact test"
*local notes3 ""
*local notes4 "Remove in final : Created with "`dofilename'" on "`c(current_date)'" at "`c(current_time)'"  based on  "`c(filename)'"" 

**# TABLE CODE

local filter "if ct2==1"
dtable () `filter', by(`col', test nototals) ///
    factor(`cat', statistics(fvfrequency fvpercent) test(fisher)) ///
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

* MODIFY TEXT

* Modify Header Text
    collect label levels ever_mal 0 "NPM" 1 "PM", modify
    collect style header ever_mal#result,title(hide)
	
****ROWS

	label list ct_pan_paren_fibrosis ct_pan_parenchyma ct_pan_paren_inflam ct_pan_paren_steatosis ct_pan_duct

    collect label levels var _N "With CT Scans", modify
    collect label levels ct_pan_shape 1 "Normal Shape" 2 "Small Pancreas" 3 "Enlarged Pancreas", modify
	collect label levels ct_pan_parenchyma 2 "Abnormal Parenchyma" 3 "Not well visualized",  modify
	collect label levels ct_pan_paren_inflam_new 1 "Edema or Inflammation",  modify
	collect label levels ct_pan_paren_fibrosis 1 "Fibrosis",  modify
	collect label levels ct_pan_paren_steatosis_new 1 "Steatosis",  modify
	collect label levels ct_pan_duct 2 "Duct Abnormality" 3 "Duct not visualized",  modify
	collect label levels ct_pan_calci 1 "Calcifications",  modify
    
* REMOVE level name in rows to show only the  label names
   
   local cat "2.ct_pan_shape 3.ct_pan_shape 2.ct_pan_parenchyma 3.ct_pan_parenchyma 1.ct_pan_paren_inflam_new 1.ct_pan_paren_fibrosis 1.ct_pan_paren_steatosis_new 2.ct_pan_duct  2.ct_pan_duct 1.ct_pan_calci"
   
   local cat2 " 1.ct_pan_paren_inflam_new 1.ct_pan_paren_fibrosis 1.ct_pan_paren_steatosis_new 2.ct_pan_duct  2.ct_pan_duct 1.ct_pan_calci"
   
   foreach x in "`cat2'" {
		collect style header var[`x'], title(hide)
		}
  
* Save collection   
	collect rename DTable ct_findings, replace
	collect save ./tables/ ct_findings, replace

**# EXPORT

	collect export ./tables/ct_findings.html, as(html) replace
	html2docx ./tables/ct_findings.html , saving(ct_findings.docx) replace
	collect export ./tables/ct_findings_ms.docx, as(docx) replace

** Drop generated variables

drop ct_pan_paren_inflam_new ct_pan_paren_steatosis_new

** END
