/* table_enzymes_cat.do 
J Solon
Sampa
April 2 

Creates n median iqr and p values of var
kwallis p value
di chi2tail(r(df),r(chi2))
d ct_pan_head_ap



*/

version 18.5

collect clear


**# CREATE TABLE USING DTABLE

**#  TABLE CONFIGURATION 

* CREATE LOCAL MACROS FOR VARIABLES IN TABLE - USE COMPLETE VARIABLE NAME)

	local col "ever_mal"
	local cat "epi_ordinal" /* categorical with multiple levels n(%) */
	local ind1 "1.epi_bin" 
	local ind2 "1.tryp_low" 
	local ind3 "1.amyl_low" 
	local ind4 "1.tryp_high" 
	


**# TABLE CODE

local filter "if subset==1"
dtable () `filter', by(`col', test nototals) ///
    factor(`cat', statistics(fvfrequency fvpercent) test(pearson)) ///
	factor(`ind1' `ind2' `ind3' `ind4', statistics(fvfrequency fvpercent) test(pearson)) ///
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



/* END END END END END END END END END END END END END END END END END END END END */
	


