/* cr_radio_qc_intra_icc.do
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

*global sampadata = "~/Cox working group Dropbox/TB Nutrition working group/SAMPA/DATA monitoring/Data/SAMPA/"
global githubsampa = "~/Documents/GitHub/sampa-analysis"

cd ~
global dropboxsampa "~/Cox working group Dropbox/TB Nutrition working group/Sampa"
global samparadio "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Analysis/Radiology"
global sampadata "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Management/04-data-delivered-v2/ALL/STATA"
cd ~
cd "$dropboxsampa"
cd "$samparadio"
cd "$sampadata"

cd "$dropbox"

//# USE DATA **********************************************************************

*use "../../DATA monitoring/Data/SAMPA/All_CRF14_Computed_tomography_CT_scans.dta"
cd "$sampadata"

use "All_CRF14_Computed_tomography_CT_scans.dta"

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

//# RESHAPE **********************************************************************
reshape long pan_, i(sampa_id) j(var) string
rename pan_ read

//# CREATE VARIABLES AFTER RESHAPE **********************************************************************

/* Generates a reader variable (radiologist 2 or 3) */
cap drop reader
	gen reader=.
	recode reader .=2 if index(var, "r2")
	recode reader .=3 if index(var, "r3")

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

/* Generates a variable to identify for intra or inter-variability */
cap drop intra
gen intra=0
recode intra 0=1 if index(var, "_intra") 

drop if intra ==.

rename var dim_read

** LABEL VARIABLES **
lab var dim_read "Dimension-Reader"
lab var reader "Reader"
lab var read "Measurement"
lab var cat "Dimension"
lab var intra "QC Type"

** Label values
label define intra 0 "Inter" 1 "Intra"
label values intra intra


*tempfile 0
*save `0/.dta, replace

//# ANALYSIS **********************************************************************

//# Table 1 _ Intra **********************************************************************

* use "SAMPA_long_icc.dta", clear

//drop other cohort, retain only STATT and CLHNS
drop if cohort < 5
