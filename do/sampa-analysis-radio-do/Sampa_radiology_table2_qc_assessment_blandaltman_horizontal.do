frame change default

clear



set more off
// Set up the working directory
// Determine if the person running the do-file is in the Dropbox Working Group
// or using an individual one
cap confirm file "~/Cox working group Dropbox/"
if _rc == 0 global dropbox = "~/Cox working group Dropbox/SAMPA/Data analysis"
else global dropbox = "~/Dropbox/Data analysis"



cd "$dropbox/Radiology"


/*load*/

use "../../DATA monitoring/Data/SAMPA/All_CRF14_Computed_tomography_CT_scans.dta"


**# Derived variables: 

//Volume
//Li, 2021 calculation
//
//PV*
cap drop ct_pan_vol
gen ct_pan_vol=((ct_pan_tail_trans+ct_pan_body_trans)/2)*ct_pan_body_tail*ct_pan_cc_body+((ct_pan_head_ap/2)^2)*3.14*ct_pan_cc_head
cap label variable ct_pan_vol "Pancreas Volume by meas"
cap drop r2_pan_vol
gen r2_pan_vol=((r2_pan_tail_trans+r2_pan_body_trans)/2)*r2_pan_body_tail*r2_pan_cc_body+((r2_pan_head_ap/2)^2)*3.14*r2_pan_cc_head
cap label variable r2_pan_vol "Pancreas Volume by meas; Radiologist 2"
cap drop r3_pan_vol
gen r3_pan_vol=((r3_pan_tail_trans+r3_pan_body_trans)/2)*r3_pan_body_tail*r3_pan_cc_body+((r3_pan_head_ap/2)^2)*3.14*r3_pan_cc_head
cap label variable r3_pan_vol "Pancreas Volume by meas; Radiologist 3"


cap drop r2_pan_vol_intra
gen r2_pan_vol_intra=((r2_pan_tail_trans_intra+r2_pan_body_trans_intra)/2)*r2_pan_body_tail_intra*r2_pan_cc_body_intra+((r2_pan_head_ap_intra/2)^2)*3.14*r2_pan_cc_head_intra
cap label variable r2_pan_vol_intra "Intra Pancreas Volume by meas; Radiologist 2"

cap drop r3_pan_vol_intra
gen r3_pan_vol_intra=((r3_pan_tail_trans_intra+r3_pan_body_trans_intra)/2)*r3_pan_body_tail_intra*r3_pan_cc_body_intra+((r3_pan_head_ap_intra/2)^2)*3.14*r3_pan_cc_head_intra
cap label variable r3_pan_vol_intra "Intra Pancreas Volume by meas; Radiologist 3"





keep sampa_id r2_pan_* r3_pan_*  ct_pan_* cohort

local vars "pan_head_trans pan_head_ap pan_body_trans pan_tail_trans pan_body_tail pan_cc_body pan_cc_head pan_vol" 
	
	foreach var of local vars {
cap rename `var' `var'_uts
cap rename ct_`var' `var'_ct
cap rename r2_`var' `var'_r2
cap rename r3_`var' `var'_r3
cap rename r2_`var'_intra `var'_r2_intra
cap rename r3_`var'_intra `var'_r3_intra
	}
	
drop ct_pan_*
	
	
reshape long pan_, i(sampa_id) j(var) string
rename pan_ read


cap drop instance
gen instance=.
recode instance .=2 if index(var, "r2")
recode instance .=3 if index(var, "r3")

replace instance = 1 if instance==.


cap drop cat
gen cat=. 
recode cat .=1 if index(var, "body_tail") 
recode cat .=2 if index(var, "body_trans") 
recode cat .=3 if index(var, "cc_body") 
recode cat .=4 if index(var, "cc_head") 
recode cat .=5 if index(var, "head_ap") 
recode cat .=6 if index(var, "head_trans") 
recode cat .=7 if index(var, "tail_trans") 
recode cat .=8 if index(var, "vol") 


