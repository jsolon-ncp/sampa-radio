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








keep sampa_id r2_pan_* r3_pan_* cohort

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


	//drop other cohort, retain only STATT and CLHNS
	drop if cohort < 5

	//remove intra variables
	drop if intra==1
	drop intra
	
	//remove missing records
	drop if read ==.


save "data/SAMPA_long_icc.dta", replace



**# Table 3 _ Inter rater ICC of B and C

use "data/SAMPA_long_icc.dta", clear

//All
//Running the icc computation
local cat_vars "1 2 3 4 5 6 7 8" 
tempname memhold
tempfile results

postfile `memhold' str30 var icc lci uci pval target using "data/table3_icc_bVsC_results_all.dta", replace


foreach var of local cat_vars {
	use "data/SAMPA_long_icc.dta", clear
		
    disp "`var'"
    keep if cat==`var'
    disp "cohort `c'"
	disp "measurement `var'"
	icc read sampa_id instance, mixed absolute
	local icc = r(icc_i)
	local lci = r(icc_i_lb)
	local uci = r(icc_i_ub)
	local pval = r(icc_i_p)
	local target = r(N_target)
	post `memhold' ("`var'") (`icc') (`lci') (`uci') (`pval') (`target')
  
}
postclose `memhold'




// tidying up the dataset

clear
use "data/table3_icc_bVsC_results_all.dta", clear


// set icc less than zero to 0
//replace icc=0 if icc<0
//replace lci=0 if lci<0
//replace uci=0 if uci<0




tostring var , replace
replace var = "body_tail" if var == "1"
replace var = "body_trans" if var == "2"
replace var = "cc_body" if var == "3"
replace var = "cc_head" if var == "4"
replace var = "head_ap" if var == "5"
replace var = "head_trans" if var == "6"
replace var = "tail_trans" if var == "7"
replace var = "vol" if var == "8"

tostring icc, format(%9.3f) force replace
tostring uci, format(%9.3f) force replace
tostring lci, format(%9.3f) force replace
tostring pval, format(%9.3f) force replace
tostring target,  force replace

gen beg=" ("
gen join=", "
gen end=")"
gen link="-"
egen st=concat(icc beg lci link uci end )

keep var st pval target

gen cohort=9
tostring target,  force replace



save "data/table3_icc_bVsC_results_all.dta", replace




//By cohort
//Running the icc computation

use "data/SAMPA_long_icc.dta", clear

local cat_vars "1 2 3 4 5 6 7 8" 
tempname memhold
tempfile results

postfile `memhold' str30 var c icc lci uci pval target using "data/table3_icc_bVsC_results_cohort.dta", replace



foreach var of local cat_vars {
	use "data/SAMPA_long_icc.dta", clear
	
	levelsof cohort, local(cohortlv)
    
	foreach c of local cohortlv {	
		use "data/SAMPA_long_icc.dta", clear
		disp "`c'"
		keep if cat==`var' & cohort==`c'
		disp "measurement `var'"
		disp "cohort `c'"
		icc read sampa_id instance, mixed absolute
		local icc = r(icc_i)
		local lci = r(icc_i_lb)
		local uci = r(icc_i_ub)
		local pval = r(icc_i_p)
		local target = r(N_target)
		post `memhold' ("`var'") (`c')  (`icc') (`lci') (`uci') (`pval') (`target')
    }
}
postclose `memhold'

// tidying up the dataset
use "data/table3_icc_bVsC_results_cohort.dta", clear

// set icc less than zero to 0
//replace icc=0 if icc<0
//replace lci=0 if lci<0
//replace uci=0 if uci<0



tostring var , replace
replace var = "body_tail" if var == "1"
replace var = "body_trans" if var == "2"
replace var = "cc_body" if var == "3"
replace var = "cc_head" if var == "4"
replace var = "head_ap" if var == "5"
replace var = "head_trans" if var == "6"
replace var = "tail_trans" if var == "7"
replace var = "vol" if var == "8"

tostring icc, format(%9.3f) force replace
tostring uci, format(%9.3f) force replace
tostring lci, format(%9.3f) force replace
tostring pval, format(%9.3f) force replace
tostring target,  force replace

gen beg=" ("
gen join=", "
gen end=")"
gen link="-"
egen st=concat(icc beg lci link uci end )

keep var c st pval target

rename c cohort

save "data/table3_icc_bVsC_results_cohort.dta", replace


//append datasets

clear
use "data/table3_icc_bVsC_results_cohort.dta", clear


//Append the total computation 
append using "data/table3_icc_bVsC_results_all.dta"

rename st stat1
rename pval stat2
rename target stat3

tostring stat3, force replace

reshape long stat, i(cohort var) j(read) string
reshape wide stat, i(cohort read) j(var) string


sort cohort
order cohort read statbody_tail statbody_trans statcc_body statcc_head stathead_ap stathead_trans stattail_trans




br cohort 


cap drop tid
egen tid=seq(), by(cohort)



tostring cohort, replace
replace cohort = "St-ATT" if cohort == "5"
replace cohort = "CLHNS" if cohort == "6"
replace cohort = "Overall" if cohort == "9"
replace cohort = "" if tid!=1


drop tid read

save "data/table3_icc_bVsC_results_deliv.dta", replace




**# Place into putdocx

//6. Putdocx
cap putdocx clear
putdocx begin, pagesize(A4) landscape
putdocx paragraph, font("Arial", 12)
putdocx text ("Table 3: Intra-class correlation coefficient for Inter rater reliability of Radio 2 vs 3")

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


putdocx table out3_uni_gsem(1, 2) = ("Body tail"), halign(center)
putdocx table out3_uni_gsem(1, 3) = ("Body trans"), halign(center)
putdocx table out3_uni_gsem(1, 4) = ("CC body"), halign(center)
putdocx table out3_uni_gsem(1, 5) = ("CC head"), halign(center)
putdocx table out3_uni_gsem(1, 6) = ("Head AP"), halign(center)
putdocx table out3_uni_gsem(1, 7) = ("Head trans"), halign(center)
putdocx table out3_uni_gsem(1, 8) = ("Tail trans"), halign(center)
putdocx table out3_uni_gsem(1, 9) = ("Volume"), halign(center)


putdocx save "report/table_3.docx", replace















