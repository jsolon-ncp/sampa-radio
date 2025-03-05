
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



keep sampa_id r2_pan_* r3_pan_* cohort

local vars "pan_head_trans pan_head_ap pan_body_trans pan_tail_trans pan_body_tail pan_cc_body pan_cc_head" 
	
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


cap drop reader
gen reader=.
recode reader .=2 if index(var, "r2")
recode reader .=3 if index(var, "r3")



cap drop cat
gen cat=. 
recode cat .=1 if index(var, "body_tail") 
recode cat .=2 if index(var, "body_trans") 
recode cat .=3 if index(var, "cc_body") 
recode cat .=4 if index(var, "cc_head") 
recode cat .=5 if index(var, "head_ap") 
recode cat .=6 if index(var, "head_trans") 
recode cat .=7 if index(var, "tail_trans") 


cap drop intra
gen intra=0
recode intra 0=1 if index(var, "_intra") 


save "data/SAMPA_long_data.dta", replace



**# Table 0 _ Mean

use "data/SAMPA_long_data.dta", clear


//All
//Running the icc computation
local cat_vars "1 2 3 4 5 6 7" 
tempname memhold
tempfile results

postfile `memhold' str30 var str10 j c avg sd obs using "data/table0_mean_results_all.dta", replace





//drop other child cohort, retain only adult
drop if cohort < 3




//remove intra==1 samples
keep if intra==0



foreach var of local cat_vars {
	use "data/SAMPA_long_data.dta", clear
	levelsof cohort, local(cohortlv)
    
	foreach c of local cohortlv {	
		use "data/SAMPA_long_data.dta", clear
		disp "`c'"
		levelsof reader, local(readerlv)
		
		foreach j of local readerlv {
			use "data/SAMPA_long_data.dta", clear
			keep if reader==`j' & cat==`var' & cohort==`c'
			disp "reader `j'"
			disp "measurement `var'"
			disp "cohort `c'"
			summarize read
			local avg = r(mean)
			local sd = r(sd)
			local obs = r(N)
			post `memhold' ("`var'") ("`j'") (`c')  (`avg') (`sd') (`obs')
    }
}
}

postclose `memhold'




exit















//need to update code below










// tidying up the dataset

clear
use "data/table0_mean_results_all.dta", clear

tostring var , replace
replace var = "body_tail" if var == "1"
replace var = "body_trans" if var == "2"
replace var = "cc_body" if var == "3"
replace var = "cc_head" if var == "4"
replace var = "head_ap" if var == "5"
replace var = "head_trans" if var == "6"
replace var = "tail_trans" if var == "7"


rename c cohort
rename j radiologist

drop if avg==.

//create stub

rename avg value1 //mean
rename sd value2 //standard deviation
rename obs value3 //number of observation

reshape long value, i(cohort radiologist var) j(stats)

reshape wide value, i(cohort var stats) j(radiologist) string

rename value2 Radio2
rename value3 Radio3




br cohort var stats


cap drop tid
egen tid=seq(), by(cohort)


cap drop tid1
egen tid1=seq(), by(cohort)


tostring cohort, replace
replace cohort = "CICADA" if cohort == "3"
replace cohort = "NUSTART" if cohort == "4"
replace cohort = "St-ATT" if cohort == "5"
replace cohort = "CLHNS" if cohort == "6"
replace cohort = "" if tid!=1
replace var = "" if stats!=1
replace j = "" if tid !=1


rename j radiologist
drop tid tid1 stats



save "data/table0_mean_results_all.dta", replace










**# Place into putdocx

//6. Putdocx
cap putdocx clear
putdocx begin, pagesize(A4) landscape
putdocx paragraph
putdocx text ("Table 1: Intra-class correlation coefficient for Intra rater reliability")

putdocx table out3_uni_gsem=data(cohort radiologist statbody_tail statbody_trans statcc_body statcc_head stathead_ap stathead_trans stattail_trans), halign(center) varnames layout(autofitc) border(all, nil) width(100%)

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

putdocx table out3_uni_gsem(1, 3) = ("Body tail"), halign(center)
putdocx table out3_uni_gsem(1, 4) = ("Body trans"), halign(center)
putdocx table out3_uni_gsem(1, 5) = ("CC body"), halign(center)
putdocx table out3_uni_gsem(1, 6) = ("CC head"), halign(center)
putdocx table out3_uni_gsem(1, 7) = ("Head AP"), halign(center)
putdocx table out3_uni_gsem(1, 8) = ("Head trans"), halign(center)
putdocx table out3_uni_gsem(1, 9) = ("Tail trans"), halign(center)



putdocx save "report/table_1.docx", replace