cap drop intra
gen intra=0
recode intra 0=1 if index(var, "_intra") 

drop if read ==.


save "data/SAMPA_long_icc.dta", replace



**# Table 1 _ Inter _ COHORT vs Original

use "data/SAMPA_long_icc.dta", clear

tempname memhold
tempfile results

postfile `memhold'  bias biassd biaslci biasuci c str10 rater str50 my1 str50 my2 using "data/table2_blandaltman_results_cohort.dta", replace


local cat_vars "head_trans head_ap body_trans tail_trans body_tail cc_body cc_head vol" 


foreach var of local cat_vars {
	use "data/SAMPA_long_icc.dta", clear
		
	levelsof instance, local(readerlv)
	
	levelsof cohort, local(cohortlv)
	
	foreach c of local cohortlv {
		
		local n 3
		forvalues rater = 2(1)`n' {
			use "data/SAMPA_long_icc.dta", clear
			
			//drop intra variables
			drop if intra ==1
			
			keep if cohort==`c' & (instance==1 | instance==`rater') &  index(var, "`var'")

			drop instance cat intra

			reshape wide read, i(cohort sampa_id) j(var) string

			ds
			
			local my1 = "`:word 3 of `r(varlist)''"
			local my2 = "`:word 4 of `r(varlist)''"

			blandaltman `:word 3 of `r(varlist)''  `:word 4 of `r(varlist)'' , plot(difference) hloa hbias ciloa cibias 
			

			* Correctly reference macros for the blandaltman command

			local bias = r(mean_d)
			local biassd = r(sd_d)
			local biaslci = r(cibiaslow_d) 
			local biasuci = r(cibiasupp_d)

				* Display the selected variables (optional)
		display "`my1'"
		display "`my2'"
		display "cohort `c'"
		display "rater `rater'"
		display "`bias'"
		display "`biassd'"
		display "`biaslci'"
		display "`biasuci'"	

			post `memhold'  (`bias') (`biassd') (`biaslci') (`biasuci') (`c') ("`rater'")  ("`my1'") ("`my2'")
			
						
			
			ds
			
			* Correctly reference macros for the blandaltman command
			local my1 = "`:word 3 of `r(varlist)''"
			local my2 = "`:word 4 of `r(varlist)''"

			* Display the selected variables (optional)
			display "`my1'"
			display "`my2'"
			
			
			graph export "./figures/table2/bland_difference_`c'_`my1'_`my2'.svg", replace
			graph save "./figures/table2/gph/bland_difference_`c'_`my1'_`my2'.gph", replace
			

			
			
			ds

			blandaltman `:word 3 of `r(varlist)''  `:word 4 of `r(varlist)'' , plot(percentmean) hloa hbias ciloa cibias 
			
			ds
			
			* Correctly reference macros for the blandaltman command
			local my1 = "`:word 3 of `r(varlist)''"
			local my2 = "`:word 4 of `r(varlist)''"

			* Display the selected variables (optional)
			display "`my1'"
			display "`my2'"
			
			
			graph export "./figures/table2/bland_percentmean_`c'_`my1'_`my2'.svg", replace
			graph save "./figures/table2/gph/bland_percentmean_`c'_`my1'_`my2'.gph", replace
			
		}
	}
}

