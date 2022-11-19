*Stata version 17
*Creates a single dataset for sampa*

clear
set more off

capture log close _all
capture cmdlog close

capture log using "/Users/juansolon/Documents/GitHub/sampa-mwanza/jslog.txt", replace text
capture cmdlog using "/Users/juansolon/Documents/GitHub/sampa-mwanza/jscmd.txt", replace

* Set up directory global macros
global github = "~/Documents/GitHub"
global gshared = "~/Google Drive/Shared drives/"
global gmydrive = "~/Google Drive/My Drive/"
global sampamwanza = "$github/sampa-mwanza/"
global dropbox = "~/Cox working group Dropbox/"

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

cd "$dropbox"

use "SAMPA/DATA monitoring/Data/SAMPA/All_crf1_eligibility_consent.dta", clear
merge 1:1 cohort sampa_id using "SAMPA/DATA monitoring/Data/SAMPA/All_Crf2_demography_and_ses.dta" 
	rename _merge merge1
merge 1:1 cohort sampa_id using "SAMPA/DATA monitoring/Data/SAMPA/All_Crf4a_Blood_Sampling_And_Processing.dta" 
	rename _merge merge2
merge 1:1 cohort sampa_id using "SAMPA/DATA monitoring/Data/SAMPA/All_Crf4a_Blood_Sampling_And_Processing.dta" 
	rename _merge merge3
merge 1:1 cohort sampa_id using "SAMPA/DATA monitoring/Data/SAMPA/All_Crf4b_Repeat_Ogtt.dta" 
	rename _merge merge4
merge 1:1 cohort sampa_id using "SAMPA/DATA monitoring/Data/SAMPA/All_Crf4a_Blood_Sampling_And_Processing.dta" 
	rename _merge merge5
merge 1:1 cohort sampa_id using "SAMPA/DATA monitoring/Data/SAMPA/All_Crf5_More_Blood_Test_Results.dta" 
	rename _merge merge6
merge 1:1 cohort sampa_id using "SAMPA/DATA monitoring/Data/SAMPA/All_Crf6_Anthropometry.dta" 
	rename _merge merge7
merge 1:1 cohort sampa_id using "SAMPA/DATA monitoring/Data/SAMPA/All_Crf7_Body_Composition.dta" 
	rename _merge merge8
merge 1:1 cohort sampa_id using "SAMPA/DATA monitoring/Data/SAMPA/All_Crf10_Referral.dta" 
	rename _merge merge9
merge 1:1 cohort sampa_id using "SAMPA/DATA monitoring/Data/SAMPA/All_Crf11a_Urine_And_Feces_Collection.dta" 
	rename _merge merge10
merge 1:1 cohort sampa_id using "SAMPA/DATA monitoring/Data/SAMPA/All_Crf11b_Urine_And_Feces_Results.dta" 
	rename _merge merge11
*merge 1:1 cohort sampa_id using "SAMPA/DATA monitoring/Data/SAMPA/All_Crf12_Diet.dta" 
	*rename _merge merge12
merge 1:1 cohort sampa_id using "SAMPA/DATA monitoring/Data/SAMPA/All_crf13_Abdomen_Uss.dta"
	rename _merge merge12
	
tempfile 1 2 3

save `1'

*CT Scan CRF has string cohort id
use "SAMPA/DATA monitoring/Data/SAMPA/All_CRF14_Computed_tomography_CT_scans.dta", clear
levelsof cohort
drop if cohort ==""
drop if cohort!="1" & cohort!="2" & cohort!="3" & cohort!="4" & cohort!="5" & cohort!="6"
levelsof cohort
destring cohort, replace
destring sampa_id, replace

save `2'

use `1'

merge 1:1 cohort sampa_id using `2'
	rename _merge merge13

save `3'


cd $sampamwanza
cd 02-data-temp
compress
save sampa-all.dta, replace

cd $sampamwanza

*** LABELS 

label define cohort 1 "DIVIDS" 2 "SAM" 3" CICADA" 4 "NUSTART" 5 "ST-ATT" 6 "CLHNS"
label values cohort cohort

* recode missing in quant vars
replace hba1c=. if hba1c<0
replace mmol_glu120 =. if mmol_glu120<0
* code hba1c_cat glu120_cat
egen hba1c_cat = cut(hba1c), at(0 6.5 99) icodes
egen glu120_cat = cut(mmol_glu120), at(0 11.1 99) icodes

* Hypertension variables
sum sys* dias*
egen sys_cat = cut(systolic), at(0,140,999) icodes
egen dias_cat = cut(diastolic), at(0,90,999) icodes 

save, replace
