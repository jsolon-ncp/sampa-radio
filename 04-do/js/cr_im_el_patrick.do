
/*
* cr_im_el_patrick.do
/Users/juansolon/Documents/GitHub/sampa-radio/04-do/js
This does the following
- imports CRF14 and 13 and 4 from the delivered data .dta in Dropbox
_ reads of the local dropbox drive therefore make sure dropbox is synced
- renames and relabels variables 
Juan
2024 sep 30
*/

clear all
set more off

// Set up the working directory
// Determine if the person running the do-file is in the Dropbox Working Group
// or using an individual one
*cap confirm file "~/Cox working group Dropbox/"
*if _rc == 0 global dropbox = "~/Cox working group Dropbox/SAMPA/Data Monitoring"
* else global dropbox = "~/Dropbox/Data Monitoring"

/* JS Working directories and Global macros*/
capture log close _all
capture cmdlog close

capture log using "/Users/juansolon/Documents/GitHub/sampa/jslog.txt", replace text
capture cmdlog using "/Users/juansolon/Documents/GitHub/sampa/jscmd.txt", replace

* Set up directory global macros
global github = "~/Documents/GitHub"
global gshared = "~/Google Drive/Shared drives/"
global gmydrive = "~/Google Drive/My Drive/"
global samparadio = "$github/sampa-radio/"
global sampatable = "$github/sampa-radio/03-tables/"
global dropbox = "~/Cox working group Dropbox/TB Nutrition working group"


global sampadata = "~/Cox working group Dropbox/TB Nutrition working group/SAMPA/Data Management/04-data-delivered-v2/ALL/STATA"
global sampav1 = "~/Cox working group Dropbox/TB Nutrition working group/SAMPA/Data Management/04-data-delivered-v1/ALL/STATA"

/* This takes you to delivered data */
cd "$sampadata"
cd "$dropbox"
cd "$sampav1"
cd "$samparadio"
cd "$dropboxradio"
/*
use "${sampadata}/All_Crf11b_Urine_And_Feces_Results.dta", clear
use "${sampadata}/All_crf1_eligibility_consent.dta", clear
use "${sampadata}/All_Crf2_demography_and_ses.dta", clear
use "${sampadata}/All_Crf3_Clinical_History_And_Exam.dta", clear
*/
**# CREATE PAPER DATASET

	tempfile 1

* ever_mal in crf11b is not clean

	use Elastasedata_PKmerged.dta, clear
	keep sampa_id lowelastase verylowelastase height weight bmi_cat_child bmi_cat
	sort sampa_id
	save `1'

	use `"${sampadata}/All_CRF14_Computed_tomography_CT_scans.dta"', clear

	merge 1:1 sampa_id using `"${sampadata}/All_crf13_Abdomen_Uss.dta"'
	drop _merge

	*merge 1:1 sampa_id using `"${sampadata}/All_Crf11b_Urine_And_Feces_Results.dta"', keep(feces_collect fecal_elastase feces_problem)
	*drop _merge

	*sort sampa_id
	*cd "$samparadio"


	merge 1:1 sampa_id using `1'
	drop _merge
	
	merge 1:1 sampa_id using `"${sampadata}/All_crf1_eligibility_consent.dta"'
	drop _merge

	merge 1:1 sampa_id using `"${sampadata}/All_Crf2_demography_and_ses.dta"'
	drop _merge
	
	merge 1:1 sampa_id using `"${sampadata}/All_Crf3_Clinical_History_And_Exam.dta"'
	drop _merge
	
	merge 1:1 sampa_id using `"${sampadata}/All_Crf6_Anthropometry.dta"'
	drop _merge
	
	

**# DERIVED VARIABLES
* Generate the correct CT data for PH cohorts
gen ct_pan_vol2 = ct_pan_vol
replace ct_pan_vol2 = r2_pan_vol if ct_pan_vol==.
replace ct_pan_vol2 = r3_pan_vol if ct_pan_vol==.

* Generate ct ratios for volume 
gen ct_ht = ct_pan_vol2/height
gen ct_wt = ct_pan_vol2/weight

* Generate pancreas ratios for head and body
gen pan_head_trans_ht = pan_head_trans/height
gen pan_head_trans_wt = pan_head_trans/weight

gen pan_head_ap_ht = pan_head_ap/height
gen pan_head_ap_wt = pan_head_ap/weight

gen pan_body_trans_ht = pan_body_trans/height
gen pan_body_trans_wt = pan_body_trans/weight


* Generate single pancreas structural abnoralit us and ct?
* ct
local ctabn "ct_pan_shape ct_pan_contour ct_pan_parenchyma ct_pan_paren_inflam ct_pan_paren_fibrosis ct_pan_paren_steatosis ct_pan_duct ct_pan_duct_stones ct_pan_duct_mass ct_pan_calci"

codebook `ctabn'

