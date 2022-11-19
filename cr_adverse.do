*Stata version 17
*CRF3 and 4*

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
use "SAMPA/DATA monitoring/Data/SAMPA/All_Crf4a_Blood_Sampling_And_Processing.dta", clear
merge 1:1 cohort sampa_id using "SAMPA/DATA monitoring/Data/SAMPA/All_Crf4b_Repeat_Ogtt.dta" 
rename _merge merge1
merge 1:1 cohort sampa_id using "SAMPA/DATA monitoring/Data/SAMPA/All_Crf3_Clinical_History_And_Exam.dta" 
rename _merge merge2
merge 1:1 cohort sampa_id using "SAMPA/DATA monitoring/Data/SAMPA/All_Crf3_Clinical_History_And_Exam.dta" 
cd $sampamwanza

* code missings
replace hba1c=. if hba1c<0
replace mmol_glu120 =. if mmol_glu120<0
* code hba1c_cat glu120_cat
egen hba1c_cat = cut(hba1c), at(0 6.5 99) icodes
egen glu120_cat = cut(mmol_glu120), at(0 11.1 99) icodes

save adverse.dta, replace
