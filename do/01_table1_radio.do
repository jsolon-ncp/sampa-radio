/* 01_table1_radio.do 
Juan Solon
2024 Nov 12

Purpose : Uses table collect to create a layout for Table 1 for Sampa Radiology Paper;
Limitations: Requires a separate .do file to place into a word file with page settings, borders, changes of text

Working Directory : ~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Analysis/Radiology
Dataset :~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Monitoring/data/sampa/All_combined_sampa_data.dta

Related Do Files
1. requires :
2. pre-requisite to :
diabetes definitions found in 02_cr_derive_diab.do used ~ line 85
	collect export tab1_radio_draft.docx, as(docx) replace noisily dofile(putdocxtab6.do, replace) - captures putdocx commands
	
Putdocxtab6.do file is manually revised to change set-up to landscape, add borders, text in rows 2 and 3, , NT for zeros in hiv.
Then run putdocxtab6.do again
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

* WORKING DIRECTORY

cd "$samparadio"
*cd "$dropboxsampa"
*cd "$sampadata"

* LOG

capture log close _all
capture cmdlog close
capture log using "./log/jslog.txt", replace text

* TEMPS

tempfile 1 2 3 4 5 6 

* USE

local dataset "All_combined_sampa_data.dta"

*. Use dataset /* revise as use*/
cd "$sampadata"
* use "../../Data Monitoring/data/sampa/All_combined_sampa_data.dta", clear
use "All_combined_sampa_data.dta", clear

* Make do file folder of paper the pwd
cd "$samparadio"
cd "do/"
cd "do-drafts-paper1.5"

* KEEP / DROP CRITERIA 

keep if ct_scan==1 | radio_exam ==1 | fecal_elastase !=.

save `1'

* CREATE A COUNT VARIABLE - modify accordingly - this should count the analysis dataset for the table ; used in frequency stats

gen N=1

* CREATE A COUNTRY VARIABLE

clonevar cohort2 = cohort
	label define cohort_countries 1 "DIVIDS (India)" 2 "SAM (Zambia)" 3 "CICADA (Tanzania)" 4 "NUSTART (Zambia)" 5 "St-ATT (Philippines)" 6 "CLHNS (Philippines)"
	label values cohort2 cohort_countries

* GENERATE DERIVED DIABETES VARIABLES

do 02_cr_derive_diab.do

* RELABEL CONTINUOUS VARIABLES FOR TABLE /* Revise as we would want to appear in table*/

label variable age "Age in years; Mean(SD)"
label variable bmi "BMI ; Median (IQR)"
label variable muac "MUAC ; Median (IQR)"
label variable hiv "HIV Status"
label variable diab "With Diabetes by history"
label variable diab_hb_gl120 "Diabetes Status"
label variable ever_mal "Malnutrition Status"


* CREATE LOCAL MACROS FOR VARIABLES IN TABLE - USE COMPLETE VARIABLE NAME)
	local scol "cohort2"
	local col "ever_mal"
	local contn "age" /*continous variables; mean (sd) will be reported*/
	local contmed "bmi muac"  /*continous variables; median (p25-p75)  will be reported*/
	local contgm ""  /*continous variables geometric mean (sd) will be reported*/
	local cat "diab_hb_gl120" /* categorical with multiple levels n(%) */
	local ind1 "sex" 
	local ind2 "hiv" 

* CREATE LOCAL MACROS FOR STANDARD TABLE HEADER 
	local colhead1 "Cohort"

	local colhead2 `"0 "NPM" 1 "PM""'
		
* IDENTIFY ROW VARIABLE HEADERS TO HIDE (SHOWING ONLY LEVELS - EG MALE FEMALE AND NO "SEX")		

*local hiderows "sex"

* NUMBER FORMATS

* format freq /* requires knowledge of levels*/ use collect levelsof [dim/level] to inspect

local frmt_catvar1 "1.sex 2.sex 0.hiv 1.hiv 0.diab_hb_gl120 1.diab_hb_gl120 2.diab_hb_gl120"
local nfrmt_freq "%5.0f"

