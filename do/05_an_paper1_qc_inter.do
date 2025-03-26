/* an_radio_qc_inter.do
Based on Dixi's do file using postfile
Revised by Juan to use table collect; formatting
Oct 31 2024

Uses : All_CRF14_Computed_tomography_CT_scans.dta

This do file does the following:
1. Calculate pancreatic volume
2. Renames variables
3. Reshapes to long to run icc
4. Generates new vars 
	reader : for which radiologist read and  
	cat :  for measured dimensions to numeric (1 to 8)
	intra: used for intra-reader variability or not (0 or 1)
5.  Saved Dataset : NONE ; uses tempfile
*/

//# WORKING DIRECTORY AND PATHS ********************************************************************** 
clear

set more off
// Set up the working directory
// Determine if the person running the do-file is in the Dropbox Working Group
// or using an individual one

cd ~
cap confirm file "~/Cox working group Dropbox/"
if _rc == 0 { 
	global dropbox = "~/Cox working group Dropbox/TB Nutrition working group/SAMPA/Data analysis"
}
else global dropbox = "~/Dropbox/Data analysis"

global sampadata = "~/Cox working group Dropbox/TB Nutrition working group/SAMPA/DATA monitoring/Data/SAMPA/"
global githubsampa = "~/Documents/GitHub/sampa-analysis"



cd ~
global dropboxsampa "~/Cox working group Dropbox/TB Nutrition working group/Sampa"
global samparadio "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Analysis/Radiology"
global sampadata "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Management/04-data-delivered-v2/ALL/STATA"
cd ~
cd "$dropboxsampa"
cd "$samparadio"
cd "$sampadata"



//# USE DATA **********************************************************************

*use "../../DATA monitoring/Data/SAMPA/All_CRF14_Computed_tomography_CT_scans.dta"
cd "$sampadata"

use "All_CRF14_Computed_tomography_CT_scans.dta"

cd "$samparadio"


//# CREATE, DERIVE, RENAME VARIABLES BEFORE RESHAPE **********************************************************************

//Pancreatic Volume
//Li, 2021 calculation
//
//PV*

cap drop ct_pan_vol
	gen ct_pan_vol=((ct_pan_tail_trans+ct_pan_body_trans)/2)*ct_pan_body_tail*ct_pan_cc_body+((ct_pan_head_ap/2)^2)*3.14*ct_pan_cc_head
	cap label variable ct_pan_vol "Calculated Pancreatic Volume; Study"

cap drop r2_pan_vol
	gen r2_pan_vol=((r2_pan_tail_trans+r2_pan_body_trans)/2)*r2_pan_body_tail*r2_pan_cc_body+((r2_pan_head_ap/2)^2)*3.14*r2_pan_cc_head
	cap label variable r2_pan_vol "Calculated Pancreatic Volume; Radiologist 2"

cap drop r3_pan_vol
	gen r3_pan_vol=((r3_pan_tail_trans+r3_pan_body_trans)/2)*r3_pan_body_tail*r3_pan_cc_body+((r3_pan_head_ap/2)^2)*3.14*r3_pan_cc_head
	cap label variable r3_pan_vol "Calculated Pancreatic Volume; Radiologist 3"

cap drop r2_pan_vol_intra
	gen r2_pan_vol_intra=((r2_pan_tail_trans_intra+r2_pan_body_trans_intra)/2)*r2_pan_body_tail_intra*r2_pan_cc_body_intra+((r2_pan_head_ap_intra/2)^2)*3.14*r2_pan_cc_head_intra
	cap label variable r2_pan_vol_intra "Calculated Pancreatic Volume Intra; Radiologist 2"

cap drop r3_pan_vol_intra
	gen r3_pan_vol_intra=((r3_pan_tail_trans_intra+r3_pan_body_trans_intra)/2)*r3_pan_body_tail_intra*r3_pan_cc_body_intra+((r3_pan_head_ap_intra/2)^2)*3.14*r3_pan_cc_head_intra
	cap label variable r3_pan_vol_intra "Calculated Pancreatic Volume Intra; Radiologist 3"


