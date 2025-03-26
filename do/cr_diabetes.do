/* 
cr_diabetes.do
Creates derived variables for diabetes 
from hba1c and glucose 120 as reported in the primary paper
*/
*===== HbA1c =====

*HbA1c categories for diabetes
recode hba1c (0/5.6=0) (5.7/6.4=1) (6.5/15=2), gen (hba1c_cat)
label define hba1c_cat 0 "Normal" 1 "Prediabetes" 2 "Diabetes"
label values hba1c_cat hba1c_cat

*===== Glucose 120 min =====

* Glucose 120 min categories for diabetes
recode mmol_glu120 (0/7.79=0) (7.8/11.09=1) (11.1/40.0=2), gen (glu120_cat)
label define glu120_cat 0 "Normal" 1 "Prediabetes" 2 "Diabetes"
label values glu120_cat glu120_cat

*===== Union =====

* Either Hba1c or glu_120 categories for diabetes
gen diab_hb_gl120 = 2 if glu120_cat ==2 | hba1c_cat ==2
replace diab_hb_gl120 = 1 if glu120_cat ==1 & hba1c_cat ==1
replace diab_hb_gl120 = 0 if glu120_cat ==0 & hba1c_cat ==0

label define diab_hb_gl120  0 "Normal" 1 "Prediabetes" 2 "Diabetes"
label values diab_hb_gl120 diab_hb_gl120


/*
**# Checking for repeat OGTT
preserve
clear

set more off
// Set up the working directory
// Determine if the person running the do-file is in the Dropbox Working Group
// or using an individual one
cap confirm file "~/Cox working group Dropbox/"
if _rc == 0 global dropbox = "~/Cox working group Dropbox/TB Nutrition working group/SAMPA/Data Monitoring"
else global dropbox = "~/Dropbox/Data Monitoring/"

cd "$dropbox/data"

clear
use "./SAMPA/All_combined_sampa_data.dta"

*===== HbA1c =====
*HbA1c categories for diabetes
recode hba1c (0/5.6=0) (5.7/6.4=1) (6.5/15=2), gen (hba1c_cat)
label define hba1c_cat 0 "Normal" 1 "Prediabetes" 2 "Diabetes"
label values hba1c_cat hba1c_cat

*===== Glucose 120 min =====
* Glucose 120 min categories for diabetes
recode mmol_glu120 (0/7.79=0) (7.8/11.09=1) (11.1/40.0=2), gen (glu120_cat)
label define glu120_cat 0 "Normal" 1 "Prediabetes" 2 "Diabetes"
label values glu120_cat glu120_cat

*===== Union =====
* Either Hba1c or glu_120 categories for diabetes
gen diab_hb_gl120 = 2 if glu120_cat ==2 | hba1c_cat ==2
replace diab_hb_gl120 = 1 if glu120_cat ==1 & hba1c_cat ==1
replace diab_hb_gl120 = 0 if glu120_cat ==0 & hba1c_cat ==0

label define diab_hb_gl120  0 "Normal" 1 "Prediabetes" 2 "Diabetes"
label values diab_hb_gl120 diab_hb_gl120

label define ogttr_confirm  0 "No" 1 "Yes" 
label values ogttr_confirm ogttr_confirm

// 4a vs 4b
tab repeat_test_needed ogttr_confirm, m row col
bysort cohort: tab repeat_test_needed ogttr_confirm, m row col

// 4a needs repeat ogtt vs repeat ogtt form 
tab ogttr_confirm if repeat_test_needed==1, m 
bysort cohort: tab ogttr_confirm if repeat_test_needed==1, m 

// Repeat test needed vs diab def 
tab repeat_test_needed diab_hb_gl120 , m row col
bysort cohort: tab repeat_test_needed diab_hb_gl120 , m row col

// Repeat test done vs diab def 
table (cohort ogttr_confirm) (diab_hb_gl120) ,m nototals
bysort cohort: tab ogttr_confirm diab_hb_gl120 , m row col

// Repeat test done vs diab def 
bysort cohort: tab repeat_test_needed ogttr_confirm if diab_hb_gl120==2, m row col

// defined as diabetic but did not do a repeat OGTT
br cohort sampa_id orgid diab rec_diab hba1c glu0 mmol_glu0 repeat_test_needed if diab_hb_gl120==2 & repeat_test_needed==0 

// defined as diabetic but did not do a repeat OGTT
br cohort sampa_id orgid diab rec_diab hba1c glu0 mmol_glu0 repeat_test_needed if diab_hb_gl120==2 & repeat_test_needed==1
tab rec_diab diab if diab_hb_gl120==2 & repeat_test_needed==1 & ogttr_confirm==., m


restore



