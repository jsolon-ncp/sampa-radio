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
cd "$sampav1"


use `"${sampadata}/All_CRF14_Computed_tomography_CT_scans.dta"', clear

merge 1:1 using All_crf13_Abdomen_Uss.dta


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
cd "$sampatable"


* Label Variables
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


* Generate the correct CT data for PH cohorts
gen ct_pan_vol2 = ct_pan_vol
replace ct_pan_vol2 = r2_pan_vol if ct_pan_vol==.
replace ct_pan_vol2 = r3_pan_vol if ct_pan_vol==.

** USE ct_pan_vol2 for all subsequent anaysis

* Abnormalities*

dtable 2.ct_pan_parenchyma 1.ct_pan_head_ap ///
2.ct_pan_body_trans 2.ct_pan_tail_trans 2.ct_pan_body_tail ///
, by(cohort)

ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head ct_pan_shape





preserve 

drop if cohort==1 | cohort==2


gr box pan_head_trans, over(ever_mal) over(cohort)  ///
ti("transhead") ///
subti("by  Malnutrition Status") ///
ytitle("head ^3") 
gr export head_all.png, as(png) replace


gr box pan_head_ap, over(ever_mal)  ///
ti("aphead") ///
subti("by  Malnutrition Status") ///
ytitle("head ^3") 
gr export aphead_all.png, as(png) replace



* Box plot of ct vol by mal and cohort
gr box ct_pan_vol2, over(ever_mal) over(cohort) ///
ti("Pancreatic Volume") ///
subti("by Cohort and Malnutrition Status") ///
ytitle("Pancreatic vol cm^3") 
gr export ctvol.png, as(png) replace


restore


* Pancreas USS


gen pan_head_trans_w = pan_head_trans/weight

* Box plot of ct vol by mal and cohort
gr box pan_head_trans_w, over(ever_mal) over(cohort) ///
ti("Transverse Head diameter by weight USS") ///
subti("by Cohort and Malnutrition Status") ///
ytitle("Transverse Head mm") 
gr export us_tr_headbyweight, as(png) replace


* Box plot of ct vol by mal and cohort
gr box pan_head_trans, over(ever_mal) over(cohort) ///
ti("Transverse Head diameter USS") ///
subti("by Cohort and Malnutrition Status") ///
ytitle("Transverse Head mm") 
gr export us_tr_head, as(png) replace

gr box pan_head_ap, over(ever_mal) over(cohort) ///
ti("AP Head diameter USS") ///
subti("by Cohort and Malnutrition Status") ///
ytitle("AP Head mm") 
gr export us_ap_head, as(png) replace

gr box pan_body_trans, over(ever_mal) over(cohort) ///
ti("Transverse Body diameter USS") ///
subti("by Cohort and Malnutrition Status") ///
ytitle("Transverse Body  mm") 
gr export us_bo_head, as(png) replace

gr box pan_tail_trans, over(ever_mal) over(cohort) ///
ti("Transverse Tail diameter USS") ///
subti("by Cohort and Malnutrition Status") ///
ytitle("Transverse Tail mm") 
gr export us_tr_tail, as(png) replace

la var ct_pan_head_trans "Head Transverse cm CT"
la var pan_head_trans "Head Transverse cm US"

* pan_head_trans pan_head_ap pan_body_trans pan_tail_trans

* AGreement of pan and CT


* Pancreatic Head Trans

blandaltman ct_pan_head_trans pan_head_trans, plot(percentmean) ///
title(Pancreatic Head transverse by USS and CT) ///
ytitle(Percent Mean Difference) ///
xtitle(Mean of CT and US)

gr export 1.png, replace as(png)

* Pancreatic Head AP 

blandaltman ct_pan_head_ap pan_head_ap, plot(percentmean) ///

blandaltman ct_pan_head_ap pan_head_ap, plot(percentmean) ///
title(Pancreatic Head AP by USS and CT) ///
ytitle(Percent Mean Difference) ///
xtitle(Mean of CT and US)

gr export 2.png, replace as(png)

* Pancreatic Body Trans

blandaltman ct_pan_body_trans pan_body_trans, plot(percentmean) ///
title(Pancreatic Body transverse by USS and CT) ///
ytitle(Percent Mean Difference) ///
xtitle(Mean of CT and US)

gr export 3.png, replace as(png)

blandaltman ct_pan_body_trans pan_body_trans, plot(percentmean) ///

blandaltman ct_pan_head_trans pan_head_trans, plot(percentmean)
blandaltman ct_pan_head_trans pan_head_trans, plot(percentmean)

ct_pan_head_trans ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head ct_pan_shape

gr export volume1, as(png) replace
restore

* Scatter  plot of ct vol current bmi

scatter bmi ct_pan_vol2, by(cohort) ///
ytitle("Pancreatic Volume cm^3") ///
xtitle("Current BMI") 


scatter bmi ct_pan_vol2, by(cohort) ///
ti("Pancreatic volume and Current BMI") ///
subti("By cohort") ///
ytitle("Pancreatic Volume cm^3") ///
xtitle("Current BMI") 

* AGreement of pan and cdt
blandaltman 

** Tables
table ever_mal, statistic(mean r2_pan_vol) statistic(mean r3_pan_vol) 

la var r2_pan_vol "Volume R2"
la var r3_pan_vol "Volume R3"

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

/* Missings */
tempvar a b c d e 

local mis1ct "cohort - age"
missings tag `mis1ct', gen(mis1ct)

local mis2ct "ct_scan ct_date ct_time"
missings tag `mis2ct' , gen(mis2ct)

* Missings USS Radiologist signature
missings tag sig_ct sig_ct_upload, gen(mis_ct_sig)

missings table sig_ct sig_ct_upload

* Missings USS name 
missings tag name_ct, gen(mis_name)

* Missing Size Assessment
missings tag ct_pan_size_qual, gen(mis3ct)

* Missing Pancreatic dimensions

dtable i.sex i.ct_scan, by(evermal)

local misc5ct "ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head"
missings tag `mis5ct', gen(mis5ct)


dtable i.mis1ct i.mis2ct i.mis_ct_sig i.mis_name i.mis3ct i.mis5ct, by(ever, nototals tests) 

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

blandaltman ct_pan_vol 