* Rename variables for each measurement 
local vars "pan_head_trans pan_head_ap pan_body_trans pan_tail_trans pan_body_tail pan_cc_body pan_cc_head pan_vol" 
	
	foreach var of local vars {
		cap rename `var' `var'_uts
		cap rename ct_`var' `var'_ct
		cap rename r2_`var' `var'_r2
		cap rename r3_`var' `var'_r3
		cap rename r2_`var'_intra `var'_r2_intra
		cap rename r3_`var'_intra `var'_r3_intra
			}

			
** INTER

keep sampa_id pan_*_r2	pan*_ct pan_*_r3 cohort			
			
			

//# RESHAPE **********************************************************************
reshape long pan_, i(sampa_id) j(var) string
rename pan_ read

//# CREATE VARIABLES AFTER RESHAPE **********************************************************************

/* Generates a reader variable (radiologist 2 or 3) */
cap drop reader
	gen reader=.
	recode reader .=2 if index(var, "r2")
	recode reader .=3 if index(var, "r3")
	recode reader .=1 

/* Generates a variable to identify dimension measured */

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


rename var dim_read

** LABEL VARIABLES **
lab var dim_read "Dimension-Reader"
lab var reader "Reader"
lab var read "Measurement"
lab var cat "Dimension"

//drop other cohort, retain only STATT and CLHNS

drop if cohort ==1
drop if read ==.

cd "01 data"

save 0.dta, replace

//# ANALYSIS **********************************************************************

//# Table 1 _ Intra **********************************************************************

* use "SAMPA_long_icc.dta", clear


* SET LOCALS - Modify as needed
*tempfile 0


local cat_vars "1 2 3 4 5 6 7 8" 
local cohortlv "3 4 5 6"

collect clear
set trace on

* CALCULATE ICC INTER

tempfile 0
save `0'.dta, replace

local cat_vars "1 2 3 4 5 6 7 8" 
local cohortlv "3 4 5 6"
foreach var of local cat_vars {
	levelsof cohort, local(cohortlv)
	foreach c of local cohortlv {
				use 0.dta, clear
	collect : table ("`cat'") ("`cohortlv'")
	}
}

//recode original radio s reade==1


foreach var of local cat_vars {
	use `0'.dta, clear
	

	*levelsof cohort, local(cohortlv)
    
	foreach c of local cohortlv {	
		use `0'.dta, clear
		disp "`c'"
		
		local n 2
		forvalues j = 1(1)`n' {
			use `0'.dta, clear
			keep if cat==`var' & cohort==`c' & (reader==1 | reader==`j'+1)
			disp "reader `j'"
			disp "read `var'"
			disp "cohort `c'"
			collect : table (command) (result), ///
				append ///
				command(icc_n = r(N_target) icc = r(icc_i) lci=r(icc_i_lb) uci = r(icc_i_ub) pval = r(icc_i_p) : icc read sampa_id reader, mixed absolute) 
				}
	}
}
			
			
			icc read sampa_id instance, mixed absolute
			local icc = r(icc_i)
			local lci = r(icc_i_lb)
			local uci = r(icc_i_ub)
			local pval = r(icc_i_p)
			local target = r(N_target)
			post `memhold' ("`var'") ("`j'") (`c')  (`icc') (`lci') (`uci') (`pval') (`target')
    }
}
}
postclose `memhold'



foreach var of local cat_vars {
	use  `0'.dta, clear
	levelsof reader, local(readerlv)
		foreach j of local readerlv {
			use  `0'.dta, clear
			keep if reader==`j' & cat==`var'
			collect : table (command) (result), ///
				append ///
				command(icc_n = r(N_target) icc = r(icc_i) lci=r(icc_i_lb) uci = r(icc_i_ub) pval = r(icc_i_p) : icc read sampa_id intra) 
				}
			}


//#  LAYOUT