* format percent  of catvar1
local nfrmt_perc "%5.0f" 
*local sfrmt_perc "%s%%"
local sfrmt_perc "%s"

* format means of `contn'
local nfrmt_mean "%5.0f"
local nfrmt_sd "%5.0f"
local sfrmt_sd "(%s)"

* format median of `contmed'
local nfrmt_p50 "%5.0f"
local nfrmt_iqr "%5.0f"
local sfrmt_p25 "(%s"
local sfrmt_p75 "%s)"

* Table Text /* Revise */ - comment out local notes5 for publication;

local title "Table 1. Participant Characteristics"

local notes1 "Not previously malnourished (NPM) ; Previously malnourished (PM)"
local notes2 "Variable distributions are reported as N(%) unless otherwise specified."
local notes3 "HIV Status refers to those suspected with HIV and subsequently tested positive or with a known positive test result."
local notes4 "Diabetes was defined as 2-hour plasma glucose from OGTT ≥11.1 mmol/L."
local notes5 ""Prediabetes refers to Impaired Fasting Plasma Glucose (FPG 5.55–6.94 mmol/L) or Impaired Glucose Tolerance (2-hour plasma glucose from OGTT at 7.77–11.05 mmol/L),or HbA1c ≥ 6.5% or FPG of ≥7.0 mmol/L; or an HbA1c level of 5.7–6.4%.""
*local notes5 "Created by "`c(username)'" on "`c(current_date)'" at "`c(current_time)'"  based on  All_combined_sampa_data.dta"

* STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  


