/* template_1c.do

Notes
1. Needs at least Stata version 17 
2. Uses the table and the collect commands.
3. Uses putdocx.
4. Input : Wide dataset
5. Output : Table 1 in .docx  with:
- continuous variable summary mean SD 
- categorical variable frequencies and percentages across groups
- Supercolumn and columns (eg cohort and nutritional status)
- Rows as variables being reported across columns
6.  Coding notes
-  Percentages must compare columns and requires using "i." before the categorical variable in the code and "across()"
- every summary statistic is placed as a separate line for ease of revision.
- Indent the stats and Indent the formats for clarity
- the IQR, and confidence intervals have to be combined into one column see statalist suggestion (see sources)
7.  Adds median ci
7. Exclusions
- statistical tests
- footnotes
- p values CIs of stat test significance testing

Sources

*Stata Blog by Chuck Huber the Classit Table 1 for Stata 17
https://blog.stata.com/2021/06/24/customizable-tables-in-stata-17-part-3-the-classic-table-1/

* Statalist - code for formatting iqr using collect.
https://www.statalist.org/forums/forum/general-stata-discussion/general/1690975-formatted-iqr-using-collect

*/

** Use dataset
local dataset "nhanes2l"
*. Create dataset and a new binary variable x

webuse `dataset', clear

* CREATE LOCAL MACROS FOR VARIABLES IN TABLE - USE COMPLETE VARIABLE NAME)
	local scol "region"
	local col "diabetes"
	local contn "age bmi"
	local contmed "hgb"
	local contgm "zinc"
	local cat "hlthstat"
	local ind "sex"

* CREATE LOCAL MACROS FOR STANDARD TABLE HEADER 
	local colhead1 "Modified Supercolumn name"

	local colhead2 `"0 "grpa" 1 "grpb""'
		
		* NOTES *local col2levels " "0 Modified Grp2"  "1 Modified Grp1""
		*collect label levels diabetes 0 "Modified Grp1"  1 "Modified Grp2", modify
		*local col2levels ""0 "Modified Grpa"  1 "Modified Grpb""

* IDENTIFY ROW VARIABLE HEADERS TO HIDE (SHOWING ONLY LEVELS - EG MALE FEMALE AND NO "SEX")		

local hiderows "sex"

* NUMBER FORMATS

* format freq /* requires knowledge of levels*/

local frmt_catvar1 "1.sex 2.sex 1.hlthstat 2.hlthstat 3.hlthstat 4.hlthstat 5.hlthstat"
local nfrmt_freq "%5.0f"

* format percent  of catvar1
local nfrmt_perc "%5.0f" 
local sfrmt_perc "%s%%"

* format means of `contn'
local nfrmt_mean "%5.0f"
local nfrmt_sd "%5.0f"
local sfrmt_sd "(%s)"

* format median of `contmed'
local nfrmt_p50 "%5.0f"
local nfrmt_iqr "%5.0f"
local sfrmt_p25 "(%s -"
local sfrmt_p75 "%s)"

* Table Text

local age : var label age
local bmi : var label bmi
local hgb : var label hgb

local title "Table 1. Participant Characteristics"
local notes1 "Variable distributions are reported as n(%) unless otherwise specified"
local notes2 " `age' and `bmi' are Mean(SD).  `hgb' is Median(IQR)"

