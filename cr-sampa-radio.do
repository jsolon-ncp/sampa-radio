clear
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
global dropbox = "~/Cox working group Dropbox/"

cd "$dropbox"
use "SAMPA/DATA monitoring/Data/SAMPA/All_crf13_Abdomen_Uss.dta", clear

* use "All_CRF14_Computed_tomography_CT_scans.dta", clear
* prior malnutrition data
"SAMPA/DATA monitoring/Data/SAMPA/All_crf13_Abdomen_Uss.dta", clear

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



cd $sampamwanza

* Labels
label define cohort 1 "DIVIDS" 2 "SAM" 3" CICADA" 4 "NUSTART" 5 "ST-ATT" 6 "CLHNS"
label values cohort cohort
label var radio "Abdominal Ultrasound Performed"

rename pan_head_trans head_tr
rename pan_head_ap head_ap
rename pan_body_trans body_tr
rename pan_tail_trans tail_tr

la var head_tr "Pancreatic Head, transverse(cm)"
la var head_ap "Pancreatic Head, AP(cm)"
la var body_tr "Pancreatic Body, transverse(cm)"
la var tail_tr "Pancreatic Tail, transverse(cm)"


* Missings
missings report

* Convert Missings
foreach var of varlist head_tr head_ap body_tr tail_tr {
	replace `var' =. if `var'<0
	}
	
* 
br head_tr head_ap body_tr tail_tr agree uss_sample radio_exam

table uss_sample radio_exam cohort
* table

table (radio) (cohort), ///
	statistic(frequency) ///
	statistic(percent) ///
	totals(radio) ///
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
* 1, DIVIDS | 2, SAM Lusaka | 3, CICADA | 4, NUSTART Lusaka | 5, St-ATT | 6, CLHNS


/*
 use "/Users/juansolon/Cox working group Dropbox/SAMPA/DATA monitoring/Data/SAMPA
> /All_CRF14_Computed_tomography_CT_scans.dta"
