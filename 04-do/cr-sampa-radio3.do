* asdoc

* Table 1. Ultrasound Measurements, by Cohort
asdoc tabstat agree uss_sample radio_exam, by(cohort) ///
stat(N) long format(%1.0f) save(radio1)  

* Table 2. Pancreatic Measurements, by Cohort
bysort cohort: asdoc tabstat head_tr head_ap body_tr tail_tr, stat(N mean sd p50 iqr) long format(%6.2f)

* Table 3
tabulate cohort pan_size_normal, mis row
* Most of the data was missing

tabulate cohort pan_size_qual, row mis
* 352 of 1250 with missing observations

tab cohort pan_shape, row mis
* 365 of 1250 with missing observations
* 9 with abnormal observatiosn (cicada and nustart)
* Cicada specified the problem for 2 - atrophic boyd and tail and a bulky neck.

tab cohort pan_contour, row mis
* 375 of 1250 with missing data
* 11 abnormal (cicada nustart); 1 subject specified in Cicada - margins not clear

tab cohort pan_contour_problem, row mis 
* 8 lobulated, 2 irregular, 1 specified as margins not clear
tab pan_contour_prob_specify

* Parenchyma
tab cohort pan_parenchyma, row mis
tab cohort parenchyma_ab_why, row mis
* 349/1250 28% missing)
* 75 or 6% abnormla (cicada 61, nstart 11, statt 1)
* only 17 of 61 specified why this was abnormal (16 hyperechoic, 1 echogenic)

tab cohort pan_paren_inflam, row mis
tab cohort pan_paren_fibrosis, row mis
* 65 of 1250 replied no, the rest is missing

tab cohort pan_paren_steatosis, row mis
* 68 reported steatosis, 1177 missing, 5 no steatosis

* Ducts
tab cohort pan_duct_normal, row missing
* 99 normal, the rest missing
tab cohort pan_duct_ab, row missing
* all missing
tab cohort pan_duct, row missing
* 5 abnormal, 43 cant see, 361 missing
tab cohort pan_duct_stones, row mis 
* 4 no stones, rest missing
tab cohort pan_duct_mass
*4 no, rest missing

* Peripancreatic vessels

foreach var of varlist pan_peri_normal pan_peri_ab {
	 tab cohort `var', mis row
	 }
* one peripancreatic vessel abnormal, portal vein dilated


* Calcifications

foreach var of varlist pan_calci pan_calci_yes pan_calci_place {
	 tab cohort `var', mis row
	 }
* calcifications present in 4(nustart) (parenchyma)

* Cysts
foreach var of varlist pan_cyst pan_cyst_yes {
	 tab cohort `var', mis row
	 }
tab pan_cyst_yes
* 03 cm x 0.2 cm well defined cyst

* Collection / Free fluid
	 
foreach var of varlist pan_collect pan_collect_yes pan_fluid pan_fluid_yes  {
	 tab cohort `var', mis row
	 }
	* No or missing
	 
* Masses 
	 
foreach var of varlist pan_masses pan_masses_yes {
	 tab cohort `var', mis row
	 }
	* 100 no mass, rest missing
	
* other findings
tab pan_others	 

replace pan_others = "" if strpos(pan_others, "NIL")>0
replace pan_others = "" if strpos(pan_others, "NONE")>0
replace pan_others = "" if strpos(pan_others, "Nil")>0
replace pan_others = "" if strpos(pan_others, "Non")>0
replace pan_others = "" if strpos(pan_others, "None")>0
replace pan_others = "" if strpos(pan_others, "none")>0
replace pan_others = "" if strpos(pan_others, "n/a")>0

tab cohort pan_oth_abnormal
tab pan_oth_abn_specify
	 
	 
	 
	 
	 foreach var of varlist pan_cyst pan_cyst_yes pan_collect pan_collect_yes pan_fluid pan_fluid_yes pan_masses pan_masses_yes pan_others pan_con pan_oth_abnormal pan_oth_abn_specify {
	 tab cohort `var', mis row
	 }




* Table 1. Summary of USS Samples
tabstat agree uss_sample radio_exam, ///
	by(cohort) statistics(n) long format (%1.0f)


* Table 2. Pancreatic Dimensionstabstat
tabstat head_tr head_ap body_tr tail_tr, ///
	by(cohort) statistics(n mean sd p50 iqr) long format (%6.2f) col(stat)

	
	head_tr "Pancreatic Head, transverse(cm)"
la var head_ap "Pancreatic Head, AP(cm)"
la var body_tr "Pancreatic Body, transverse(cm)"
la var tail_tr
	
* Table 3. Observationstabstat

tabstat agree uss_sample head_tr pan_head_ap pan_body_trans pan_tail_trans, ///
	by(cohort) statistics(n mean sd p50 iqr) long format (%6.2f)
	
	