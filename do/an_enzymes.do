/* enzymes.do
Sampa 2025 mar 23

kwallis p value

di chi2tail(r(df),r(chi2))
*/

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
local contmed "fecal_elastase ul_amylp lipase  ngml_trypsinogen"  /*continous variables; median (p25-p75)  will be reported*/

local colhead2 `"0 "NPM" 1 "PM""'
		
* format median of `contmed'
local nfrmt_p50 "%5.0f"
local nfrmt_iqr "%5.0f"
local sfrmt_p25 "(%s-"
local sfrmt_p75 "%s)"

local title "Table . Pancreatic Enzyme Assays"

local notes1 "Values are [N] median (p25-p50)."
local notes2 "Faecal elastase values are upper limit of detection is 600."
local notes3 "Lipase from DIVIDS cohort only."
local notes4 "Trypsinogen from CT Scan subset only."

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
collect save ./tables/enzymes1.json, replace

* Create new collection for p-values
collect create c2
foreach v in `contmed' {
    quietly kwallis `v', by(`col')
    collect: mystats
}

* Remap cmdset to match var levels
collect recode cmdset 1 = fecal_elastase
collect recode cmdset 2 = ul_amylp
collect recode cmdset 3 = lipase
collect recode cmdset 4 = ngml_trypsinogen
collect remap cmdset = var

* Combine collections
collect combine c3 = c1 c2

* Create layout for combined collection
collect layout (var) (ever_mal#result[count column1 column4] result[p])

collect save ./tables/enzymes, replace
* Export combined table
collect export ./tables/enzymes.html, as(html) replace
collect export ./tables/enzymes.docx, as(docx) replace

collect export preview.xlsx, as(xlsx) replace

/* END END END END END END END END END END END END END END END END END END END END */
	
