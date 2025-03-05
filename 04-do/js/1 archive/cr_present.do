*cr_statt_pres.do

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
global stattdataset = "/Users/juansolon/Cox working group Dropbox/TB Nutrition working group/TB_Nutrition/Data_Analysis/St-ATT/Datasets"
global statt = "$github/statt-analysis/"

use `"${sampadata}/All_cohort_tracing.dta"', clear	
keep if cohort == 5

* date 2020 10 12
* date 2023 12 12


* dead upon tracing

* This timepoint is sampa tracing
gen tr_id = _n

gen trace_time = 1

* Cannot be reached or contacted
gen trace_death0 = ustrregexm(lower(tr_reas_other1), "(R|reached)")
gen trace_death0b = ustrregexm(lower(tr_reas_other2), "(R|reached)")
gen trace_death0c = ustrregexm(lower(tr_reas_other3), "(R|reached)")
egen trace0 = rowtotal(trace_death0*)

gen trace_death9 = ustrregexm(lower(tr_reas_other1), "(C|contact)")
gen trace_death9b = ustrregexm(lower(tr_reas_other2), "(C|contact)")
gen trace_death9c = ustrregexm(lower(tr_reas_other3), "(C|contact)")
egen trace9 = rowtotal(trace_death9*)

* no entry on reason not reached
gen trace8 = 0
replace trace8 = 1 if tr_reas_other1=="" & tr_reas_other2=="" & tr_reas_other3 ==""

* reason mentions death in various strings
gen trace_death1 = ustrregexm(lower(tr_reas_other1), "(D|died)")
gen trace_death1b = ustrregexm(lower(tr_reas_other1), "(D|deceased)")
gen trace_death1c = ustrregexm(lower(tr_reas_other1), "(D|dead)")
egen trace1 = rowtotal(trace_death1*)

gen trace_death2 = ustrregexm(lower(tr_reas_other2), "(D|died)")
gen trace_death2b = ustrregexm(lower(tr_reas_other2), "(D|deceased)")
gen trace_death2c = ustrregexm(lower(tr_reas_other2), "(D|dead)")
egen trace2 = rowtotal(trace_death2*)

gen trace_death3 = ustrregexm(lower(tr_reas_other3), "(D|died)")
gen trace_death3b = ustrregexm(lower(tr_reas_other3), "(D|deceased)")
gen trace_death3c = ustrregexm(lower(tr_reas_other3), "(D|dead)")
egen trace3 = rowtotal(trace_death3*)

* this is the death variable
egen trace_death4 = rowtotal(trace1 trace2 trace3)

* no entry on reason, byte
gen trace7 = "1" if tr_reas_other1 == "" & tr_reas_other2 == "" & tr_reas_other3 == ""
destring trace7, replace
replace trace7 = 0 if trace7==.

* tracing outcome variables composite
clonevar trace_sampa = trace_death4 /*(0 unknown 1 death)*/

replace trace_sampa = 2 if trace0==3 | trace9==3 /* cannot be reached no phone*/

replace trace_sampa = 3 if trace7==1 /*no data in reasons */


rename ever_mal ever_mal_trace

* That subject
drop if ever_mal_trace == 9

* trace levels

label define trace_sampa 0 "Unknown" 1 "Died" 2 "No Phone Contact" 3 "No reasons given"
label values trace_sampa trace_sampa

gen region = 6 if tr_id>1 & tr_id <322
replace region = 7 if tr_id >322 & tr_id <651
replace region = 6 if tr_id > 650 | tr_id==1
replace region = 7 if tr_id ==322

table ever_mal region trace_death4

tab trace_sampa
**** fix further will do for now 2 Oct 2024

sort sampa_id

* MERGE WITH SAMPA 

tempfile 1 2 3

save `1'

cd "$statt"
cd prior_cohort_data

use statt_prior_data.dta, clear

rename ever_mal ever_mal_statt

sort sampa_id


merge 1:1 sampa_id using `"${sampadata}/All_crf1_eligibility_consent.dta"'
	drop _merge

	merge 1:1 sampa_id using `"${sampadata}/All_Crf2_demography_and_ses.dta"'
	drop _merge
	
	merge 1:1 sampa_id using `"${sampadata}/All_Crf3_Clinical_History_And_Exam.dta"'
	drop _merge
	
	merge 1:1 sampa_id using `"${sampadata}/All_Crf4a_Blood_Sampling_And_Processing.dta"'
	drop _merge
	
	merge 1:1 sampa_id using `"${sampadata}/All_Crf4b_Repeat_Ogtt.dta"'
	drop _merge
	
	merge 1:1 sampa_id using `"${sampadata}/All_Crf6_Anthropometry.dta"'
	drop _merge
	
	merge 1:1 sampa_id using `1'
	drop _merge

keep if cohort == 5 | cohort ==.

* Generate a variable for in or out of sampa 
clonevar statt_sampa = cohort 
label values statt_sampa
recode statt_sampa 5 = 1 . = 0
label define statt_sampa 1 "In Sampa" 0 "Not in Sampa"
label values statt_sampa statt_sampa

tab statt_sampa trace_sampa
* statt sampa cohort and death

cd "$statt"
save traced.dta , replace



la var trace_death4 "Trace Mortality"
la var ever_mal_statt "Malnourished in St-ATT"
table ever_mal_statt statt_sampa trace_death4

tab ever_mal_statt trace_death4 if ever_mal_statt!=9, col row chi

egen bmi_max =rowmax(bmi_0 - bmi_20)

cd "$stattdataset"

clonevar patient_id = orgid

sort patient_id

save `2'

use "St-ATT_Combined_Dataset.dta", clear

* aug 1 2018 dec 2020 
*
gen patient_id2 = trim(patient_id)
drop patient_id
rename patient_id2 patient_id

drop _merge

save `3'

merge m:1 patient_id using `2'

recode reason -99 = 99

dtable 2.reason i.region if timep==0 ,by(bmi_185)

table region reason bmi_185 if timep==0

tab trace_death4 ever_mal_trace


table region trace_death4 bmi_185 if timep==.
table region reason bmi_185 if timep==0


/*

* Presentation Tables

bysort statt_sampa: sum tr_id

dtable i.trace_sampa if tr_id!=. & timepoint ==., by(trace_death4 )

recode reason -99 = 99
dtable i.region 2.reason if timep==0, by(trace_sampa)
dtable i.region 2.reason if timep==0, by(statt_sampa)



	
* this omitted unknown ever_mal which should not exist.
* checking
/*
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






	

