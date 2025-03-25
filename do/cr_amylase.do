/*
cr_amylase.do 			
merges amylase crp cystatin
J Solon
March 21 2025
*/

tempfile 1 2 3

sort sampa_id

save `1'

***  reads trypsin

frame create amylase
frame change amylase

use  "~/Cox working group Dropbox/TB Nutrition working group/SAMPA/DATA monitoring/Data/Copenhagen lab/data/cohort_temporary_crp_etc.dta", clear

sort sampa_id

save `2'

frame change sampa

merge 1:1 sampa_id using `2', keepusing(ul_amylp mgl_crp mgl_cystatin) 

drop if from_t ==2 // _merge ==2 from lab only.  these are individuals with no bmi and dropped from combined.

clonevar amylase_ul = ul_amylp 

rename _merge from_amylase

label variable from_amylase "With Copenhagen Lab Amylase CRP Cystatin Data"
