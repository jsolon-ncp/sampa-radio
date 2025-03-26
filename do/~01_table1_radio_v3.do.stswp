/* 01_table1_radio._v2.do 
Juan Solon
2025 Jan15

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


Remove MUAC
Just one sex
Seroposive only 
R


Variable distributions are reported as n(%) unless otherwise specified. Where the denominator is less than shown at the column head it is given in each cell.
2 HIV status: NT=not tested; status unknown for DIVIDS, St-ATT & CLHNS; HIV status was known for most tested for all African participants. 
34 Diabetes was defined as 2-hour plasma glucose from oral glucose tolerance (OGTT) ≥11.1 mmol/L and /or HbA1c ≥6.5%
4 USS = ultrasound; CT = CT Scan; NPM = Not Previously Malnourished; PM = Previously Malnourished


NPM, no prior wasting malnutrition; PM, prior wasting malnutrition; BMI, body mass index; DIVIDS, Delhi Infant Vitamin D Supplementation Trial, India; SAM, Severe Acute Malnutrition, Zambia; CICADA, Chronic Infections, Comorbidities and Diabetes in Africa, Tanzania; NUSTART, Nutritional Support for African Adults Starting Anti-retroviral Therapy, Zambia; St-ATT, Starting Anti-TB Treatment, Philippines; CLHNS, Cebu Longitudinal Health and Nutrition Survey, Philippines
*/

version 18.5

*CLEAR


/*
* RELABEL CONTINUOUS VARIABLES FOR TABLE /* Revise as we would want to appear in table*/

label variable age "Age in years; Mean(SD)"
label variable bmi "BMI ; Median (IQR)"
* label variable muac "MUAC ; Median (IQR)"
label var ct_scan "with CT Scan"
label var radio_exam "with Ultrasound"
label var fec_with "with Fecal Elastase"
label variable hiv "HIV Status"
label variable diab "With Diabetes by history"
label variable diab_hb_gl120 "Diabetes Status"
label variable ever_mal "Malnutrition Status"

*/
** recode cohort

recode cohort 3 = 4 4 = 5 5 = 6 6 = 3, gen(cohort2)

	label define cohort2 1 "DIVIDS (India)" 2 "SAM (Zambia)" 4 "CICADA (Tanzania)" 5 "NUSTART (Zambia)" 6 "St-ATT (Philippines)" 3 "CLHNS (Philippines)"
	label values cohort2 cohort2

* CREATE LOCAL MACROS FOR VARIABLES IN TABLE - USE COMPLETE VARIABLE NAME)
	local scol "cohort2"
	local col "ever_mal"
	local contn1 "age " /*continous variables; mean (sd) will be reported*/
	local contn2 "weight"
	local cat "diab_hb_gl120" /* categorical with multiple levels n(%) */
	local ind1 "2.sex" 
	local ind2 "1.hiv" 
	local ind3 "1.ct2 1.radio3" 
	local ind4 "1.assay_fecal_elastase" 
	local ind5 "1.epi_bin" 

* CREATE LOCAL MACROS FOR STANDARD TABLE HEADER 
	local colhead1 "Cohort"

	local colhead2 `"0 "NPM" 1 "PM""'
		
* IDENTIFY ROW VARIABLE HEADERS TO HIDE (SHOWING ONLY LEVELS - EG MALE FEMALE AND NO "SEX")		

*local hiderows "sex"

* NUMBER FORMATS

* format freq /* requires knowledge of levels*/ use collect levelsof [dim/level] to inspect

local frmt_catvar1 `ind1' `ind2' `ind3' `ind4' `ind5'
local nfrmt_freq "%5.0f"

* format percent  of catvar1
local nfrmt_perc "%5.0f" 
*local sfrmt_perc "%s%%"
local sfrmt_perc "%s"

* format means of `contn'
local nfrmt_mean "%5.1f"
local nfrmt_sd "%5.1f"
local sfrmt_sd "(%s)"

* format median of `contmed'
local nfrmt_p50 "%5.0f"
local nfrmt_iqr "%5.0f"
local sfrmt_p25 "(%s"
local sfrmt_p75 "%s)"

* Table Text /* Revise */ - comment out local notes5 for publication;

local title "Table 1. Participant Characteristics"

local notes1 "Variable distributions are reported as n(%) unless otherwise specified. Where the denominator is less than shown at the column head it is given per cell"
local notes2 "Variable distributions are reported as N(%) unless otherwise specified."
local notes3 "Diabetes was defined as 2-hour plasma glucose from oral glucose tolerance (OGTT) ≥11.1 mmol/L and /or HbA1c ≥6.5%"
local notes4 "USS ultrasound CT CT Scan NPM Not Previously Malnourished PM Previously Malnourished"


* STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  


