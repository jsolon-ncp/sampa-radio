
/*
* cr_im_el.do
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

use "${sampadata}/All_Crf11b_Urine_And_Feces_Results.dta", clear
use "${sampadata}/All_crf1_eligibility_consent.dta", clear
use "${sampadata}/All_Crf2_demography_and_ses.dta", clear
use "${sampadata}/All_Crf3_Clinical_History_And_Exam.dta", clear

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
	
	
* Table 1 using characteristics by ever_mal and cohort using Tables - THIS SHOULD HAVE 13 COLUMNS
	
* supercolumn cohort
* column evermal
* vars age sex diab hiv degree_mal (severe not severe) current bmi 
* current bmi edian iqr
* current bmi categories for adults ; 
* bmi z scores for children
* country. adult


dtable 2.sex age bmi i.bmi_cat_child 1.diab 1.hiv if cohort==1, by(ever_mal) ///
factor(sex bmi_cat_child hiv diab, statistics(fvrawproportion)) ///
nformat(%9.2g)
collect export tab1_1.xls, as(xls) replace

dtable 2.sex age bmi 1.bmi_cat_child i.diab 1.hiv if cohort==2, by(ever_mal) ///
nformat(%9.1g)

collect export tab1_2.xls, as(xls) replace

dtable 2.sex age bmi 1.bmi_cat i.diab 1.hiv if cohort==3, by(ever_mal) ///
nformat(%9.1g)

collect export tab1_3.xls, as(xls) replace

dtable 2.sex age bmi 1.bmi_cat i.diab 1.hiv if cohort==4, by(ever_mal) ///
nformat(%9.1g)

collect export tab1_4.xls, as(xls) replace

dtable 2.sex age bmi 1.bmi_cat i.diab 1.hiv if cohort==5, by(ever_mal) ///
nformat(%9.1g)

collect export tab1_5.xls, as(xls) replace

dtable 2.sex age bmi 1.bmi_cat i.diab 1.hiv if cohort==6, by(ever_mal) ///
nformat(%9.1g)

collect export tab1_6.xls, as(xls) replace


 cont(age bmi, test(none)) title(Coh1) 

dtable r2_pan_vol r3_pan_vol if r2_pan_vol!=. | r3_pan_vol !=., by(cohort) ///
cont(r2_pan_vol r3_pan_vol, test(none)) ///
sample(, statistics(freq)) sformat("(N=%s)" frequency) ///
nformat(%9.1f mean sd) ///
title(Table Comparing Pancreatic Volume Radiologists A B) ///
export(tab1.png, as(html))

table (ever_mal) (cohort) , ///
	statistic(fvfrequency sex) ///
	statistic(fvpercent sex) ///
	statistic(mean age) ///
	statistic(sd age) ///
	statistic(fvfrequency diab) ///
	statistic(fvpercent diab) ///
	statistic(fvfrequency hiv) ///
	statistic(fvpercent hiv) ///
	statistic(fvfrequency degree_mal) ///
	statistic(fvpercent degree_mal) ///
	nototals ///	
nformat(%9.0fc fvfrequency) ///
nformat(%6.2f mean sd) ///
sformat("%s%%" fvpercent) ///
sformat("(%s)" sd)

collect dims
collect recode result fvfrequency = column 1
						fvpercent = column 2
						mean = column 1
						sd = columnn 2


/* This does not work, but is preferred so no relabeling of original vars occurs
collect label dim ever_mal "Prior Malnutrition"
collect label list ever_mal
collect label levels ever_mal 0 "NPM" 1 "PM"

*/


/* 

only using dtable - limited inthat you can't hae nested columns wiht dtable (v 18 only)

dtable 1.sex age, ///
cont(age) ///
by(ever_mal) 



dtable 1.ct_pan_parenchyma 1.ct_pan_head_ap ///
2.ct_pan_body_trans 2.ct_pan_tail_trans 2.ct_pan_body_tail ///
, by(ever_mal)
dtable e


dtable  2.sex i.rec_diab 1.ever_mal ///
age ///
1.hiv , by(cohort) 

r2_pan_vol r3_pan_vol if r2_pan_vol!=. | r3_pan_vol !=., by(cohort) ///
cont(r2_pan_vol r3_pan_vol, test(none)) ///
sample(, statistics(freq)) sformat("(N=%s)" frequency) ///
nformat(%9.1f mean sd) ///
title(Table Comparing Pancreatic Volume Radiologists A B) ///
export(tab1.png, as(html))


table ever_mal, statistic(mean r2_pan_vol) statistic(mean r3_pan_vol) 


i.variable 1.sex 2.sex

dtable r2_pan_vol r3_pan_vol if r2_pan_vol!=. | r3_pan_vol !=., by(cohort) ///
cont(r2_pan_vol r3_pan_vol, test(none)) ///
sample(, statistics(freq)) sformat("(N=%s)" frequency) ///
nformat(%9.1f mean sd) ///
title(Table Comparing Pancreatic Volume Radiologists A B) ///
export(tab1.png, as(html))

dtable r2_pan_vol r3_pan_vol i.cohort, by(ever_mal) ///
cont(r2_pan_vol r3_pan_vol, test(notest)) ///
nformat(%9.2f mean sd) ///
title(Table Comparing Pancreatic Volume Radiologists A B) ///
note(Pancreatic Volume by)




. dtable age weight bpsystol i.sex i.race, by(diabetes, nototals tests)
continuous(age, test(none)) factor(race, test(none))
sample(, statistics(freq) place(seplabels)) sformat("(N=%s)" frequency)
note(Total sample: N = 10,349) column(by(hide))
nformat(%7.2f mean sd) title(Table 1. Demographics) export(table1.html, replace)
note: using test regress across levels of diabetes for weight and bpsystol.
note: using test pearson across levels of diabetes for sex.

crf 1


bmi 
diabetes
age 
sex
hiv 


merge 1:1 sampa_id using "Elastasedata_PKmerged.dta", keepusing( lowelastase verylowelastase elastaseresult)


ll_CRF14_Computed_tomography_CT_scans.dta
All_Crf10_Referral.dta
All_Crf11a_Urine_And_Feces_Collection.dta
All_Crf11b_Urine_And_Feces_Results.dta
All_Crf12_Diet.dta
All_Crf2_demography_and_ses.dta
All_Crf3_Clinical_History_And_Exam.dta
All_Crf4a_Blood_Sampling_And_Processing.dta
All_Crf4b_Repeat_Ogtt.dta
All_Crf5_More_Blood_Test_Results.dta
All_Crf6_Anthropometry.dta
All_Crf7_Body_Composition.dta
All_crf13_Abdomen_Uss.dta
All_crf1_eligibility_consent.dta


