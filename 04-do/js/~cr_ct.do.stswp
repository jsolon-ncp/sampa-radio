/*
cr-ct.do
/Users/juansolon/Documents/GitHub/sampa-radio/04-do/js
This does the following
- imports CRF14 from the delivered data .dta in Dropbox
_ reads of the local dropbox drive therefore make sure dropbox is synced
- renames and relabels variables 
Juan
2024 sep28
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

use `"${sampadata}/All_crf13_Abdomen_Uss.dta"', clear

* Missings demo 
missings tag cohort - age, gen(mis_demo)

* Missings USS capture

missings tag uss_sample - time_exam_uss, gen(mis_meta)

* Missings USS qual

missings tag pan_size_qual, gen(mis_qual)

* Missings USS quantitative (four variables)
missings tag pan_head_trans pan_head_ap pan_body_trans pan_tail_trans, gen(mis_quant)

* Missings USS radio (3 variables)
missings tag name_radio sig_radio sig_uss_upload, gen(mis_name)

* Missings USS sig (3 variables)
missings tag sig_radio sig_uss_upload, gen(mis_name)

egen mis_sig = rowmiss(sig_radio sig_uss_upload)
tab mis_name name_radio

* Create variable for combine ct data
* At least 1 quant measure
tab uss_sample mis_quant
gen byte uss_any = 0
replace uss_any = 1 if mis_quant <4 & uss_sample==1
la var uss_any "With at least 1 Quantitative Data USS"
tab uss_any uss_sample

* All quant measure
tab uss_sample mis_quant
gen byte uss_all = 0
replace uss_all = 1 if mis_quant ==0
la var uss_all "Complete Quantitative Data USS"
tab uss_all uss_sample


/* Table of Missing Data */
dtable i.mis_meta  i.mis_quant i.mis_qual , by(image_qual_uss)

/* label uss obs */
la var pan_shape "Shape"
la var pan_contour "Contour"
la var pan_parenchyma "Parenchyma"
la var pan_paren_fibrosis "Fibrosis"
la var pan_paren_steatosis "Steatosis"
la var pan_duct "Duct Abnormality"
la var pan_duct_stones "Duct Stones"
la var pan_duct_mass "Duct Stones"

/* Table of USS Observations Parenchyma All data */

dtable i.uss_sample ///
i.pan_shape i.pan_contour i.pan_parenchyma i.pan_paren_fibrosis i.pan_paren_steatosis ///
i.pan_duct i.pan_duct_stones i.pan_duct_mass ///
i.pan_calci ///
i.pan_oth_abnormal ///
, by(cohort, missing) ///
title("Table 3a USS Parenchymal Findings by Cohort; ALL data") ///
export(radiotab3a, as(pdf) replace)

/* Table of USS Observations Parenchyma USS Sample */

preserve 
drop if uss_sample ==0
dtable ///
i.pan_shape i.pan_contour i.pan_parenchyma i.pan_paren_fibrosis i.pan_paren_steatosis ///
i.pan_duct i.pan_duct_stones i.pan_duct_mass ///
i.pan_calci ///
i.pan_oth_abnormal ///
, by(cohort, missing) ///
title(" Table 3b USS Parenchymal Findings by Cohort; USS data") ///
export(radiotab3b, as(pdf) replace)
restore



restore 
gr bar pan_shape

shape
contour 
parenchyma
inflammation
fibrosis
steatosis
duct
duct stones
duct mass
cyst
ohter


pan_shape pan_shape_problem pan_shape_prob_specify 
pan_contour pan_contour_problem pan_contour_prob_specify 
pan_parenchyma 
pan_paren_inflam 
pan_paren_fibrosis 
pan_paren_steatosis 
pan_duct 
pan_duct_stones 
pan_duct_mass 
pan_calci 
pan_calci_place 
pan_cyst_yes 
pan_oth_abnormal 
pan_oth_abn_specify
/* radio details */

/* Other organs */
hepatomegaly splenomegaly cholelithiasis steatosis mass gynecologic atherosclerosis nephrolithiasis pancreatic


/* Relabel Variables for Analysis */
label var uss_sample "Ultrasound Subsample"
label var radio_exam "Abdominal Ultrasound Performed"



table   uss_sample radio_exam cohort, mis

/* Label var prior malnutrition */
* ever_mal is double
recast byte ever_mal
la var ever_mal "Past MN"


* Missings 

* Table 1 using dtable
/*
generate table with 
 sex age prior malnutrition current bmi current muac hiv
*/

cd "$sampatable"
dtable i.sex age i.ever_mal, by(cohort) cont(age, statistics(mean min max)) export(radiotab1, as(pdf) replace) 

* Table 1 using tables


table sex cohort, totals

/* some classifications for both us and ct
hepatomegaly
splenomegaly
cholelithiasis
steatosis
mass
uterine/ovarian
atherosclerosis
nephrolithiasis
pancreatic
other kidney
*/






/*Datasets
All_CRF14_Computed_tomography_CT_scans.dta
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
*/