collect dims
collect levelsof result
collect layout (cmdset) (result[icc_n icc lci uci pval])
collect preview


*Tag the reader
	collect addtags reader["Radiologist 2"], fortags(cmdset[1 3 5 7 9 11 13 15])
		collect addtags reader["Radiologist 3"], fortags(cmdset[2 4 6 8 10 12 14 16])
		
* Tag the pancreatic dimensions
	collect addtags pancreas[a], fortags(cmdset[1 2])
		collect addtags pancreas[b], fortags(cmdset[3 4])
			collect addtags pancreas[c], fortags(cmdset[5 6])
				collect addtags pancreas[d], fortags(cmdset[7 8])
					collect addtags pancreas[e], fortags(cmdset[9 10])
						collect addtags pancreas[f], fortags(cmdset[11 12])
							collect addtags pancreas[g], fortags(cmdset[13 14])
								collect addtags pancreas[h], fortags(cmdset[15 16])					

* Number Formats
	collect style cell result, nformat(%4.3f)

	collect style cell result[icc_n], nformat(%4.0f)

* Composite column for CI

	collect composite define ci = lci uci, delimiter(-) trim

* Layout
/* This creates a table with a supercolumn of radiologists and showing the columns for ICC and CI per row which is the measured dimension)*/

collect layout (pancreas[h a b c d e f g]) (reader#result[icc_n icc ci])

* Rows
collect style header pancreas, title(hide)

collect label levels pancreas 	a "Body-Tail length" b "Body, Transverse" c "Body, Cranio-caudal" d "Head, Cranio-caudal" ///
								e "Head, Anteroposterior" f "Head, Transverse" g "Tail, Transverse" h "Calculated Volume", modify

collect preview
							
* Columns
collect label levels result icc_n "No." , modify
collect label levels result icc "ICC" , modify
collect label levels result ci "95% CI" , modify


* Text
collect title "Supplementary Table 1. Intra-reader variability"
collect notes "To do: fix alignment of columns"
collect notes "To do: possibly add LOAs CIs as 7th and 8th column "
collect notes "Created by `c(username)' on `c(current_date)' at `c(current_time)' based on `c(filename)'"

collect preview

cd "$samparadio"
cd "03-tables"

collect save c_intra

collect export tab_qc_intra.html

collect export tab_qc_intra.html, as(html) replace
	collect export tab1_radio_rev3.docx, as(docx) replace 
	collect export tab1_radio_rev3.xlsx, as(xlsx) replace
	collect export tab1_radio_rev3.pdf, as(pdf) replace
	

	
	
****CALCULATE INTER

collect create c_inter
collect set c_inter

tempfile 0
save `0'.dta, replace
local cat_vars "1 2 3 4 5 6 7 8" 
set trace on
* CALCULATE ICC INTRA
foreach var of local cat_vars {
	use  `0'.dta, clear
	levelsof reader, local(readerlv)
		foreach j of local readerlv {
			use  `0'.dta, clear
			keep if reader==`j' & cat==`var'
			collect : table (command) (result), ///
				append ///
				command(icc_n = r(N_target) icc = r(icc_i) lci=r(icc_i_lb) uci = r(icc_i_ub) pval = r(icc_i_p) : icc read sampa_id intra) 
				}
			}

	
	**** END

	
*** To do: Bland altman - blandlatman; rmloa, baplot, bap, concord

//# *** LOAD DATA FOR BLAND ALTMAN 
 
cd "$sampadata"

use "All_CRF14_Computed_tomography_CT_scans.dta", clear

cd "$githubsampa"

//# CREATE, DERIVE, RENAME VARIABLES BEFORE RESHAPE **********************************************************************

//Pancreatic Volume
//Li, 2021 calculation
//
//PV*

cap drop ct_pan_vol
	gen ct_pan_vol=((ct_pan_tail_trans+ct_pan_body_trans)/2)*ct_pan_body_tail*ct_pan_cc_body+((ct_pan_head_ap/2)^2)*3.14*ct_pan_cc_head
	cap label variable ct_pan_vol "Calculated Pancreatic Volume; Study"

