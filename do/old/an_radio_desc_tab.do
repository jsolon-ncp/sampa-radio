* Sampa
* USS

clear

set more off
// Set up the working directory
// Determine if the person running the do-file is in the Dropbox Working Group
// or using an individual one
cap confirm file "~/Cox working group Dropbox/"
if _rc == 0 global dropbox = "~/Cox working group Dropbox/TB Nutrition working group/SAMPA"
else global dropbox = "~/Dropbox/SAMPA"

capture log close
cd "$dropbox/DATA monitoring/Data/SAMPA"


clear
clear frames
set more off
* My logs
capture log close _all
capture cmdlog close
capture log using "/Users/juansolon/Documents/GitHub/sampa-analysis/jslog.txt", replace text
capture cmdlog using "/Users/juansolon/Documents/GitHub/sampa-analysis/jscmd.txt", replace

* Set up directory global macros
global github = "~/Documents/GitHub"
*global gshared = "~/Google Drive/Shared drives/"
*global gmydrive = "~/Google Drive/My Drive/"
global sampaanalysis = "$github/sampa-analysis/"
* global dropboxsampa = "~/Cox working group Dropbox/TB Nutrition working group/SAMPA"


/* local macros for filenames */
local crf0 "All_cohort_tracing.dta"
local crf1 "All_crf1_eligibility_consent.dta"
local crf2 "All_Crf2_demography_and_ses.dta"
local crf3 "All_Crf3_Clinical_History_And_Exam.dta"
local crf4a "All_Crf4a_Blood_Sampling_And_Processing.dta"
local crf4b "All_Crf4b_Repeat_Ogtt.dta"
local crf5 "All_Crf5_More_Blood_Test_Results.dta"
local crf6 "All_Crf6_Anthropometry.dta"
local crf7 "All_Crf7_Body_Composition.dta"
local crf8 "x"
local crf9 "y"
local crf10 "All_Crf10_Referral.dta"
local crf11a "All_Crf11a_Urine_And_Feces_Collection.dta"
local crf11b "All_Crf11b_Urine_And_Feces_Results.dta"
local crf12 "All_Crf12_Diet.dta"
local crf13 "All_crf13_Abdomen_Uss.dta"
local crf14 "All_CRF14_Computed_tomography_CT_scans.dta"
local crfivgtt "All_ivgtt.dta"

/* Merge Datasets */
use `crf0'

	merge 1:1 sampa_id using `crf1'
		drop _merge
	merge 1:1 sampa_id using `crf2'
		drop _merge
	merge 1:1 sampa_id using `crf6'
		drop _merge
	merge 1:1 sampa_id using `crf13'
		drop _merge
	merge 1:1 sampa_id using `crf14'
		drop _merge
		
cd $github
cd sampa-analysis
cd 03-tables

/*The statistic fvfrequency provides the frequency for
each level of a categorical variable, and fvpercent reports the percentage of observations in each
category.
*/
/* Consent */
table (cohort) (agree) , mis ///
	statistic(fvfrequency preg_test) ///
	statistic(fvpercent preg_test) 
collect dims
collect label list result, all

collect recode result fvfrequency = column1 ///
	fvpercent   = column2 
collect label list result, all

