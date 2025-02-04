/*
cr-sampa-radio.do
This does the following
- imports CRF13 from the cleaned .dta in Dropbox
- renames and relabels variables 
Juan
2023 Oct 18
*/

clear all
set more off

capture log close _all
capture cmdlog close

capture log using "/Users/juansolon/Documents/GitHub/nsip/NSIP_FF/06-Stata/jslog.txt", replace text
capture cmdlog using "/Users/juansolon/Documents/GitHub/nsip/NSIP_FF/06-Stata/jscmd.txt", replace

* Set up directory global macros
global github = "~/Documents/GitHub"
global gshared = "~/Google Drive/Shared drives/"
global gmydrive = "~/Google Drive/My Drive/"
global sampamwanza = "$github/sampa-mwanza/"
global dropbox = "~/Cox working group Dropbox/TB Nutrition working group"

cd "$dropbox"
use "SAMPA/DATA monitoring/Data/SAMPA/All_crf13_Abdomen_Uss.dta", clear

/* Relabel Variables for Analysis */
label var uss_sample "Ultrasound Subsample"
label var radio_exam "Abdominal Ultrasound Performed"

/* Issue value label for radio_exam misses value 98 as refused */

label define radio_exam2 -103 "Equipment Not Available"
label define radio_exam2 -102 "Absconded", add
label define radio_exam2 -99 "Refused", add
label define radio_exam2 -98 "Refused", add
label define radio_exam2 0 "No", add
label define radio_exam2 1 "Yes", add

label values radio_exam radio_exam2

replace radio_exam = -98 if radio_exam == -99

/* Inspection of Values */
/*stripplot pan_head_trans pan_head_ap pan_body_trans pan_tail_trans
dotplot pan_head_trans 
dotplot pan_head_ap
*/

foreach var of varlist pan_head_trans pan_head_ap pan_body_trans pan_tail_trans {
	list sampa_id cohort pan_head_trans pan_head_ap pan_body_trans pan_tail_trans if `var'>100 & `var'!=.
	}


/* Renames variable to shorter variable names */
rename pan_head_trans head_tr
rename pan_head_ap head_ap
rename pan_body_trans body_tr
rename pan_tail_trans tail_tr

/* Revise labels for brevity */
la var head_tr "Pancreatic Head, transverse(cm)"
la var head_ap "Pancreatic Head, AP (cm)"
la var body_tr "Pancreatic Body, transverse(cm)"
la var tail_tr "Pancreatic Tail, transverse(cm)"

* Inspect plots
/*stripplot head_tr head_ap body_tr tail_tr
vioplot head_tr head_ap body_tr tail_tr
*/

* Missings
missings report


* For analysis : Convert the out of range (>100) value to a negative - raised in github to be changed in source file
foreach var of varlist head_tr head_ap body_tr tail_tr {
	replace `var' = `var'*(-1) if `var'>100 & `var'!=.
	}

* For analysis: can remain in the cleaning / analysis .do file only. Convert Missings if continuous variables from negative value to .
foreach var of varlist head_tr head_ap body_tr tail_tr {
	replace `var' =. if `var'<0
	}



/* Frames - we use frames to store datasets in memory and link them */


frame rename default fr_crf13
frame create fr_crf1
frame change fr_crf1

cd "$dropbox"
use "SAMPA/DATA monitoring/Data/SAMPA/All_crf1_eligibility_consent.dta" 

frame create fr_cohort_tracing
frame change fr_cohort_tracing

cd "$dropbox"
use "SAMPA/DATA monitoring/Data/SAMPA/All_cohort_tracing.dta" 

/* ***one NUSTART participant, orgid=5675, has unknown ever_mal; this person isn;t in NUSTART databases so just drop
*/

/*
fr_cohort_tracing contains all those contacted; fr_crf1 contains all those who agreed and contains other post agreement variables
We need to link both frames 
*/

frlink 1:1 sampa_id, frame(fr_crf1)

frget consent - uss, from(fr_crf1)

recode agree (0 2 4 . =5), gen(agree_binary)

/* Tabulates recruitment into ct and radio samples */

collect create radio1


table (uss_sample) (cohort), ///
	statistic(frequency) ///
	statistic(percent) ///
	totals(uss_sample) ///
	statistic(mean age) ///
	statistic(sd age) ///
	nformat(%9.0fc frequency) ///
	nformat(%6.2f  mean sd) ///
	sformat("%s%%" percent) ///   
	sformat("(%s)" sd) ///
	style(table-1)

