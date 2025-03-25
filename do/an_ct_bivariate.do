/* an_ct_bivariate.do 
J Solon
Sampa
March19 

Creates n median iqr and p values of var
kwallis p value
di chi2tail(r(df),r(chi2))
d ct_pan_head_ap



*/

capture log close
log using ./log/an_ct_bivariate.txt, text replace

cap prog drop mystats
program mystats, rclass
return scalar p_adj= chi2tail(r(df), r(chi2_adj))
return scalar Chi2_adj =  r(chi2_adj)
return scalar  DF =  r(df)
return scalar p= chi2tail(r(df), r(chi2))
return scalar  Chi2 =   r(chi2)
end


la var ct_pan_head_ap "Head, AP"
la var ct_pan_head_trans "Head, Transverse"
la var ct_pan_body_trans "Body, Transverse"
la var ct_pan_tail_trans "Tail, Transverse"
la var ct_pan_body_tail "Body-Tail, Length"
la var ct_pan_vol "Pancreatic volume(ml)"

collect clear

local col "ever_mal"
local contmed "ct_pan_head_ap ct_pan_head_trans ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_vol "  /*continous variables; median (p25-p75)  will be reported*/

local colhead2 `"0 "NPM" 1 "PM""'
		
* format median of `contmed'
local nfrmt_p50 "%5.3f"
local nfrmt_iqr "%5.3f"
local sfrmt_p25 "(%s-"
local sfrmt_p75 "%s)"

local title "Table .Unadjusted CT Measurements"
count if radio3 ==1
local obs_uss = r(N)
di `obs_uss'
count if ct2 ==1
local obs_ct = r(N)
di `obs_ct'
local notes1 "Values are [N] median (p25-p50)."
local notes2 "`obs_uss' contributing any ultrasound measurement."
local notes3 "`obs_ct' contributing any CT scan measurement."
local notes4 "P values are for Kruskal-Wallis Tests"


* STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  
* THERE IS NOTHING TO MODIFY BEYOND THIS LINE UNLESS CHANGING CODE. 