label define strabn 0 "Normal" 1 "Abnormal"

capture drop strabn_ct

gen byte strabn_ct = 0
replace strabn_ct = 1  if ///
ct_pan_shape == 2 | ct_pan_shape == 3 | ///
ct_pan_contour ==2 | ///
ct_pan_parenchyma ==2 | ///
ct_pan_paren_inflam ==1 | ///
ct_pan_paren_fibrosis ==1 | ///
ct_pan_paren_steatosis ==1 | ///
ct_pan_duct ==2 | ///
ct_pan_duct_mass ==2 | ///
ct_pan_duct_stones==2 | ///
ct_pan_duct_mass ==2 

label values strabn strabn_ct
label var strabn_ct "Structural Abnormalities CT"

*ct_pan_calci ==1 
label var ct_pan_calci "Pancreatic Calcification CT"



* us_strabn
/*
local us "pan_shape pan_contour pan_parenchyma pan_paren_inflam pan_paren_fibrosis pan_paren_steatosis pan_duct pan_duct_stones pan_duct_mass pan_calci"

codebook `us'
pan_shape pan_contour pan_parenchyma pan_paren_inflam pan_paren_fibrosis pan_paren_steatosis pan_duct pan_duct_stones pan_duct_mass pan_calci
*/


capture drop strabn_us

gen byte strabn_us = 0
replace strabn_us = 1 if ///
pan_shape == 2| ///
pan_contour ==2 | ///
pan_parenchyma ==2 | ///
pan_paren_inflam ==1 | ///
pan_paren_fibrosis ==1 | ///
pan_paren_steatosis ==1 | ///
pan_duct ==2 | ///
pan_duct_mass ==2 | ///
pan_duct_stones==2 | ///
pan_duct_mass ==2 

label values strabn strabn_us
label var strabn_us "Structural Abnormalities US"

label var pan_calci "Pancreatic Calcifications US"

tab strabn_us radio_exam, col mis
tab strabn_ct ct_scan, col mis

gen strabn_all = 0
replace strabn_all = 1 if strabn_ct==1 | strabn_us ==1
label var strabn_all "Structural Abnormalities CT/US"

tab strabn_all radio_exam, col row chi
tab strabn_us strabn_ct, col row chi


**# LABEL Variables
la var hiv "HIV"
la var r2_pan_vol "Volume R2"
la var r3_pan_vol "Volume R3"

la var ever_mal "Prior Malnutrition"
	label define pm 0 NPM 1 PM
	label values ever_mal pm

* Recode Diabetes into a single yes level
recode diab 2 = 1
label define dm 0 "No Diabetes" 1 Diabetes
label values diab dm

* Recode bmi_cat_child for underweights

* Recode
recode bmi_cat_child 2 = 4
recode bmi_cat_child 1 = 3
recode bmi_cat_child 0 = 2
recode bmi_cat_child -3 = 1
recode bmi_cat_child -2 = 1
recode bmi_cat_child -1 = 1

label define bmi_cat_child 1 "Underweight" 2 "Normal" 3 "Overweight" 4 "Obese", replace
label values bmi_cat_child bmi_cat_child


**# TABLE 1
*MOVE TO ANALYSIS .DO FILES

tab strabn_all ever_mal

table ()(cohort ever_mal) , ///
statistic(fvfrequency strabn_all) ///
statistic(fvpercent strabn_all) ///
nototals ///
nformat(%5.0f fvpercemt) ///
nformat(%5.1f mean) ///
nformat(%5.2f  sd) 

putdocx begin /* Start of Word Input*/
	putdocx paragraph, style(Heading1)
		putdocx text ("Table 1. Structual abnormalities By Cohort and MN STatus")
	putdocx paragraph, style(Heading1)
		putdocx text ("Data Subset: Imaging") 
	putdocx paragraph
		putdocx text ("stuff ") 
		putdocx text ("stuff stuff ")
		putdocx text ("stuff stuff stuff .")
	collect style putdocx, layout(autofitcontents) ///  use layout(autofitcontents) to retain original width of table */
	title("Table 1. Structual abnormalities By Cohort and MN STatus")
	putdocx collect /*exports our table to the document*/
	putdocx save impe_tab1.docx, replace
	
save tempfile.dta, replace
	