*(%5.0f) sformat("(%s%%)""
*collect style cell var[1.sex 2.sex 1.hlthstat]#result[column2], nformat(%5.0f) sformat("(%s%%)")
* format sds
*local frmt_catvar1 "1.sex 2.sex 1.hlthstat 2.hlthstat 3.hlthstat 4.hlthstat 5.hlthstat"
*local nfrmt_sd "%5.0f"


/*
local frmt_means "`contn'"

local frmt_contvar1 "age bmi hgb zinc"
*/

* GENERATE TABLE STATS 

	table (var)(`scol' `col') , ///
		stat(count `contn') ///
		stat(mean `contn') ///
		stat(sd `contn') ///
		stat(p50 `contmed') ///
		stat(p25 `contmed') ///
		stat(p75 `contmed') ///
		stat(fvfrequency `ind' `cat') ///
		stat(percent i.`ind'  i.`cat', across(`col')) ///
			nototals ///
			nformat(%5.0f percent) ///
			nformat(%5.1f mean p25 p50 p75) ///
			nformat(%5.2f sd) 

*REFORMAT RESULTS TO DESIRED COLUMNS

	* recodes mean and sd in the collection to columns 1 and 2
		collect recode result count = column1
		collect recode result mean = column1
		collect recode result sd = column2

	* recodes fvfrequency and percent in the collection to columns 1 and 2
		collect recode result fvfrequency = column1
		collect recode result percent = column2
		
	* recodes median and iqr
		collect recode result p50 = column1
		collect recode result p25 = column2
		collect recode result p75 = column3
		
	* Create composite result : this is needed because 75 is in column3 and we want it in the same column as column 2 .  Use for medians and probably CIs
		collect composite define column4 = column2 column3, replace

	* collect label list result, all - used to see results

* CREATE THE TABLE 1 Layout Super column - column 

	* collect layout (var) (region#diabetes#result[column1 column2])

	collect layout (var) (`scol'#`col'#result[column1 column4])


* CHANGE HEADER TEXT
	* supercolumn
		collect label dim `scol' "`colhead1'", modify
	* column
		collect label levels `col' `colhead2', modify

collect preview /* preview changes */

* HIDE COLUMN HEADERS

	* Hide supercolumn variable name because it is self-descriptive
		
		collect style header `scol', title(hide) /* this removes the column variable name or label by hiding it */

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


* format factor variables (categorical) column 1 and column 2

	collect style cell var[`frmt_catvar1']#result[column1], nformat(`nfrmt_freq')

	collect style cell var[`frmt_catvar1']#result[column2], nformat(`nfrmt_perc') sformat("(`sfrmt_perc')") /* Adds (%) to percent */

* format means variable column 1 and column 2

	collect style cell var[`contn']#result[column1], nformat(`nfrmt_mean') /* Formats continuous variable to one decimal*/

	collect style cell var[`contn']#result[column2], nformat(`nfrmt_sd') sformat(`sfrmt_sd') /* Formats continuous variable to one decimal*/

* Add text
	collect title `title'
	collect notes `notes1'
	collect notes `notes2'
	
* Export
	collect export preview.html, as(html) replace



/* Pending as of Oct 12 1415 gmt+8
1. Formatting of median iqr as median [p25-p75]
2.  Formatting of SD as ()
3. Add geometric mean CI as GM [lb - ub]
4. Hide selected levels of a variable  for instance showin only Poor hlthstat or Show only females
5. Modify text of each variable : for instance "Body mass index (BMI)" to "BMI"
6. Add t-tests , ranksum across group ie, local `col' as columns.
7. Add regression p values
8. Export to word using collect, export if possible formatted such that columns are already resized and readable 
--- note, it should like collect export as html
--- if not possible to do this, then the putdocx code to format 

*/

/* archived notes


* format continuous variables column 1
collect style cell var[bp_before bp_after]#result[column1 column2], nformat(%5.1f) /* Formats continuous variable to one decimal*/

* format continuous variables column 2 
. collect style cell var[bp_before bp_after]#result[column2], sformat("(%s)") /* Adds parenthesis after SD*/



collect style cell var[`frmt_catvar1']#result[column2], nformat(`nfrmt_perc')

collect style cell var[1.sex 2.sex ]#result[column1], nformat(%5.0f) /*Formats factor number */ 

collect style cell var[1.sex 2.sex ]#result[column1], nformat(%5.2f) /*Formats factor number */ 

collect style cell var[sex]#result[column1], nformat(%5.2f) /*Formats factor number */ 

collect style cell var[hlthstat]#result[column1], nformat(%5.0f) /*Formats factor number */ 

* format factor variables (categorical) column 2
collect style cell var[1.sex 2.sex 1.hlthstat]#result[column2], nformat(%5.0f) sformat("(%s%%)") /* Adds (%) to percent */

collect style cell var[1.sex 2.sex]#result[column2], nformat(%5.0f) sformat("(%s%%)") /* Adds (%) to percent */

* format continuous variables column 1
collect style cell var[bp_before bp_after]#result[column1 column2], nformat(%5.1f) /* Formats continuous variable to one decimal*/

* format continuous variables column 2 
. collect style cell var[bp_before bp_after]#result[column2], sformat("(%s)") /* Adds parenthesis after SD*/





* Rows - change text in rows
collect label levels var 0.sex "Male" 1.sex "Female", modify /* This changes the level of sex to male and female*/
collect label levels var bp_before "BP Before" bp_after "BP After", modify 

* FORMAT NUMBERS

* format factor variables (categorical) column 1
collect style cell var[0.sex 1.sex]#result[column1], nformat(%5.0f) /*Formats factor number */ 

* format factor variables (categorical) column 2
collect style cell var[0.sex 1.sex]#result[column2], nformat(%5.0f) sformat("(%s%%)") /* Adds (%) to percent */

* format continuous variables column 1
collect style cell var[bp_before bp_after]#result[column1 column2], nformat(%5.1f) /* Formats continuous variable to one decimal*/

* format continuous variables column 2 
. collect style cell var[bp_before bp_after]#result[column2], sformat("(%s)") /* Adds parenthesis after SD*/


collect preview

* Customize Column Labels

* Modify supercolumn name - can be done without replacing variable labels with replace variable label "label"

collect label dim agegrp "Patient Age Group", modify

* Modify column name 

collect label levels x 0 "NPM" 1 "PM", modify

* Revise header style to hide levels of a dimension, in this case, the dimension of results (ie what you would see in collect levelsof )

collect style header result, level(hide)

* Revised rows style

collect style row stack, nobinder spacer

collect style cell border_block, border(right, pattern(nil))

collect preview

* Export to Word
* Check your present working directory as this file saves there.  Alternatively ,specify relative path

cd "$dropboxradio" /* change to your pwd or any desired folder */

putdocx begin /* Start of Word Input*/
	putdocx paragraph, style(Heading1)
		putdocx text ("Table 1. Participant Charateristics")
	putdocx paragraph, style(Heading1)
		putdocx text ("x") 
	putdocx paragraph
		putdocx text ("stuff ") 
		putdocx text ("stuff stuff ")
		putdocx text ("stuff stuff stuff .")
	collect style putdocx, layout(autofitcontents) ///  use layout(autofitcontents) to retain original width of table */
	title("Table 1: Charateristics by Cohort and Nutritional STatus")
	putdocx collect /*exports our table to the document*/
	putdocx save template_tab1.docx, replace


cd "$dropboxradio" /* change to your pwd or any desired folder */

/* Other summaries 

table (var) (sex), statistic(p50 age_adm_m) statistic(p25 age_adm_m) statistic(p75 age_adm_m) nototals
collect style cell result[p25 p50 p75], nformat("%4.1f")
collect composite define iqr = p25 p75 , delimiter(" - ") trim
collect style cell result[iqr], sformat("(%s)")
collect composite define mediqr = p50 iqr, trim

collect style header result, level(hide)
collect style row stack, nobinder spacer
collect style cell border_block, border(right, pattern(nil))
collect layout (var) (sex#result[mediqr])


media
/* Alternative start .dta xample - Ignore


use https://www.stata-press.com/data/r18/nhanes2l, clear

collect clear

 sort sex region
 
 collect: by sex region: summarize weight
 
 collect layout (sex) (region) (result[mean])
 
 collect layout (region[1] region[3] region[4]) (sex[2]) (result[mean])
 
 collect layout (sex#region) (result[mean])
 
 collect layout (sex#region) () (result[mean])
 
 collect layout (sex#region#result[mean])
 
 collect layout (sex#region) (result)
 
 collect style cell result, nformat(%6.2f)
 
  collect style cell result, nformat(%9.0g)
  
  collect preview
  
  collect layout (region) (sex) (result[N])
  
  collect layout (sex#result[mean N]) (region)
  
  collect layout (region#result[mean min max]) (sex)
  
  
  collect layout (region#result[mean min max]) (sex)
  
  
  * Regression
  
  collect clear
  collect : regress bpsystol age weight  
  collect : regress bpsystol age weight i.hlthstat
  
  collect label list cmdset, all
  
  collect style autolevels result _r_b _r_se
collect layout (colname#result) (cmdset)
  
  statistic(p50 bp_before bp_after)
  
  
  table (var) (sex), ///
    statistic(frequency) ///
    statistic(p50 age_adm_m) statistic(p25 age_adm_m) statistic(p75 age_adm_m) ///
    statistic(fvfrequency age_adm_cat) statistic(fvpercent age_adm_cat) ///
    nototals

// Give Frequency of categorical vars and median of continuous vars the same label:
collect recode result frequency=col1 fvfrequency=col1 p50=col1

// Give percent of categorical vars and 25th percentile of continuous vars the same label:
collect recode result fvpercent=col2 p25=col2

// Recode 75th percentile to a third column:  
collect recode result p75=col3 

// Format median: 
collect style cell result[col1]#var[age_adm_m], nformat("%4.1f")

// Add IQR formatting to p25 and p75 separately:
collect style cell result[col2]#var[age_adm_m], nformat("%4.1f") sformat("(%s -")
collect style cell result[col3]#var[age_adm_m], nformat("%4.1f") sformat("%s)")

// Put % after percent:
collect style cell result[col2]#var[age_adm_cat], nformat("%4.1f") sformat("%s%%")

// Create composite result:
collect composite define col4 = col2 col3

collect style header result, level(hide)
collect style row stack, nobinder spacer
collect style cell border_block, border(right, pattern(nil))
collect layout (var) (sex#result[col1 col4])


  