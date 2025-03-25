/* an_radio_adj_bivariat.do 
J Solon
Sampa
March19 

Creates n median iqr and p values of var ADJUSTED USS MEAS
kwallis p value
di chi2tail(r(df),r(chi2))

local derived2 " adj_sqrt_ct_pan_cc_body adj_sqrt_ct_pan_cc_head 


adj_wt_pan_head_ap adj_wt_pan_head_trans adj_wt_pan_body_trans adj_wt_pan_tail_trans 
adj_sqrt_pan_head_ap adj_sqrt_pan_head_trans adj_sqrt_pan_body_trans adj_sqrt_pan_tail_trans"
*/


capture log close
log using ./log/an_radio_adj_bivariate.txt, text replace

cap prog drop mystats
program mystats, rclass
return scalar p_adj= chi2tail(r(df), r(chi2_adj))
return scalar Chi2_adj =  r(chi2_adj)
return scalar  DF =  r(df)
return scalar p= chi2tail(r(df), r(chi2))
return scalar  Chi2 =   r(chi2)
end

collect clear

local col "ever_mal"

local adjwt_uss "adj_wt_pan_head_ap adj_wt_pan_head_trans adj_wt_pan_body_trans adj_wt_pan_tail_trans"  

local adjsq_uss "adj_sqrt_pan_head_ap adj_sqrt_pan_head_trans adj_sqrt_pan_body_trans adj_sqrt_pan_tail_trans"  

local adjwt_ct "adj_wt_ct_pan_head_ap adj_wt_ct_pan_head_trans adj_wt_ct_pan_body_trans adj_wt_ct_pan_tail_trans adj_wt_ct_pan_body_tail adj_wt_ct_pan_vol"  

local adjsq_ct "adj_sqrt_ct_pan_head_ap adj_sqrt_ct_pan_head_trans adj_sqrt_ct_pan_body_trans adj_sqrt_ct_pan_tail_trans adj_sqrt_ct_pan_body_tail adj_sqrt_ct_pan_vol"  



/*continous variables; median (p25-p75)  will be reported*/


local colhead2 `"0 "NPM" 1 "PM""'
		
* format median of all cont vars
local nfrmt_p50 "%5.3f"
local nfrmt_iqr "%5.3f"
local sfrmt_p25 "(%s-"
local sfrmt_p75 "%s)"

local title "Table .Adjusted Ultrasound Measurements"
count if radio3 ==1
local obs_uss = r(N)
di `obs_uss'
count if ct2 ==1
local obs_ct = r(N)
di `obs_ct'
local notes1 "Values are [N] median (p25-p50)."
local notes2 "`obs_uss' contributing any ultrasound measurement."
local notes3 "`obs_ct' contributing any CT scan measurement."


* STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  
* THERE IS NOTHING TO MODIFY BEYOND THIS LINE UNLESS CHANGING CODE. 

