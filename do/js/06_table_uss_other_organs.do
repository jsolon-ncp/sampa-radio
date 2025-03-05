/* 06_table_uss_other_organs.do 
Juan Solon
2025 Feb 

Purpose : Clean and Tabulate Other findings on ultrasound 
captured by the variable pan_oth_abn_spec and pan_oth_abn_specify

Logic:
The variable pan_oth_abnormal is categorical and indicates whether there are other abnormalities
The variable pan_oth_abn_specify has the text details
Regular expressions are used to match specific text to organ involvement.

Output files : pan_organs

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
local dofilename "06_table_uss_other_organs.do"

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

tempfile 1 2 3 4 5 6 

* USE

local dataset "All_combined_sampa_data.dta"

*. Use dataset /* revise as use*/
cd "$sampadata"
* use "../../Data Monitoring/data/sampa/All_combined_sampa_data.dta", clear
use "All_combined_sampa_data.dta", clear

cd "$ghsamparadio"

/* Make do file folder of paper the pwd
cd "$samparadio"
cd "do/"
cd "do-drafts-paper1.5"
*/

**# REFERENCE VARIABLES
/*  These are the USS Variables
pan_shape pan_shape_problem pan_shape_prob_specify pan_contour pan_contour_problem pan_contour_prob_specify pan_parenchyma pan_paren_inflam pan_paren_fibrosis pan_paren_steatosis pan_duct pan_dupan_stones pan_dupan_mass pan_calci pan_calci_place pan_cyst_yes pan_oth_abnormal pan_oth_abn_specify
*/

/* These are the CT Variables
pan_scan pan_date pan_time pan_pan_size_qual pan_pan_head_trans pan_pan_head_ap pan_pan_body_trans pan_pan_tail_trans pan_pan_body_tail pan_pan_cc_body pan_pan_cc_head 
pan_pan_shape pan_pan_shape_problem pan_pan_shape_prob_spec 
pan_pan_contour pan_pan_contour_problem pan_pan_contour_prob_spec 
pan_pan_parenchyma pan_pan_paren_inflam pan_pan_paren_fibrosis pan_pan_paren_steatosis 
pan_pan_duct pan_pan_dupan_stones pan_pan_dupan_mass pan_pan_calci pan_pan_calci_place 
pan_oth_abnormal pan_oth_abn_spec 
pan_image_qual pan_problem pan_problem_why name_ct sig_ct sig_pan_upload file_ct file_ct2 file_ct3 file_ct4 file_ct5 file_ct6 file_ct7 file_ct8 file_ct9 file_ct10 pan_pan_vol
*/

/* Inspect
table pan_oth_abnormal
missings report pan_oth_abn_specify
table pan_oth_abn_specify

export delimited cohort sampa_id pan_oth_abnormal pan_oth_abn_specify using ../02-data-temp/pan_oth_abn_specify.csv, delim(",") replace
*/
*cd "$ghsamparadio"
*export delimited cohort sampa_id pan_oth_abnormal pan_oth_abn_specify using 02-data-temp/pan_oth_abn_specify.csv if pan_oth_abnormal==1, delim(",") replace
********* PAN OTHER ABN SPECIFY **************

**# CLEAN STRINGS FOR REGULAR EXPRESSIONS */

tempvar clean_pan_oth_abn_specify // Using a tempvar to clean data 
gen `clean_pan_oth_abn_specify' = pan_oth_abn_specify

// Remove common punctuation marks

local punct ". , ; : ? ! ' ( ) [ ]" // Added parentheses and brackets

foreach p of local punct {
    replace `clean_pan_oth_abn_specify' = subinstr(`clean_pan_oth_abn_specify', "`p'", "", .)
}

// Replace hyphens and slashes separately (as you want to replace with spaces)
replace `clean_pan_oth_abn_specify' = subinstr(`clean_pan_oth_abn_specify', "-", " ", .)
replace `clean_pan_oth_abn_specify' = subinstr(`clean_pan_oth_abn_specify', "/", " ", .)