postclose `memhold'



// tidying up the dataset
use "data/table2_blandaltman_results_cohort.dta", clear


// set icc less than zero to 0
//replace icc=0 if icc<0
//replace lci=0 if lci<0
//replace uci=0 if uci<0






cap drop cat
gen cat=. 
recode cat .=1 if index(my2, "body_tail") 
recode cat .=2 if index(my2, "body_trans") 
recode cat .=3 if index(my2, "cc_body") 
recode cat .=4 if index(my2, "cc_head") 
recode cat .=5 if index(my2, "head_ap") 
recode cat .=6 if index(my2, "head_trans") 
recode cat .=7 if index(my2, "tail_trans") 
recode cat .=8 if index(my2, "vol") 




cap drop var
generate var=.
tostring var , replace
replace var = "body_tail" if cat == 1
replace var = "body_trans" if cat == 2
replace var = "cc_body" if cat == 3
replace var = "cc_head" if cat == 4
replace var = "head_ap" if cat == 5
replace var = "head_trans" if cat == 6
replace var = "tail_trans" if cat == 7
replace var = "vol" if cat == 8



tostring bias, format(%9.3f) force replace
tostring biaslci, format(%9.3f) force replace
tostring biasuci, format(%9.3f) force replace


gen beg=" ("
gen join=", "
gen end=")"
gen link="-"
egen biaslimits=concat(bias beg biaslci link biasuci end )

keep rater biaslimits c var


rename c cohort

save "data/table2_blandaltman_results_cohort.dta", replace



// tidying up the dataset
use "data/table2_blandaltman_results_cohort.dta", clear

reshape wide biaslimits, i(cohort rater) j(var) string



sort cohort rater
order cohort rater biaslimitsbody_tail biaslimitsbody_trans biaslimitscc_body biaslimitscc_head biaslimitshead_ap biaslimitshead_trans biaslimitstail_trans biaslimitsvol




br cohort rater


cap drop tid
egen tid=seq(), by(cohort)



tostring cohort, replace
replace cohort = "CICADA" if cohort == "3"
replace cohort = "NUSTART" if cohort == "4"
replace cohort = "St-ATT" if cohort == "5"
replace cohort = "CLHNS" if cohort == "6"

replace cohort = "" if tid!=1



rename rater radiologist
drop tid 

save "data/table2_blandaltman_results_deliv.dta", replace




**# Place into putdocx

//6. Putdocx
cap putdocx clear
putdocx begin, pagesize(A4) landscape
putdocx paragraph, font("Arial", 12)
putdocx text ("Table 2.1: Inter-rater bias estimate: Radio QC vs Cohort Radiologist")

putdocx table out3_uni_gsem=data(cohort radiologist biaslimitsbody_tail biaslimitsbody_trans biaslimitscc_body biaslimitscc_head biaslimitshead_ap biaslimitshead_trans biaslimitstail_trans biaslimitsvol), halign(center) varnames layout(autofitc) border(all, nil) width(100%) 

putdocx table out3_uni_gsem(.,.), font("Arial", 8)






//Try to make repeating headers
//putdocx table out3_uni_gsem = (`rows', `n'), headerrow(2)
//create header row


putdocx table out3_uni_gsem(., 3), halign(center)
putdocx table out3_uni_gsem(., 4), halign(center)
putdocx table out3_uni_gsem(., 5), halign(center)
putdocx table out3_uni_gsem(., 6), halign(center)
putdocx table out3_uni_gsem(., 7), halign(center)
putdocx table out3_uni_gsem(., 8), halign(center)
putdocx table out3_uni_gsem(., 9), halign(center)
putdocx table out3_uni_gsem(., 10), halign(center)

putdocx table out3_uni_gsem(1, 1) = ("Cohort"), halign(center)
putdocx table out3_uni_gsem(1, 2) = ("Radiologist"), halign(center)
putdocx table out3_uni_gsem(1, 3) = ("Body tail"), halign(center)
putdocx table out3_uni_gsem(1, 4) = ("Body trans"), halign(center)
putdocx table out3_uni_gsem(1, 5) = ("CC body"), halign(center)
putdocx table out3_uni_gsem(1, 6) = ("CC head"), halign(center)
putdocx table out3_uni_gsem(1, 7) = ("Head AP"), halign(center)
putdocx table out3_uni_gsem(1, 8) = ("Head trans"), halign(center)
putdocx table out3_uni_gsem(1, 9) = ("Tail trans"), halign(center)
putdocx table out3_uni_gsem(1, 10) = ("Volume"), halign(center)


putdocx save "report/table_2.1.docx", replace