collect layout (cohort) (agree#result[column1 column2])

 (highbp#result[column1 column2])

	collect layout (var) (highbp#result[column1 column2])

dtable age i.sex i.agree , by(cohort)

cd 03-tables

dtable age i.sex i.agree i.preg_test i.preg_result , by(cohort) ///
title("Consent, by cohort") ///
export(agree.pdf ,as(pdf) replace)

dtable age i.sex i.agree i.preg_test i.preg_result , by(cohort) ///
title("Consent, by cohort") ///
export(agree.html ,as(html) replace)

dtable age ///
	2.sex 4.preg_test 2.preg_result if agree ==1, by(cohort) ///
	title("Participants, by cohort") ///
	sample(, place(seplabels)) ///
	nformat("%9.1f" mean sd percent rawpercent fvpercent fvrawpercent) ///
	sformat("N=%s" frequency) ///
	export(agree.pdf ,as(pdf) replace)

/* Fix layout and row labels */
collect style header sex preg_test preg_result, level(hide)
collect label levels var sex "Sex: Female", modify
collect label levels var preg_test "Agreed to Pregnancy Test", modify
collect label levels var preg_result "Pregnancy Test Positive", modify
collect preview 

* Add tests for continuous vars */
dtable age ///
	2.sex 4.preg_test 2.preg_result if agree ==1, by(cohort) ///
	title("Participants, by cohort") ///
	sample(, place(seplabels)) ///
	nformat("%9.1f" mean sd percent rawpercent fvpercent fvrawpercent) ///
	sformat("N=%s" frequency) ///
	continuous(age, statistic(regress))
	export(agree.pdf ,as(pdf) replace)



preg_test
dtable agree preg_test, nformat(%9.0g)
	
/* pregnancy */
la var preg_test "Pregnancy Test Consent"
la var preg_result "Pregnancy Test Result"

table (agree) (preg_test) (preg_result), mis


table (agree) (cohort), mis ///
stat(count uss_sample) ///
stat(count uss_problem) 


/* Modifies the variable label only for the table */
collect label levels var agree "Agreed to Participate", modify
collect label levels var uss_sample "Ultrasound subsample", modify
collect label levels var uss_problem "Problem with Ultrasound", modify

collect label levels var agree "Agreed to Participate", modify
	
collect preview


/*

/* Filenames
-rw-r--r--@ 1 juansolon  staff      182 Oct 18  2022 00 READ ME.txt
-rw-r--r--@ 1 juansolon  staff    11829 Jul  7 07:33 01 FILE VERSION HISTORY.docx
-rw-r--r--@ 1 juansolon  staff  1580715 Jul  7 07:43 All_CRF14_Computed_tomography_CT_scans.dta
-rw-r--r--@ 1 juansolon  staff  1096328 Jul  7 07:43 All_Crf10_Referral.dta
-rw-r--r--@ 1 juansolon  staff   531534 Jul  7 07:43 All_Crf11a_Urine_And_Feces_Collection.dta
-rw-r--r--@ 1 juansolon  staff   549458 Jul  7 07:43 All_Crf11b_Urine_And_Feces_Results.dta
-rw-r--r--@ 1 juansolon  staff   588384 Jul  7 07:43 All_Crf12_Diet.dta
-rw-r--r--@ 1 juansolon  staff   922332 Jul  7 07:43 All_Crf2_demography_and_ses.dta
-rw-r--r--@ 1 juansolon  staff  2705959 Jul  7 07:43 All_Crf3_Clinical_History_And_Exam.dta
-rw-r--r--@ 1 juansolon  staff  3971173 Jul  7 07:43 All_Crf4a_Blood_Sampling_And_Processing.dta
-rw-r--r--@ 1 juansolon  staff   563675 Jul  7 07:43 All_Crf4b_Repeat_Ogtt.dta
-rw-r--r--@ 1 juansolon  staff   376858 Jul  7 07:43 All_Crf5_More_Blood_Test_Results.dta
-rw-r--r--@ 1 juansolon  staff   962700 Jul  7 07:43 All_Crf6_Anthropometry.dta
-rw-r--r--@ 1 juansolon  staff   484537 Jul  7 07:43 All_Crf7_Body_Composition.dta
-rw-r--r--@ 1 juansolon  staff  1002018 Jul  7 07:43 All_cohort_tracing.dta
-rw-r--r--@ 1 juansolon  staff  1703744 Jul  7 07:43 All_crf13_Abdomen_Uss.dta
-rw-r--r--@ 1 juansolon  staff   306168 Jul  7 07:43 All_crf1_eligibility_consent.dta
-rw-r--r--@ 1 juansolon  staff  1125555 Jul  7 07:43 All_ivgtt.dta
*/


* Variable labels

label var pan_size_head "Pancreatic Head (cm)"
pan_size_body pan_size_tail pan_head_trans pan_head_ap pan_body_trans pan_tail_trans


local uss_size "pan_head_trans pan_head_trans pan_head_ap pan_body_trans pan_tail_trans"
macro list
dtable `uss_size', by(cohort) ///
export(us_tab1.pdf, as(pdf) replace)

local uss_size "pan_head_trans pan_head_trans pan_head_ap pan_body_trans pan_tail_trans"
macro list
dtable `uss_size', by(cohort) ///
export(us_tab1.docx, as(docx) replace)

dtable pan_size_head pan_size_body pan_size_tail pan_head_trans pan_head_ap pan_body_trans pan_tail_trans, by(cohort)


dtable pan_size_head pan_size_body, by(cohort) export(us_tab1.pdf, as(pdf) replace)