* GENERATE TABLE STATS 

	table (var)(`scol' `col') , ///
		stat(count N) ///
		stat(mean `contn') ///
		stat(sd `contn') ///
		stat(p50 `contmed') ///
		stat(p25 `contmed') ///
		stat(p75 `contmed') ///
		stat(fvfrequency `ind1' `ind2' `cat') ///
		stat(fvpercent i.`ind1' i.`ind2' i.`cat') ///
			nototals ///
			nformat(%5.0f percent) ///
			nformat(%5.1f mean p25 p50 p75) ///
			nformat(%5.2f sd) 

* ASSIGN RESULTS TO DESIRED COLUMNS

	* recodes mean and sd in the collection to columns 1 and 2
		collect recode result count = column1
		collect recode result mean = column1
		collect recode result sd = column2

	* recodes fvfrequency and fvpercent in the collection to columns 1 and 2
		collect recode result fvfrequency = column1
		collect recode result fvpercent = column2
		
	* recodes median and iqr
		collect recode result p50 = column1
		collect recode result p25 = column2
		collect recode result p75 = column3
		
	* Create composite result combining p25 - p75 in one column
		collect composite define column4 = column2 column3, replace  delimiter(",") trim
		
	* Create composite result column1 and column4 to save space 
		collect composite define column5 = column1 column4, replace

	* collect label list result, all - used to see results

* CREATE THE TABLE 1 Layout Super column - column 
	* past codes for reference
	* collect layout (var) (region#diabetes#result[column1 column2])
	* collect layout (var) (`scol'#`col'#result[column1 column4])
	* collect layout (var) (`scol'#`col'#result[column5])
	* Note : we use column 5 because of line 185

collect layout (var) (cohort2#ever_mal#result[column5])


* CHANGE HEADER TEXT
	* supercolumn
		collect label dim `scol' "`colhead1'", modify
	* column
		collect label levels `col' `colhead2', modify

collect preview /* preview changes */

* MODIFY COLUMN HEADERS

	* Hide supercolumn variable name because it is self-descriptive
		*collect style header `scol', title(hide) /* this removes the column variable name or label by hiding it */

	* Hide the column variable name 
		collect style header `col', title(hide) /* this removes the column variable name or label by hiding it */

	* Hide the words column#  for the results 
		collect style header result, level(hide) /* this removes column header names*/
	

collect preview /* preview changes */

* HIDE ROW Text
	* Hide the variable names, or not (comment out)
	* collect style header `hiderows', title(hide)
	
* MODIFY ROW TEXT
	* change labels of levels
	collect label levels hiv 1 "Seropositive", modify
	collect label levels hiv 0 "Seronegative", modify

* REVISE ROW STYLES

	* Stack levels of each variable , place a space between variables (spacer) ; 
	collect style row stack, nobinder nospacer

	* Remove vertical line after variables
	collect style cell border_block, border(right, pattern(nil))

	* Remove spaces between rows


* FORMAT NUMBERS (see line 113)

* Format median
	collect style cell result[column1]#var[`contmed'], nformat(`nfrmt_p50')

* Add IQR formatting to p25 and p75 separately:
	collect style cell result[column2]#var[`contmed'], nformat(`nfrmt_iqr') sformat("`sfrmt_p25'") /* formats iqr as (p25 - p75)*/
	collect style cell result[column3]#var[`contmed'], nformat(`nfrmt_iqr') sformat("`sfrmt_p75'") 

* Format factor variables (categorical) column 1 and column 2
	collect style cell var[`frmt_catvar1']#result[column1], nformat(`nfrmt_freq')
	collect style cell var[`frmt_catvar1']#result[column2], nformat(`nfrmt_perc') sformat("(`sfrmt_perc')") /* Adds (%) to percent */

* Format means and sd variables column 1 and column 2

	collect style cell var[`contn']#result[column1], nformat(`nfrmt_mean') /* Formats continuous variable to one decimal*/
	collect style cell var[`contn']#result[column2], nformat(`nfrmt_sd') sformat(`sfrmt_sd') /* Formats continuous variable to one decimal*/

* TITLE and NOTES
* Add text
	collect title `title'
	collect notes `notes1'
	collect notes `notes2'
	collect notes `notes3'
	collect notes `notes4'
	collect notes `notes5'	

* Navigate to output folder
cd "$samparadio"
cd tables

* Specify Font and size to results and notes 

collect style cell, font(helvetica, size(11 pt))

collect style cell, margin( , width(4 pt))

collect style notes, font(helvetica, size(8 pt))

* FORMAT CELL BORDERS
collect style cell var[N age bmi muac 2.sex 1.hiv 2.diab_hb_gl120], border(bottom, width(1 pt))
collect style cell var[N], border(top, width(1 pt))
collect style cell cell_type[column-header], border(bottom, width(3 pt))



* Create a Word file that is landscape
/*
putdocx begin, pagesize(A4) ///
				landscape ///
				margin(left, 0.5 cm) ///
				margin(right, 0.5 cm)

putdocx paragraph
putdocx text ("Tables")

putdocx collect, name(Table)

putdocx save Tables.docx ,replace
*/


* Navigate to output folder
cd "$samparadio"

cd do
cd "do-drafts-paper1.5/"

do 02_table1_putdocx.do

* Export
	collect export tab1_radio_rev3.html, as(html) replace
	collect export tab1_radio_rev3.docx, as(docx) replace 
	collect export tab1_radio_rev3.xlsx, as(xlsx) replace
	collect export tab1_radio_rev3.pdf, as(pdf) replace




/*
* Export
	collect export tab1_radio_draft.html, as(html) replace
	collect export tab1_radio_draft.docx, as(docx) replace noisily dofile(putdocxtab2.do, replace)
	collect export tab1_radio_draft.xlsx, as(xlsx) replace
	collect export tab1_radio_draft.pdf, as(pdf) replace

*  Navigate to do file folder
cd "$dropboxradio"
cd "02 do/"
cd "do-drafts-paper1.5"
	
/* END END END END END END END END END END END END END END END END END END END END */
	

/* archived notes


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
/*	title("Table 1: Charateristics by Cohort and Nutritional STatus")
	putdocx collect /*exports our table to the document*/
	putdocx save template_tab1.docx, replace
*/

*cd "$dropboxradio" /* change to your pwd or any desired folder */

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

  