// Trim extra spaces
replace `clean_pan_oth_abn_specify' = trim(`clean_pan_oth_abn_specify')
replace `clean_pan_oth_abn_specify' = strtrim(`clean_pan_oth_abn_specify') // Remove multiple spaces

// Convert to lowercase
replace `clean_pan_oth_abn_specify' = lower(`clean_pan_oth_abn_specify')


// Creating local macros for strings found in pan_oth_abn_specify 

local lung_terms "empty"  // Dummy string to avoid empty regex
local liver_terms "liver|hepatic|hepatomegaly|fatty liver|fatty infiltration|hepatic steatosis|haemangioma|echogenic liver lesion|liver lesions|liver mass|parenchymal echogenicity|hepatic cysts|necrotic periportal lymph nodes"
local gallbladder_terms "gallbladder|gallstone|cholelithiasis|gall stones|cholecystitis|lithiases|calculus"
local spleen_terms "spleen|splenomegaly|bulky spleen"
local pancreas_terms "empty" // Dummy string to avoid empty regex
local kidney_terms "kidney|renal|nephrolithiasis|atrophic kidneys|hydronephrosis|parapelvic cyst|reduced kidney sizes|chronic kidney disease"
local uterus_ovary_terms "uterus|ovary|fibroid|ovarian cyst|adnexal cyst|multi-fibroid uterus|dermoid cyst|gynae review|ovarian"
local bone_spine_terms "empty" // Dummy string to avoid empty regex
local vascular_terms "portal hypertension"
local heart_terms "empty" // Dummy string to avoid empty regex
local stomach_intestine_terms "worm infestation|o polyp"
local adrenal_terms "empty" // Dummy string to avoid empty regex
local mass_terms "mass|lymph nodes|lesion|haematoma|cystic\s+mass|\? haematoma|: multilocular cystic mass"

// Generate organ specific involvment based on regexm and macros above

