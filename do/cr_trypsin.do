/*
cr_trypsin.do 			
merges trypsinogen
J Solon
March 21 2025
*/


tempfile 1 2 3

sort sampa_id

save `1'

***  reads trypsin

frame create trypsin
frame change trypsin

use  "~/Cox working group Dropbox/TB Nutrition working group/SAMPA/DATA monitoring/Data/Copenhagen lab/data/cohort_temporary_trypsinogen.dta"

sort sampa_id

save `2'

frame change sampa

merge 1:1 sampa_id using `2', keepusing(ngml) 

drop if _merge ==2 // _merge ==2 from lab only.  these are individuals with no bmi and dropped from combined.

rename _merge from_trypsin

label variable from_trypsin "With Copenhagen Lab Trypsin Data"

rename ngml_trysinogen ngml_trypsinogen

clonevar trypsinogen_ngml = ngml_trypsinogen

replace ngml_trypsinogen = 44.03 if ngml_trypsinogen ==4403 // outlier verified by copenhagen lab