* GENERATE TABLE STATS 
/*local ind1 "2.sex" 
	local ind2 "1.hiv" 
	
table (var)(cohort ever_mal) , ///
stat(frequency) ///
stat(mean age) ///
stat(fvfrequency `ind1' `ind2') ///
*/

	table (var)(`scol' `col') , ///
		stat(frequency) ///
		stat(mean `contn1' `contn2') ///
		stat(sd `contn1' `contn2') ///
		stat(fvfrequency `ind1' `ind2' `ind3' `ind4' `ind5' `cat') ///
		stat(fvpercent `ind1' `ind2' `ind3' `ind4' `ind5' i.`cat') ///
			nototals ///
			nformat(%5.0f percent) ///
			nformat(%5.1f mean p25 p50 p75) ///
			nformat(%5.2f sd) 

* ASSIGN RESULTS TO DESIRED COLUMNS

collect layout (var) (cohort2#ever_mal#result[])


	* recodes mean and sd in the collection to columns 1 and 2
		collect recode result frequency = column1
		collect recode result mean = column1
		collect recode result sd = column2

	* recodes fvfrequency and fvpercent in the collection to columns 1 and 2
		collect recode result fvfrequency = column1
		collect recode result fvpercent = column2
		
	/* recodes median and iqr
		collect recode result p50 = column1
		collect recode result p25 = column2
		collect recode result p75 = column3
		
	* Create composite result combining p25 - p75 in one column
		collect composite define column4 = column2 column3, replace  delimiter(",") trim
		
	* Create composite result column1 and column4 to save space 
		collect composite define column5 = column1 column4, replace
*/
	 collect label list result, all /* used to see results*/

* CREATE THE TABLE 1 Layout Super column - column 
	local scol "cohort2"
	local col "ever_mal"
	local contn1 "age " /*continous variables; mean (sd) will be reported*/
	local contn2 "weight"
	local cat "diab_hb_gl120" /* categorical with multiple levels n(%) */
	local ind1 "2.sex" 
	local ind2 "1.hiv" 
	local ind3 "1.ct2 1.radio3" 
	local ind4 "1.assay_fecal_elastase" 
	local ind5 "1.epi_binary" 

/*collect layout (var[`contn1' `ind1' `ind2' `contn2' `cat' `ind5' `ind3' `ind4']) (cohort2#ever_mal#result[column1 column2])
*/

collect layout (var[`contn1' `ind1' `ind2' `contn2' `cat' `ind5' `ind3' `ind4']) (`scol'#`col'#result[column1 column2])

collect export ./tables/preview.html, as(html) replace
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

/* Format median
	collect style cell result[column1]#var[`contmed'], nformat(`nfrmt_p50')

* Add IQR formatting to p25 and p75 separately:
	collect style cell result[column2]#var[`contmed'], nformat(`nfrmt_iqr') sformat("`sfrmt_p25'") /* formats iqr as (p25 - p75)*/
	collect style cell result[column3]#var[`contmed'], nformat(`nfrmt_iqr') sformat("`sfrmt_p75'") 
*/
* Format factor variables (categorical) column 1 and column 2
	collect style cell var[`frmt_catvar1']#result[column1], nformat(`nfrmt_freq')
	collect style cell var[`frmt_catvar1']#result[column2], nformat(`nfrmt_perc') sformat("(`sfrmt_perc')") /* Adds (%) to percent */

* Format means and sd variables column 1 and column 2

	collect style cell var[`contn']#result[column1], nformat(`nfrmt_mean') /* Formats continuous variable to one decimal*/
	collect style cell var[`contn']#result[column2], nformat(`nfrmt_sd') sformat(`sfrmt_sd') /* Formats continuous variable to one decimal*/

***ROWS

    collect label levels sex 1 "Female sex" , modify
	collect label levels hiv 1 "HIv Seropositive" ,  modify
	collect label levels ct2 1 "With CT Scan",  modify
	collect label levels radio3 1 "With Ultrasound",  modify
	collect label levels assay_f 1 "With Faecal Elastase",  modify
	collect label levels epi_bin 1 "EPI",  modify

    local cat "diab_hb_gl120" /* categorical with multiple levels n(%) */
	local ind1 "2.sex" 
	local ind2 "1.hiv" 
	local ind3 "1.ct2 1.radio3" 
	local ind4 "1.assay_fecal_elastase" 
	local ind5 "1.epi_binary" 
* REMOVE level name in rows to show only the  label names
   
   local cat "2.sex 1.hiv 1.ct2 1.radio3 1.assay_fecal_elastase 1.epi_binary"
   
   
   foreach x in "`cat'" {
		collect style header var[`x'], title(hide)
		}
	
* TITLE and NOTES
* Add text
	collect title `title'
	collect notes `notes1'
	collect notes `notes2'
	collect notes `notes3'
	collect notes `notes4'
	collect notes `notes5'	

* Specify Font and size to results and notes 

collect style cell, font(arial, size(11 pt))
collect style notes, font(arial, size(11 pt))

collect rename Table participants, replace
collect save ./tables/participants, replace

collect export ./tables/participants.html, as(html) replace
	
	
	collect export tab1_radio_rev3.docx, as(docx) replace 
	collect export tab1_radio_rev3.xlsx, as(xlsx) replace
	collect export tab1_radio_rev3.pdf, as(pdf) replace


/*
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

  