cap drop r2_pan_vol
	gen r2_pan_vol=((r2_pan_tail_trans+r2_pan_body_trans)/2)*r2_pan_body_tail*r2_pan_cc_body+((r2_pan_head_ap/2)^2)*3.14*r2_pan_cc_head
	cap label variable r2_pan_vol "Calculated Pancreatic Volume; Radiologist 2"

cap drop r3_pan_vol
	gen r3_pan_vol=((r3_pan_tail_trans+r3_pan_body_trans)/2)*r3_pan_body_tail*r3_pan_cc_body+((r3_pan_head_ap/2)^2)*3.14*r3_pan_cc_head
	cap label variable r3_pan_vol "Calculated Pancreatic Volume; Radiologist 3"

cap drop r2_pan_vol_intra
	gen r2_pan_vol_intra=((r2_pan_tail_trans_intra+r2_pan_body_trans_intra)/2)*r2_pan_body_tail_intra*r2_pan_cc_body_intra+((r2_pan_head_ap_intra/2)^2)*3.14*r2_pan_cc_head_intra
	cap label variable r2_pan_vol_intra "Calculated Pancreatic Volume Intra; Radiologist 2"

cap drop r3_pan_vol_intra
	gen r3_pan_vol_intra=((r3_pan_tail_trans_intra+r3_pan_body_trans_intra)/2)*r3_pan_body_tail_intra*r3_pan_cc_body_intra+((r3_pan_head_ap_intra/2)^2)*3.14*r3_pan_cc_head_intra
	cap label variable r3_pan_vol_intra "Calculated Pancreatic Volume Intra; Radiologist 3"

keep sampa_id r2_pan_* r3_pan_* cohort


* Rename variables for each measurement 
local vars "pan_head_trans pan_head_ap pan_body_trans pan_tail_trans pan_body_tail pan_cc_body pan_cc_head pan_vol" 
	
	foreach var of local vars {
		cap rename `var' `var'_uts
		cap rename ct_`var' `var'_ct
		cap rename r2_`var' `var'_r2
		cap rename r3_`var' `var'_r3
		cap rename r2_`var'_intra `var'_r2_intra
		cap rename r3_`var'_intra `var'_r3_intra
			}
			
			
			
	
	
/*** Variations
concord
baplot
bap 
rmloa
blandaltman
*/

baplot pan_vol_r2_intra pan_vol_r2
bap pan_vol_r2_intra pan_vol_r2
* error with lab var so relabel
lab var pan_vol_r2 "volr2a" 
lab var pan_vol_r2_intra "volr2b"

bap pan_vol_r2_intra pan_vol_r2