* GENERATE TABLE STATS 

	table (var)(`col')  , ///
		stat(frequency) ///
		stat(count `adjwt_uss' `adjsq_uss' `adjwt_ct' `adjsq_ct') ///
		stat(p50 `adjwt_uss' `adjsq_uss' `adjwt_ct' `adjsq_ct') ///
		stat(p25 `adjwt_uss' `adjsq_uss' `adjwt_ct' `adjsq_ct') ///
		stat(p75 `adjwt_uss' `adjsq_uss' `adjwt_ct' `adjsq_ct') ///
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
	foreach v in `adjwt_uss' `adjsq_uss' `adjwt_ct' `adjsq_ct' {
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

	collect style cell result[column1]#var[`adjwt_uss' `adjsq_uss' `adjwt_ct' `adjsq_ct'], nformat(`nfrmt_p50')

* Add IQR formatting to p25 and p75 separately:
	collect style cell result[column2]#var[`adjwt_uss' `adjsq_uss' `adjwt_ct' `adjsq_ct'], nformat(`nfrmt_iqr') sformat("`sfrmt_p25'") /* formats iqr as (p25 - p75)*/
	collect style cell result[column3]#var[`adjwt_uss' `adjsq_uss' `adjwt_ct' `adjsq_ct'], nformat(`nfrmt_iqr') sformat("`sfrmt_p75'") 

* Format count column
	collect style cell result[count], nformat("%4.0f") /* Format count as whole number */
	collect style cell result[count], sformat("[%s]") /* Format count as whole number */
	
* Add text
	collect title `title'
	/*collect notes `notes1'
	collect notes `notes2'
	collect notes `notes3'
	collect notes `notes4'
	*/
	
collect preview

* Save first collection with main stats
collect layout (var) (ever_mal#result[count column1 column4])
collect save ./tables/radioadj.json, replace

* Create new collection for p-values
collect create c2
foreach v in `adjwt_uss' `adjsq_uss' `adjwt_ct' `adjsq_ct' {
    quietly kwallis `v', by(`col')
    collect: mystats
}
   
  
* Remap cmdset to match var levels
* Weighted USS measurements
collect recode cmdset 1 = adj_wt_pan_head_ap
collect recode cmdset 2 = adj_wt_pan_head_trans
collect recode cmdset 3 = adj_wt_pan_body_trans
collect recode cmdset 4 = adj_wt_pan_tail_trans

* Square root USS measurements
collect recode cmdset 5 = adj_sqrt_pan_head_ap
collect recode cmdset 6 = adj_sqrt_pan_head_trans
collect recode cmdset 7 = adj_sqrt_pan_body_trans
collect recode cmdset 8 = adj_sqrt_pan_tail_trans

* Weighted CT measurements
collect recode cmdset 9 = adj_wt_ct_pan_head_ap
collect recode cmdset 10 = adj_wt_ct_pan_head_trans
collect recode cmdset 11 = adj_wt_ct_pan_body_trans
collect recode cmdset 12 = adj_wt_ct_pan_tail_trans
collect recode cmdset 13 = adj_wt_ct_pan_body_tail
collect recode cmdset 14 = adj_wt_ct_pan_vol

* Square root CT measurements
collect recode cmdset 15 = adj_sqrt_ct_pan_head_ap
collect recode cmdset 16 = adj_sqrt_ct_pan_head_trans
collect recode cmdset 17 = adj_sqrt_ct_pan_body_trans
collect recode cmdset 18 = adj_sqrt_ct_pan_tail_trans
collect recode cmdset 19 = adj_sqrt_ct_pan_body_tail
collect recode cmdset 20 = adj_sqrt_ct_pan_vol

collect remap cmdset = var

* combine collections

collect combine c3 = c1 c2

* Add tags
collect addtags vartype[USS Adjusted by weight], fortags(var[adj_wt_pan_head_ap adj_wt_pan_head_trans adj_wt_pan_body_trans adj_wt_pan_tail_trans])
collect addtags vartype[USS Square Root Transformed], fortags(var[adj_sqrt_pan_head_ap adj_sqrt_pan_head_trans adj_sqrt_pan_body_trans adj_sqrt_pan_tail_trans])
collect addtags vartype[CT Adjusted by weight ], fortags(var[adj_wt_ct_pan_head_ap adj_wt_ct_pan_head_trans adj_wt_ct_pan_body_trans adj_wt_ct_pan_tail_trans adj_wt_ct_pan_body_tail adj_wt_ct_pan_vol])
collect addtags vartype[CT Square Root Transformed ], fortags(var[adj_sqrt_ct_pan_head_ap adj_sqrt_ct_pan_head_trans adj_sqrt_ct_pan_body_trans adj_sqrt_ct_pan_tail_trans adj_sqrt_ct_pan_body_tail adj_sqrt_ct_pan_vol])




* Create layout for combined collection
collect layout (vartype#var) (ever_mal#result[count column1 column4] result[p])   
   
collect label levels var adj_wt_pan_head_ap "USS Head, AP", modify
collect label levels var adj_wt_pan_head_trans "USS Head, Transverse", modify
collect label levels var adj_wt_pan_body_trans "USS Body, Transverse", modify
collect label levels var adj_wt_pan_tail_trans "USS Tail, Transverse", modify

collect label levels var adj_sqrt_pan_head_ap "USS Head, AP", modify
collect label levels var adj_sqrt_pan_head_trans "USS Head, Transverse", modify
collect label levels var adj_sqrt_pan_body_trans "USS Body, Transverse", modify
collect label levels var adj_sqrt_pan_tail_trans "USS Tail, Transverse", modify

collect label levels var adj_wt_ct_pan_head_ap "CT Head, AP", modify
collect label levels var adj_wt_ct_pan_head_trans "CT Head, Transverse", modify
collect label levels var adj_wt_ct_pan_body_trans "CT Body, Transverse", modify
collect label levels var adj_wt_ct_pan_tail_trans "CT Tail, Transverse", modify
collect label levels var adj_wt_ct_pan_body_tail "CT Body Tail Length", modify
collect label levels var adj_wt_ct_pan_vol "CT Volume", modify

collect label levels var adj_sqrt_ct_pan_head_ap "CT Head, AP", modify
collect label levels var adj_sqrt_ct_pan_head_trans "CT Head, Transverse", modify
collect label levels var adj_sqrt_ct_pan_body_trans "CT Body, Transverse", modify
collect label levels var adj_sqrt_ct_pan_tail_trans "CT Tail, Transverse", modify
collect label levels var adj_sqrt_ct_pan_body_tail "CT Body Tail Length", modify
collect label levels var adj_sqrt_ct_pan_vol "CT Volume", modify

collect notes, clear
collect notes "Values are [N] median (p25-p75)."
collect notes "P values are for Kruskal-Wallis tests."
collect title "Supplementary File Table Adjusted radiologic measurements in the whole cohort, by prior exposure"	


collect save ./tables/adj_radio, replace	
* Export combined table
collect export ./tables/adj_radio.html, as(html) replace
collect export ./tables/adj_radio.docx, as(docx) replace
collect export ./tables/adj_radio.xlsx, as(xlsx) replace




/* END END END END END END END END END END END END END END END END END END END END */
	