gen pan_lung = regexm(lower(`clean_pan_oth_abn_specify'), "`lung_terms'")
gen pan_liver = regexm(lower(`clean_pan_oth_abn_specify'), "`liver_terms'")
gen pan_gallbladder = regexm(lower(`clean_pan_oth_abn_specify'), "`gallbladder_terms'")
gen pan_spleen = regexm(lower(`clean_pan_oth_abn_specify'), "`spleen_terms'")
gen pan_pancreas = regexm(lower(`clean_pan_oth_abn_specify'), "`pancreas_terms'")
gen pan_kidney = regexm(lower(`clean_pan_oth_abn_specify'), "`kidney_terms'")
gen pan_uterus_ovary = regexm(lower(`clean_pan_oth_abn_specify'), "`uterus_ovary_terms'")
gen pan_bone_spine = regexm(lower(`clean_pan_oth_abn_specify'), "`bone_spine_terms'")
gen pan_vascular = regexm(lower(`clean_pan_oth_abn_specify'), "`vascular_terms'")
gen pan_heart = regexm(lower(`clean_pan_oth_abn_specify'), "`heart_terms'")
gen pan_stomach_intestine = regexm(lower(`clean_pan_oth_abn_specify'), "`stomach_intestine_terms'")
gen pan_adrenal = regexm(lower(`clean_pan_oth_abn_specify'), "`adrenal_terms'")
gen pan_mass = regexm(lower(trim(`clean_pan_oth_abn_specify')), "`mass_terms'")

// Generate a variable to sum number of organs involved

local cat "pan_lung pan_liver pan_gallbladder pan_spleen pan_pancreas pan_kidney pan_uterus_ovary pan_bone_spine pan_vascular pan_heart pan_stomach_intestine pan_adrenal"
egen pan_organs = rowtotal(`cat')

* QC of pancreas in other findings */
/*

tab pan_oth_abnormal pan_organs, missing
br sampa_id pan_oth_abn_specify pan_oth_abnormal pan_organs pan_lung pan_liver pan_gallbladder pan_spleen pan_pancreas pan_kidney pan_uterus_ovary pan_bone_spine pan_vascular pan_heart pan_stomach_intestine pan_adrenal if pan_organs==0 & pan_oth_abnormal==1
*/



**#QC of data (used during regex- keep ) - This requires manual inspection by browsing
/*
* checks mass

local cat "pan_lung pan_liver pan_gallbladder pan_spleen pan_pancreas pan_kidney pan_uterus_ovary pan_bone_spine pan_vascular pan_heart pan_stomach_intestine pan_adrenal"

br pan_oth_abnormal pan_oth_abn_spec pan_organs `cat' if pan_mass==1

* checks liver
local cat "pan_lung pan_liver pan_gallbladder pan_spleen pan_pancreas pan_kidney pan_uterus_ovary pan_bone_spine pan_vascular pan_heart pan_stomach_intestine pan_adrenal pan_mass"

br pan_oth_abnormal pan_oth_abn_spec pan_organs `cat' if pan_liver==1

* checks lung
local cat "pan_lung pan_liver pan_gallbladder pan_spleen pan_pancreas pan_kidney pan_uterus_ovary pan_bone_spine pan_vascular pan_heart pan_stomach_intestine pan_adrenal pan_mass"
br pan_oth_abnormal pan_oth_abn_spec pan_organs `cat' if pan_lung==1

* checks heart
local cat "pan_lung pan_liver pan_gallbladder pan_spleen pan_pancreas pan_kidney pan_uterus_ovary pan_bone_spine pan_vascular pan_heart pan_stomach_intestine pan_adrenal pan_mass"
br pan_oth_abnormal pan_oth_abn_spec pan_organs `cat' if pan_heart==1

* checks uterus
local cat "pan_lung pan_liver pan_gallbladder pan_spleen pan_pancreas pan_kidney pan_uterus_ovary pan_bone_spine pan_vascular pan_heart pan_stomach_intestine pan_adrenal pan_mass"
br pan_oth_abnormal pan_oth_abn_spec pan_organs `cat' if pan_uterus_ovary==1

* checks bone_spine
local cat "pan_lung pan_liver pan_gallbladder pan_spleen pan_pancreas pan_kidney pan_uterus_ovary pan_bone_spine pan_vascular pan_heart pan_stomach_intestine pan_adrenal pan_mass"
br pan_oth_abnormal pan_oth_abn_spec pan_organs `cat' if pan_bone_spine==1

* checks vascular
local cat "pan_lung pan_liver pan_gallbladder pan_spleen pan_pancreas pan_kidney pan_uterus_ovary pan_bone_spine pan_vascular pan_heart pan_stomach_intestine pan_adrenal pan_mass"
br pan_oth_abnormal pan_oth_abn_spec pan_organs `cat' if pan_vascular==1

* checks stomach
local cat "pan_lung pan_liver pan_gallbladder pan_spleen pan_pancreas pan_kidney pan_uterus_ovary pan_bone_spine pan_vascular pan_heart pan_stomach_intestine pan_adrenal pan_mass"
br pan_oth_abnormal pan_oth_abn_spec pan_organs `cat' if pan_stomach_intestine==1

* checks adrenal
local cat "pan_lung pan_liver pan_gallbladder pan_spleen pan_pancreas pan_kidney pan_uterus_ovary pan_bone_spine pan_vascular pan_heart pan_stomach_intestine pan_adrenal pan_mass"
br pan_oth_abnormal pan_oth_abn_spec pan_organs `cat' if pan_adrenal==1
*/

******************** IMPORTANT RECODE of original data
replace pan_oth_abnormal = 0  if  sampa_id ==10381 // comment on IDs only


**# CREATE TABLE USING DTABLE
cd "$ghsamparadio"
cd 03-tables

**#  TABLE CONFIGURATION 
local filter 	"if radio_exam==1"
local title 	"Supplement Table. Incidental Findings on Ultrasound (n=1784)"
local col 		"ever_mal"
local colhead2 `"0 "NPM" 1 "PM""'
local cat "1.pan_organs 1.pan_pancreas 1.pan_lung 1.pan_liver 1.pan_gallbladder 1.pan_spleen  1.pan_stomach_intestine 1.pan_kidney 1.pan_uterus_ovary 1.pan_bone_spine 1.pan_vascular 1.pan_heart  1.pan_adrenal 1.pan_mass"
local notes1 "Participants may have multiple organ findings."
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

**# Collection Dimensions and levels
/*
collect layout
collect dims 
 
 rows: var
 columns : ever_mal#result
 
 * The Text of the table is not aligned because dtable uses composite results
 collect query autolevels result
 collect query composite _dtable_stats

  _dtable_stats is composed offComposite: _dtable_stats
  Elements: frequency
            percent
            fvfrequency
            fvpercent
 */

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

    collect label levels var _N "With Ultrasound", modify
	collect label levels pan_organs 1 "Any Ultrasound Finding", modify
	collect label levels pan_mass 1 "Masses", modify

    collect label levels pan_pancreas 1 "Pancreas"
	collect label levels pan_lung 1 "Lungs", modify
    collect label levels pan_liver 1 "Liver", modify
    collect label levels pan_gallbladder 1 "Gall Bladder", modify
    collect label levels pan_spleen 1 "Spleen", modify
    collect label levels pan_kidney 1 "Kidney", modify
    collect label levels pan_uterus_ovary 1 "Uterus / Ovaries", modify
    collect label levels pan_bone_spine 1 "Bones", modify
    collect label levels pan_vascular 1 "Vascular", modify
    collect label levels pan_heart 1 "Heart", modify
    collect label levels pan_adrenal 1 "Adrenal", modify
    collect label levels pan_stomach_intestine 1 "GI tract", modify


  
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
   * collect style header var[1.pan_lung], title(label) // hides the title or name of levels of the dimension leaving on the level's labels modified above

	local varlevel "1.pan_lung 1.pan_liver 1.pan_gallbladder 1.pan_spleen 1.pan_pancreas 1.pan_kidney 1.pan_uterus_ovary 1.pan_bone_spine 1.pan_vascular 1.pan_heart 1.pan_stomach_intestine 1.pan_adrenal 1.pan_mass 1.pan_organs"
   
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

collect stars pearson .05 "*" .01 "**" .001 "***", dimension 

	* -collect stars- above added a new dimension, attaching -stars[value]-
	* to every existing item, and adding new items for the stars labels
	* tagged with -stars[label]-; but we don't need to see it's label or
	* levels in the header
	
collect style header stars, title(hide) level(hide)

* change the layout to show the stars instead of the p-values


collect layout (var) (ever_mal#result[col1 col2 pearson]#stars) // shows p values and stars


*** Revise text / cell margins
collect style cell, margin(all, width(10)) // approximates default space between text and cell margin 

* collect style cell, margin(all, width(0)) // minimizes default

**** Revise column width (equal or asis)

*collect style column, width(equal)
 collect style column, width(asis)


/* p value options
collect layout (var) (ever_mal#result[col1 col2 pearson]#stars[value]) // shows p values only

collect layout (var) (ever_mal#result[col1 col2 pearson]#stars[value]#stars[label]) // shows p values and stars

collect layout (var) (ever_mal#result[col1 col2 pearson]#stars[value]#stars[label]) // shows p values and stars
*/

**#  SAVE COLLECTION 

collect save pan_organs, replace
**# EXPORT

collect export pan_organs.html, as(html) replace
html2docx pan_organs.html , saving(pan_organs.docx) replace
collect export pan_organs_ms.docx, as(docx) replace
