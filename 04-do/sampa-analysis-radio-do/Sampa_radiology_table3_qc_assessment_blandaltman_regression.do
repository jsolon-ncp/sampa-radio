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


keep sampa_id r2_pan_* r3_pan_*  cohort

local vars "pan_head_trans pan_head_ap pan_body_trans pan_tail_trans pan_body_tail pan_cc_body pan_cc_head pan_vol" 
	
	foreach var of local vars {
cap rename `var' `var'_uts
cap rename ct_`var' `var'_ct
cap rename r2_`var' `var'_r2
cap rename r3_`var' `var'_r3
cap rename r2_`var'_intra `var'_r2_intra
cap rename r3_`var'_intra `var'_r3_intra
	}
	

	
	
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



**# Table 3 _ Inter _ B vs C _All

frame change default

use "data/SAMPA_long_icc.dta", clear

tempfile results



local cat_vars "head_trans head_ap body_trans tail_trans body_tail cc_body cc_head vol" 
local replace replace

foreach var of local cat_vars {
	use "data/SAMPA_long_icc.dta", clear
		
	levelsof instance, local(readerlv)

			
	//retain only STATT and CLHNS
	drop if cohort < 5	
	
		
			//drop intra variables
			drop if intra ==1
			
			keep if index(var, "`var'")


			drop instance cat intra

			reshape wide read, i(cohort sampa_id) j(var) string


		ds
		
		local my1 = "`:word 3 of `r(varlist)''"
		local my2 = "`:word 4 of `r(varlist)''"

		blandaltman `:word 3 of `r(varlist)''  `:word 4 of `r(varlist)'' , plot(difference) hloa hbias ciloa cibias
		

		ds
			
			generate diff = `:word 3 of `r(varlist)'' - `:word 4 of `r(varlist)''
			generate meanvar = (`:word 3 of `r(varlist)'' + `:word 4 of `r(varlist)'') / 2
						
			regress diff meanvar	
			
			regsave using "`results'", ci pval autoid `replace' addlabel(cohort,"`c'",reader,"`rater'",dimension,"`var'")

			local replace append
			
		
}

use "`results'", clear

destring cohort, replace
replace cohort=9


save "data/table3_blandaltman_results_cohort_reg_all.dta", replace














**# Table 3 _ Inter _ B vs C _Cohort

use "data/SAMPA_long_icc.dta", clear


tempfile results




local cat_vars "head_trans head_ap body_trans tail_trans body_tail cc_body cc_head vol" 
local replace replace


foreach var of local cat_vars {
	use "data/SAMPA_long_icc.dta", clear
		
	levelsof instance, local(readerlv)

			
	//retain only STATT and CLHNS
	drop if cohort < 5	
	
	
	levelsof cohort, local(cohortlv)

	
	
	foreach c of local cohortlv {
		
			use "data/SAMPA_long_icc.dta", clear
			
			//drop intra variables
			drop if intra ==1
			
			keep if cohort==`c' &  index(var, "`var'")

			drop instance cat intra

			reshape wide read, i(cohort sampa_id) j(var) string

			ds
			
			local my1 = "`:word 3 of `r(varlist)''"
			local my2 = "`:word 4 of `r(varlist)''"

			blandaltman `:word 3 of `r(varlist)''  `:word 4 of `r(varlist)'' , plot(difference) hloa hbias ciloa cibias
			

			ds
			
			generate diff = `:word 3 of `r(varlist)'' - `:word 4 of `r(varlist)''
			generate meanvar = (`:word 3 of `r(varlist)'' + `:word 4 of `r(varlist)'') / 2
						
			regress diff meanvar	
			
			regsave using "`results'", ci pval autoid `replace' addlabel(cohort,"`c'",reader,"`rater'",dimension,"`var'")

			local replace append
			
			

			
		}
}



use "`results'", clear
save "data/table3_blandaltman_results_cohort_reg_cohort.dta", replace






// tidying up the dataset
use "data/table3_blandaltman_results_cohort_reg_cohort.dta", clear

//Append the total computation 
append using "data/table3_blandaltman_results_cohort_reg_all.dta"


cap drop cat
gen cat=. 
recode cat .=1 if index(dimension, "body_tail") 
recode cat .=2 if index(dimension, "body_trans") 
recode cat .=3 if index(dimension, "cc_body") 
recode cat .=4 if index(dimension, "cc_head") 
recode cat .=5 if index(dimension, "head_ap") 
recode cat .=6 if index(dimension, "head_trans") 
recode cat .=7 if index(dimension, "tail_trans") 
recode cat .=8 if index(dimension, "vol") 



tostring coef, format(%9.3f) force replace
tostring ci_lower, format(%9.3f) force replace
tostring ci_upper, format(%9.3f) force replace
tostring pval, format(%9.3f) force replace
tostring reader,  force replace





gen beg=" ("
gen join=", "
gen end=")"
gen link="-"
egen biaslimits=concat(coef beg ci_lower link ci_upper end )

keep  biaslimits pval cohort var dimension




//change frame to beta1
cap frame drop beta1

frame copy default beta1

frame change beta1

keep if var=="meanvar"

drop var

rename biaslimits stat1
rename pval stat2



reshape long stat , i(cohort dimension) j(value) string
reshape wide stat, i(cohort value) j(dimension) string


sort cohort value
order cohort value  statbody_tail statbody_trans statcc_body statcc_head stathead_ap stathead_trans stattail_trans statvol




br cohort

cap drop tid
egen tid=seq(), by(cohort)



tostring cohort, replace
replace cohort = "St-ATT" if cohort == "5"
replace cohort = "CLHNS" if cohort == "6"
replace cohort = "Overall" if cohort == "9"



replace cohort = "" if tid!=1


drop tid
drop value





save "data/table3_blandaltman_results_cohort_reg_cohort_beta1.dta", replace




**# Place into putdocx

//6. Putdocx
cap putdocx clear
putdocx begin, pagesize(A4) landscape
putdocx paragraph, font("Arial", 12)
putdocx text ("Table 3.2: Inter-rater bias estimate (regression): Radio 2 vs Radio 3")

putdocx table out3_uni_gsem=data(cohort statbody_tail statbody_trans statcc_body statcc_head stathead_ap stathead_trans stattail_trans statvol), halign(center) varnames layout(autofitc) border(all, nil) width(100%) 

putdocx table out3_uni_gsem(.,.), font("Arial", 8)






//Try to make repeating headers
//putdocx table out3_uni_gsem = (`rows', `n'), headerrow(2)
//create header row

putdocx table out3_uni_gsem(., 2), halign(center)
putdocx table out3_uni_gsem(., 3), halign(center)
putdocx table out3_uni_gsem(., 4), halign(center)
putdocx table out3_uni_gsem(., 5), halign(center)
putdocx table out3_uni_gsem(., 6), halign(center)
putdocx table out3_uni_gsem(., 7), halign(center)
putdocx table out3_uni_gsem(., 8), halign(center)
putdocx table out3_uni_gsem(., 9), halign(center)


putdocx table out3_uni_gsem(1, 1) = ("Cohort"), halign(center)
putdocx table out3_uni_gsem(1, 2) = ("Body tail"), halign(center)
putdocx table out3_uni_gsem(1, 3) = ("Body trans"), halign(center)
putdocx table out3_uni_gsem(1, 4) = ("CC body"), halign(center)
putdocx table out3_uni_gsem(1, 5) = ("CC head"), halign(center)
putdocx table out3_uni_gsem(1, 6) = ("Head AP"), halign(center)
putdocx table out3_uni_gsem(1, 7) = ("Head trans"), halign(center)
putdocx table out3_uni_gsem(1, 8) = ("Tail trans"), halign(center)
putdocx table out3_uni_gsem(1, 9) = ("Volume"), halign(center)


putdocx save "report/table_3.2.docx", replace





//change frame to beta0
cap frame drop beta0

frame copy default beta0

frame change beta0

keep if var=="_cons"

drop var

rename biaslimits stat1
rename pval stat2



reshape long stat , i(cohort dimension) j(value) string
reshape wide stat, i(cohort value) j(dimension) string


sort cohort value
order cohort value  statbody_tail statbody_trans statcc_body statcc_head stathead_ap stathead_trans stattail_trans statvol




br cohort

cap drop tid
egen tid=seq(), by(cohort)



tostring cohort, replace
replace cohort = "St-ATT" if cohort == "5"
replace cohort = "CLHNS" if cohort == "6"
replace cohort = "Overall" if cohort == "9"



replace cohort = "" if tid!=1


drop tid
drop value





save "data/table3_blandaltman_results_cohort_reg_cohort_beta0.dta", replace




**# Place into putdocx

//6. Putdocx
cap putdocx clear
putdocx begin, pagesize(A4) landscape
putdocx paragraph, font("Arial", 12)
putdocx text ("Table 3.3: Inter-rater regression intercept estimate: Radio 2 vs Radio 3")

putdocx table out3_uni_gsem=data(cohort statbody_tail statbody_trans statcc_body statcc_head stathead_ap stathead_trans stattail_trans statvol), halign(center) varnames layout(autofitc) border(all, nil) width(100%) 

putdocx table out3_uni_gsem(.,.), font("Arial", 8)






//Try to make repeating headers
//putdocx table out3_uni_gsem = (`rows', `n'), headerrow(2)
//create header row

putdocx table out3_uni_gsem(., 2), halign(center)
putdocx table out3_uni_gsem(., 3), halign(center)
putdocx table out3_uni_gsem(., 4), halign(center)
putdocx table out3_uni_gsem(., 5), halign(center)
putdocx table out3_uni_gsem(., 6), halign(center)
putdocx table out3_uni_gsem(., 7), halign(center)
putdocx table out3_uni_gsem(., 8), halign(center)
putdocx table out3_uni_gsem(., 9), halign(center)


putdocx table out3_uni_gsem(1, 1) = ("Cohort"), halign(center)
putdocx table out3_uni_gsem(1, 2) = ("Body tail"), halign(center)
putdocx table out3_uni_gsem(1, 3) = ("Body trans"), halign(center)
putdocx table out3_uni_gsem(1, 4) = ("CC body"), halign(center)
putdocx table out3_uni_gsem(1, 5) = ("CC head"), halign(center)
putdocx table out3_uni_gsem(1, 6) = ("Head AP"), halign(center)
putdocx table out3_uni_gsem(1, 7) = ("Head trans"), halign(center)
putdocx table out3_uni_gsem(1, 8) = ("Tail trans"), halign(center)
putdocx table out3_uni_gsem(1, 9) = ("Volume"), halign(center)


putdocx save "report/table_3.3.docx", replace


