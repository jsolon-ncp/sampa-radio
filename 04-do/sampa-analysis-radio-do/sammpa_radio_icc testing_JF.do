clear 

use "/Users/jpyferrer/Cox working group Dropbox/TB Nutrition working group/SAMPA/DATA monitoring/Data/SAMPA/All_CRF14_Computed_tomography_CT_scans.dta"

cd "/Users/jpyferrer/Desktop"
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


/*rename columns*/

//rename r2_pan_head_trans read1
//rename r2_pan_head_trans_intra read2

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

preserve 
keep if reader==2 & cat==6
icc read sampa_id intra, mixed absolute
restore

preserve
keep if reader==2 & cat==1
icc read sampa_id intra, mixed absolute

keep if reader==3 & cat==1
icc read sampa_id intra, mixed absolute
restore 

cd "/Users/jpyferrer/Desktop"
save "test/SAMPA_long_icc.dta", replace


**# Table 1 _ Intra

clear
cd "/Users/jpyferrer/Desktop"
use "test/SAMPA_long_icc.dta", clear


//All
//Running the icc computation
local cat_vars "1 2 3 4 5 6 7" 
tempname memhold
tempfile results

postfile `memhold' str30 var str10 j icc lci uci pval using "test/icc_results_all.dta", replace

foreach var of local cat_vars {
    disp "`var'"
    levelsof reader, local(readerlv)
    foreach j of local readerlv {
        use "test/SAMPA_long_icc.dta", clear
        keep if reader==`j' & cat==`var'
        disp "reader `j'"
        disp "measurement `var'"
        icc read sampa_id intra, mixed absolute
        local icc = r(icc_avg)
        local lci = r(icc_avg_lb)
        local uci = r(icc_avg_ub)
        local pval = r(icc_avg_p)
        post `memhold' ("`var'") ("`j'") (`icc') (`lci') (`uci') (`pval')
    }
}
postclose `memhold'

// tidying up the dataset
clear
use "/Users/jpyferrer/Desktop/test/icc_results.dta", clear
tostring var , replace
replace var = "body_tail" if var == "1"
replace var = "body_trans" if var == "2"
replace var = "cc_body" if var == "3"
replace var = "cc_head" if var == "4"
replace var = "head_ap" if var == "5"
replace var = "head_trans" if var == "6"
replace var = "tail_trans" if var == "7"

tostring icc, format(%9.3f) force replace
tostring uci, format(%9.3f) force replace
tostring lci, format(%9.3f) force replace
tostring pval, format(%9.3f) force replace

gen beg=" ("
gen join=", "
gen end=")"
gen link=" - "
egen st=concat(icc beg lci link uci end )

keep var j st pval 

save "test/icc_results.dta", replace


//By cohort
//Running the icc computation

use "test/SAMPA_long_icc.dta", clear

local cat_vars "1 2 3 4 5 6 7" 
tempname memhold
tempfile results

postfile `memhold' str30 var str10 j c icc lci uci pval using "test/icc_results_cohort.dta", replace