collect dims
collect levelsof radio_exam
collect label list radio_exam
collect label list result, all
/*
collect label levels result frequency "Freq."
>                             mean      "Mean (Age)"
>                             percent   "Percent"
>                             sd         "SD (Age)"
>                             , modify
*/

collect label levels result frequency "Freq." ///
	mean ("Mean Age(yrs)") ///
	sd ("SD Age") ///
	percent ("Percent") ///
	, modify

collect preview

collect style putdocx, layout(autofitcontents) ///
         title("Table 1: Descriptive Statistics of Participants with Ultrasound by Cohort") ///
		 note ("Fix labels for frequency, percenage mean age sd age")
		 
collect export samparadio1.docx, as(docx) replace

collect export samparadio1.html, as(html) replace



tab agree_binary ever_mal if cohort >4 & ever_mal!=9, col chi

dtable i.agree i.consent i.assent i.preg_test i.preg_result i.indepth_sample i.ct_sample i.uss_sample, by(cohort) sample(N (%))

gen ctus = 0
replace ctus = 1 if ct_sample==1 & uss_sample ==1
label variable ctus "CT and US Sample"
* 
br head_tr head_ap body_tr tail_tr agree uss_sample radio_exam

table uss_sample radio_exam cohort
* table




/*table (cohort), ///
	statistic(mean age) ///
	statistic(sd age) ///
	nformat(%9.0fc frequency) ///
	nformat(%6.2f  mean sd) ///
	sformat("%s%%" percent) ///   
	sformat("(%s)" sd) ///
	style(table-1) 


collect export MyTable1.docx, as(docx) replace
*/
	
table cohort, stat(mean age) stat(sd age) stat(count agree) stat(count radio) stat(percent agree radio) stat (prop agree radio)

table agree (cohort), statistic(count cohort) 
table radio (cohort), statistic(count cohort) 
collect recode result count = frequency
collect label levels var agree radio cohort "N", modify
collect layout (agree radio) (cohort#result)

webuse nhanes2, clear
table (var) (hlthstat), statistic(count hlthstat) nototals


table female hlthstat, statistic(frequency) statistic(percent, across(hlthstat)) nototals append
table region hlthstat, statistic(frequency) statistic(percent, across(hlthstat)) nototals append
collect recode result count = frequency
collect label levels var hlthstat "N", modify
collect layout (var female region) (hlthstat#result)
noi collect preview


 nformat(#9.0g)

/*
cd $sampamwanza


use "SAMPA/DATA monitoring/Data/prior_cohort_data/CICADA prior malnutrition dataset.dta (Old_cohorts and CICADA)-16th Nov 2022.dta", clear

use "SAMPA/DATA monitoring/Data/prior_cohort_data/DIVIDS_earlier_data_v13.dta", clear

use "SAMPA/DATA monitoring/Data/prior_cohort_data/NUSTART_Lusaka_earlier_data_v13.dta", clear

use "SAMPA/DATA monitoring/Data/prior_cohort_data/SAM_Lusaka_earlier_data.dta", clear

use "SAMPA/DATA monitoring/Data/prior_cohort_data/statt_bmi_prior_data.dta", clear

use "SAMPA/DATA monitoring/Data/prior_cohort_data/clhns_earlierdata_v1.dta", clear
CICADA prior malnutrition dataset.dta (Old_cohorts and CICADA)-16th Nov 2022.dta
DIVIDS_earlier_data_v13.dta
NUSTART_Lusaka_earlier_data_v13.dta
SAM_Lusaka_earlier_data.dta
clhns_earlierdata_v1.dta
do/
original_copies/
statt_bmi_prior_data.dta

*
cd "$dropbox"
use "SAMPA/DATA monitoring/Data/SAMPA/All_Crf10_Referral.dta", clear
use "SAMPA/DATA monitoring/Data/SAMPA/All_Crf3_Clinical_History_And_Exam.dta", clear
use "SAMPA/DATA monitoring/Data/SAMPA/All_crf13_Abdomen_Uss.dta", clear
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


* 1, DIVIDS | 2, SAM Lusaka | 3, CICADA | 4, NUSTART Lusaka | 5, St-ATT | 6, CLHNS


/*
 use "/Users/juansolon/Cox working group Dropbox/SAMPA/DATA monitoring/Data/SAMPA
> /All_CRF14_Computed_tomography_CT_scans.dta"