* GENERATE TABLE STATS 

	table (var)(`col')  , ///
		stat(frequency) ///
		stat(count `contmed') ///
		stat(p50 `contmed') ///
		stat(p25 `contmed') ///
		stat(p75 `contmed') ///
		nototal
		
collect rename Table c1
		
*REFORMAT RESULTS TO DESIRED COLUMNS
		
	* recodes median and iqr
		collect recode result p50 = column1
		collect recode result p25 = column2
		collect recode result p75 = column3
		
	* Create composite result : this is needed because 75 is in column3 and we want it in the same column as column 2 .  Use for medians and probably CIs
		collect composite define column4 = column2 column3, replace

	* Calculate p-values from chi2 and df
	foreach v in `contmed' {
		quietly kwallis `v', by(`col')
		collect: mystats
	}

	
* CREATE THE TABLE 1 Layout Super column - column 

	collect layout (var) (ever_mal#result[count column1 column4])

* Format p-values
	collect style cell result[p], nformat("%5.3f")
	collect style cell result[p], sformat("p=%s")

* CHANGE HEADER TEXT
	* column
		collect label levels `col' `colhead2', modify

collect preview /* preview changes */

* HIDE COLUMN HEADERS

	* Hide supercolumn variable name because it is self-descriptive
		
	*	collect style header `scol', title(hide) /* this removes the column variable name or label by hiding it */

	* Hide the column variable name 
		
		collect style header `col', title(hide) /* this removes the column variable name or label by hiding it */

	* Hide the words column 1 and column 2 for the results 

		collect style header result, level(hide) /* this removes column 1 and column2 header names*/

collect preview /* preview changes */

* MODIFY ROW TEXT


* REVISE ROW STYLES

* Stack levels of each variable , place a space between variables (spacer) ; 

	collect style row stack, nobinder spacer

* Remove vertical line after variables

	collect style cell border_block, border(right, pattern(nil))

* HIDE ROW Text

* Hide the variable names 
collect style header `hiderows', title(hide)


* FORMAT NUMBERS

* Format median

	collect style cell result[column1]#var[`contmed'], nformat(`nfrmt_p50')

* Add IQR formatting to p25 and p75 separately:
	collect style cell result[column2]#var[`contmed'], nformat(`nfrmt_iqr') sformat("`sfrmt_p25'") /* formats iqr as (p25 - p75)*/
	collect style cell result[column3]#var[`contmed'], nformat(`nfrmt_iqr') sformat("`sfrmt_p75'") 

* Format count column
	collect style cell result[count], nformat("%4.0f") /* Format count as whole number */
	collect style cell result[count], sformat("[%s]") /* Format count as whole number */
	
/* format factor variables (categorical) column 1 and column 2

	collect style cell var[`frmt_catvar1']#result[column1], nformat(`nfrmt_freq')

	collect style cell var[`frmt_catvar1']#result[column2], nformat(`nfrmt_perc') sformat("(`sfrmt_perc')") /* Adds (%) to percent */

* format means variable column 1 and column 2

	collect style cell var[`contn']#result[column1], nformat(`nfrmt_mean') /* Formats continuous variable to one decimal*/

	collect style cell var[`contn']#result[column2], nformat(`nfrmt_sd') sformat(`sfrmt_sd') /* Formats continuous variable to one decimal*/
*/
* Change font of results
	*collect style cell var[`contn']#result[column1], nformat(`nfrmt_mean') /* Formats continuous variable to one decimal*/
	
* Add text
	collect title `title'
	collect notes `notes1'
	collect notes `notes2'
	collect notes `notes3'
	collect notes `notes4'
	
collect preview

* Save first collection with main stats
collect layout (var) (ever_mal#result[count column1 column4])
collect save ./tables/ct1.json, replace

* Create new collection for p-values
collect create c2
foreach v in `contmed' {
    quietly kwallis `v', by(`col')
    collect: mystats
}
   
   

* Remap cmdset to match var levels
collect recode cmdset 1 = ct_pan_head_ap
collect recode cmdset 2 = ct_pan_head_trans
collect recode cmdset 3 = ct_pan_body_trans
collect recode cmdset 4 = ct_pan_tail_trans
collect recode cmdset 5 = ct_pan_body_tail
collect recode cmdset 6 = ct_pan_vol
collect remap cmdset = var

* Combine collections
collect combine c4 = c1 c2

* Create layout for combined collection
collect layout (var[pan_head_ap pan_head_trans pan_body_trans pan_tail_trans ///
				ct_pan_head_ap ct_pan_head_trans ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_vol]) ///
				(ever_mal#result[count column1 column4] result[p])   
  


collect save ./tables/ct1, replace	
* Export combined table
collect export ./tables/ct1.html, as(html) replace
collect export ./tables/ct1.docx, as(docx) replace
collect export ./tables/ct1.xlsx, as(xlsx) replace

collect use ./tables/uss1

collect combine c5 = c3 c4

collect layout (var) (ever_mal#result[count column1 column4] result[p])   

* Reorder rows 
collect layout (var[pan_head_ap pan_head_trans pan_body_trans pan_tail_trans ///
				ct_pan_head_ap ct_pan_head_trans ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_vol]) ///
				(ever_mal#result[count column1 column4] result[p]) 
				
* Add a Dimension for USS and CT Variables

collect addtags vartype[USS 1621 contributing any measurement], fortags(var[pan_head_ap pan_head_trans pan_body_trans pan_tail_trans])
collect addtags vartype[CT 291 contributing any measurement], fortags(var[ct_pan_head_ap ct_pan_head_trans ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_vol])

collect layout (vartype#var[pan_head_ap pan_head_trans pan_body_trans pan_tail_trans ///
				ct_pan_head_ap ct_pan_head_trans ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_vol]) ///
				(ever_mal#result[count column1 column4] result[p]) 
				
collect notes, clear
collect notes "Values are [N] median (p25-p75)."
collect notes "P values are for Kruskal-Wallis tests."
collect title "Radiologic measurements in the whole cohort, by prior exposure"				
collect save ./tables/uss_ct, replace	
* Export combined table
collect export ./tables/uss_ct.html, as(html) replace
collect export ./tables/uss_ct.docx, as(docx) replace
collect export ./tables/uss_ct.xlsx, as(xlsx) replace




/* END END END END END END END END END END END END END END END END END END END END */
	