* rmloa
* rmloa yvar xvar [if] [in] [, i(varname) constant level(#) figure[(twoway_options)] - i(varname) specifies non-independnce

rmloa pan_vol_r2_intra pan_vol_r2, i(sampa_id) figure



pan_vol_r2 pan_vol_r2 pan_vol_r3 pan_vol_r2_intra pan_vol_r3_intra
/*	 	 
	collect addtags pancreas[Body to Tail length], fortags(cmdset[1])
	collect addtags pancreas[Body, Transverse], fortags(cmdset[1])
	collect addtags pancreas[Body, Cranio-caudal], fortags(cmdset[1])
	collect addtags pancreas[Head, Cranio-caudal], fortags(cmdset[1])
	collect addtags pancreas[Head, Anteroposterior], fortags(cmdset[1])
	collect addtags pancreas[Head, Transverse], fortags(cmdset[1])
	collect addtags pancreas[Tail, Transverse], fortags(cmdset[1])
	collect addtags pancreas[Calculated Volume], fortags(cmdset[1])
		 
		 
recode cat .=1 if index(var, "body_tail") 
recode cat .=2 if index(var, "body_trans") 
recode cat .=3 if index(var, "cc_body") 
recode cat .=4 if index(var, "cc_head") 
recode cat .=5 if index(var, "head_ap") 
recode cat .=6 if index(var, "head_trans") 
recode cat .=7 if index(var, "tail_trans") 
recode cat .=8 if index(var, "vol") 
*/
	
	use "SAMPA_long_icc.dta", clear
        keep if instance==`j' & cat==`var'
        disp "instance `j'"
        disp "measurement `var'"
        icc read sampa_id intra, mixed absolute
        local icc = r(icc_i)
        local lci = r(icc_i_lb)
        local uci = r(icc_i_ub)
        local pval = r(icc_i_p)
		local target = r(N_target)
        post `memhold' ("`var'") ("`j'") (`icc') (`lci') (`uci') (`pval') (`target')


preserve

keep if instance ==2 & cat==1

	table (command) (result), ///
	command(icc = r(icc_i) lci=r(icc_i_lb) uci = r(icc_i_ub) pval = r(icc_i_p) target = r(N_target) : icc read sampa_id intra) 

restore

 collect addtags extra[Rsquared], fortags(result[r2])

preserve

	keep if instance ==2 & cat==2

	table (command) (result), ///
	command(icc = r(icc_i) lci=r(icc_i_lb)  uci = r(icc_i_ub) pval = r(icc_i_p) : icc read sampa_id intra) 

restore

collect layout (var) (result[icc])
. table (rowname) (colname), command(r(C): pwcorr age bmi weight)

icc read sampa_id intra if instance == 2, mixed absolute
///



local icc = r(icc_i)
        local lci = r(icc_i_lb)
        local uci = r(icc_i_ub)
        local pval = r(icc_i_p)

table (command) (result), ///
		command(`i'=r(mu_2) `group2'=r(mu_1) Difference= (r(mu_2) - r(mu_1)) p_value= r(p) : ttest `var1', by(`bygroup')) ///
		command(`group1'=r(mu_2) `group2'=r(mu_1) Difference= (r(mu_2) - r(mu_1)) p_value= r(p) : ttest `var2', by(`bygroup')) ///
		command(`group1'=r(mu_2) `group2'=r(mu_1) Difference= (r(mu_2) - r(mu_1)) p_value= r(p) : ttest `var3', by(`bygroup')) ///
		command(`group1'=r(mu_2) `group2'=r(mu_1) Difference= (r(mu_2) - r(mu_1)) p_value= r(p) : ttest `var4', by(`bygroup')) ///
		command(`group1'=r(mu_2) `group2'=r(mu_1) Difference= (r(mu_2) - r(mu_1)) p_value= r(p) : ttest `var5', by(`bygroup')) ///
		command(`group1'=r(mu_2) `group2'=r(mu_1) Difference= (r(mu_2) - r(mu_1)) p_value= r(p) : ttest `var6', by(`bygroup')) ///
		command(`group1'=r(mu_2) `group2'=r(mu_1) Difference= (r(mu_2) - r(mu_1)) p_value= r(p) : ttest `var7', by(`bygroup')) ///
		command(`group1'=r(mu_2) `group2'=r(mu_1) Difference= (r(mu_2) - r(mu_1)) p_value= r(p) : ttest `var8', by(`bygroup')) ///
		command(`group1'=r(mu_2) `group2'=r(mu_1) Difference= (r(mu_2) - r(mu_1)) p_value= r(p) : ttest `var9', by(`bygroup')) ///
		nformat(`nformat') ///
		stars(p_value 0.1 "*" 0.05 "**" 0.01 "***", shownote)


local cat_vars "1 2 3 4 5 6 7 8" 

levelsof instance, local(readerlv)

foreach j of local readerlv {
	icc read sampa id_intra, mixed absolute
}
icc read sampa_id intra if var==1, mixed absolute

//All
//Running the icc computation
local cat_vars "1 2 3 4 5 6 7 8" 
tempname memhold
tempfile results

postfile `memhold' str30 var str10 j icc lci uci pval target using "02-data-temp/table1_icc_results_all.dta", replace

//drop other cohort, retain only STATT and CLHNS
drop if cohort < 5

foreach var of local cat_vars {
	use "SAMPA_long_icc.dta", clear
    disp "`var'"
	disp "instance `j'"
    levelsof instance, local(readerlv)
    foreach j of local readerlv {
        use "SAMPA_long_icc.dta", clear
        keep if instance==`j' & cat==`var'
        disp "instance `j'"
        disp "measurement `var'"
        icc read sampa_id intra, mixed absolute
        local icc = r(icc_i)
        local lci = r(icc_i_lb)
        local uci = r(icc_i_ub)
        local pval = r(icc_i_p)
		local target = r(N_target)
        post `memhold' ("`var'") ("`j'") (`icc') (`lci') (`uci') (`pval') (`target')
    }
}
postclose `memhold'




// tidying up the dataset

clear
use "table1_icc_results_all.dta", clear

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

keep var j st pval target

gen cohort=9
tostring target,  force replace

save "data/table1_icc_results_all.dta", replace




//By cohort
//Running the icc computation

use "data/SAMPA_long_icc.dta", clear

local cat_vars "1 2 3 4 5 6 7 8" 
tempname memhold
tempfile results

postfile `memhold' str30 var str10 j c icc lci uci pval target using "data/table1_icc_results_cohort.dta", replace



foreach var of local cat_vars {
	use "data/SAMPA_long_icc.dta", clear
	
	drop if cohort < 5
	
	levelsof cohort, local(cohortlv)
    
	foreach c of local cohortlv {	
		use "data/SAMPA_long_icc.dta", clear
		disp "`c'"
		levelsof instance, local(readerlv)
		
		foreach j of local readerlv {
			use "data/SAMPA_long_icc.dta", clear
			keep if instance==`j' & cat==`var' & cohort==`c'
			disp "instance `j'"
			disp "measurement `var'"
			disp "cohort `c'"
			icc read sampa_id intra, mixed absolute
			local icc = r(icc_i)
			local lci = r(icc_i_lb)
			local uci = r(icc_i_ub)
			local pval = r(icc_i_p)
			local target = r(N_target)
			post `memhold' ("`var'") ("`j'") (`c')  (`icc') (`lci') (`uci') (`pval') (`target')
    }
}
}
postclose `memhold'

// tidying up the dataset
use "data/table1_icc_results_cohort.dta", clear


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

keep var j c st pval target

rename c cohort

save "data/table1_icc_results_cohort.dta", replace


//append datasets

clear
use "data/table1_icc_results_cohort.dta", clear


//Append the total computation 
append using "data/table1_icc_results_all.dta"

rename st stat1
rename pval stat2
rename target stat3


reshape long stat, i(cohort j var) j(read) string
reshape wide stat, i(cohort j read) j(var) string


sort cohort j
order cohort j read statbody_tail statbody_trans statcc_body statcc_head stathead_ap stathead_trans stattail_trans statvol




br cohort j


cap drop tid
egen tid=seq(), by(cohort j)


cap drop tid1
egen tid1=seq(), by(cohort)


tostring cohort, replace
replace cohort = "St-ATT" if cohort == "5"
replace cohort = "CLHNS" if cohort == "6"
replace cohort = "Overall" if cohort == "9"
replace cohort = "" if tid1!=1

replace j = "" if tid !=1


rename j radiologist
drop tid tid1 read

save "data/table1_icc_results_deliv.dta", replace




**# Place into putdocx

//6. Putdocx
cap putdocx clear
putdocx begin, pagesize(A4) landscape
putdocx paragraph, font("Arial", 12)
putdocx text ("Table 1: Intra-class correlation coefficient for Intra rater reliability")

putdocx table out3_uni_gsem=data(cohort radiologist statbody_tail statbody_trans statcc_body statcc_head stathead_ap stathead_trans stattail_trans statvol), halign(center) varnames layout(autofitc) border(all, nil) width(100%) 

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


putdocx save "report/table_1.docx", replace