drop if cohort < 5
foreach var of local cat_vars {
levelsof cohort, local(cohortlv)
    foreach c of local cohortlv {	
		
		disp "`var'"
		levelsof reader, local(readerlv)
		foreach j of local readerlv {
			use "test/SAMPA_long_icc.dta", clear
			keep if reader==`j' & cat==`var' & cohort==`c'
			disp "reader `j'"
			disp "measurement `var'"
			disp "cohort `c'"
			icc read sampa_id intra, mixed absolute
			local icc = r(icc_avg)
			local lci = r(icc_avg_lb)
			local uci = r(icc_avg_ub)
			local pval = r(icc_avg_p)
			post `memhold' ("`var'") ("`j'") (`c')  (`icc') (`lci') (`uci') (`pval')
    }
}
}
postclose `memhold'
// tidying up the dataset
use "test/icc_results_cohort.dta", clear

tostring var , replace
replace var = "body_tail" if var == "1"
replace var = "body_trans" if var == "2"
replace var = "cc_body" if var == "3"
replace var = "cc_head" if var == "4"
replace var = "head_ap" if var == "5"
replace var = "head_trans" if var == "6"
replace var = "tail_trans" if var == "7"

tostring icc, format(%9.3f) force replace
tostring uci, format(%9.3f) force replace
tostring lci, format(%9.3f) force replace
tostring pval, format(%9.3f) force replace

gen beg=" ("
gen join=", "
gen end=")"
gen link=" - "
egen st=concat(icc beg lci link uci end )

keep var j c st pval

save "test/icc_results_cohort.dta", replace


use "/Users/jpyferrer/Desktop/test/icc_results_cohort.dta", clear

//Append the total computation 
append using "/Users/jpyferrer/Desktop/test/icc_results.dta"
recode c . = 99
reshape wide st pval, i(j c ) j(var) string

sort c j
order c j stbody_tail pvalbody_tail stbody_trans pvalbody_trans  stcc_body pvalcc_body stcc_head pvalcc_head sthead_ap pvalhead_ap sthead_trans pvalhead_trans sttail_trans pvaltail_trans 

br c j
cap drop nvisit
egen nvisit=seq(), by(c)


tostring c, replace
replace c = "St-ATT" if c == "5"
replace c = "CLHNS" if c == "6"
replace c = "Overall" if c == "99"
replace c = "" if nvisit!=1

rename c cohort
rename j radiologist
drop nvisit

save "/Users/jpyferrer/Desktop/test/icc_results_intra_merged.dta", replace


**# Place into putdocx

//6. Putdocx
cap putdocx clear
putdocx begin, pagesize(A4) landscape
putdocx paragraph
putdocx text ("Table 1: Intra-class correlation coefficient")

putdocx table out3_uni_gsem=data(cohort radiologist stbody_tail pvalbody_tail stbody_trans pvalbody_trans stcc_body pvalcc_body stcc_head pvalcc_head sthead_ap pvalhead_ap sthead_trans pvalhead_trans sttail_trans pvaltail_trans), halign(center) varnames layout(autofitc) border(all, nil) width(100%)

//Try to make repeating headers
//putdocx table out3_uni_gsem = (`rows', `n'), headerrow(2)
/*create header row, 
repeat for bmi<17
repeat for hb*/

putdocx table out3_uni_gsem(., 2), halign(center)
putdocx table out3_uni_gsem(., 3), halign(center)
putdocx table out3_uni_gsem(., 4), halign(center)
putdocx table out3_uni_gsem(., 5), halign(center)
putdocx table out3_uni_gsem(., 6), halign(center)
putdocx table out3_uni_gsem(., 7), halign(center)
putdocx table out3_uni_gsem(., 8), halign(center)
putdocx table out3_uni_gsem(., 9), halign(center)
putdocx table out3_uni_gsem(., 10), halign(center)
putdocx table out3_uni_gsem(., 11), halign(center)
putdocx table out3_uni_gsem(., 12), halign(center)
putdocx table out3_uni_gsem(., 13), halign(center)
putdocx table out3_uni_gsem(., 14), halign(center)
putdocx table out3_uni_gsem(., 15), halign(center)
putdocx table out3_uni_gsem(., 16), halign(center)


putdocx table out3_uni_gsem(1, 3) = ("Body tail ICC"), halign(center)
putdocx table out3_uni_gsem(1, 4) = ("p-value"), halign(center)
putdocx table out3_uni_gsem(1, 5) = ("Body trans ICC"), halign(center)
putdocx table out3_uni_gsem(1, 6) = ("p-value"), halign(center)
putdocx table out3_uni_gsem(1, 7) = ("CC body ICC"), halign(center)
putdocx table out3_uni_gsem(1, 8) = ("p-value"), halign(center)
putdocx table out3_uni_gsem(1, 9) = ("CC head ICC"), halign(center)
putdocx table out3_uni_gsem(1, 10) = ("p-value"), halign(center)
putdocx table out3_uni_gsem(1, 11) = ("Head AP ICC"), halign(center)
putdocx table out3_uni_gsem(1, 12) = ("p-value"), halign(center)
putdocx table out3_uni_gsem(1, 13) = ("Head trans ICC"), halign(center)
putdocx table out3_uni_gsem(1, 14) = ("p-value"), halign(center)
putdocx table out3_uni_gsem(1, 15) = ("Tail trans ICC"), halign(center)
putdocx table out3_uni_gsem(1, 16) = ("p-value"), halign(center)


count
local n=r(N)+1
putdocx table out3_uni_gsem(`n', .), border(bottom, single)
putdocx table out3_uni_gsem(1, .), border(bottom, single)

putdocx save "/Users/jpyferrer/Desktop/test/table_1.docx", replace

