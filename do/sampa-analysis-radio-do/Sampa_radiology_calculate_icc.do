

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




/*count participants with CT Scan*/

frame copy default all, replace
frame change all

/*keep only records with CT_scan*/

keep if ct_scan==1

table (cohort) ()



/*create copy frames*/

frame copy default radiob, replace
frame copy default radioc, replace

/*change frames*/

frame change radiob


/*calculate intra ICC for radio B*/
drop if r2_pan_head_trans == .


/*count participants with ct_scan readings from radiob*/
table (cohort) ()

/* remove participants without intra sample readings*/

drop if r2_pan_head_trans_intra == .

/*count participants with intra_sample ct_scan readings from radiob*/
table (cohort) ()

exit

keep sampa_id r2_pan_head_trans r2_pan_head_trans_intra


/*rename columns*/

rename r2_pan_head_trans read1
rename r2_pan_head_trans_intra read2

reshape long read, i(sampa_id) j(instance)

exit

icc read sampa_id instance, mixed absolute


return list

postfile `memhold'  str40 var r lb ub using "test", replace

        local vars bmi_17_0 bmi_17_2 bmi_17_5 bmi_17_0_2 bmi_17_0_5 bmi_17_2_5   muac2_0 muac2_2 muac2_5 muac2_0_2 muac2_0_5 muac2_2_5 anaemia_modsev_0 anaemia_modsev_2 anaemia_modsev_5 anaemia_modsev_0_2 anaemia_modsev_0_5 anaemia_modsev_2_5
        foreach v of local vars {
            count if `v'~=.
            local N=r(N)
            levelsof `v', local(vlev)
            foreach t of local vlev {
                count if `v'==`t'
                local r=r(N)
                cii prop N' r'
                local lb=r(lb)
                local ub=r(ub)
        post `memhold' ("`v'") (`N') (`t') (`r') (`lb') (`ub')
            }
        }
        postclose `memhold' 

use "comorb_summ", clear

exit



/*change frames*/

frame change radioc

/*calculate intra ICC for radio C*/

drop if r3_pan_head_trans == .


/*count participants with ct_scan readings from radiob*/
table (cohort) ()

drop if r3_pan_head_trans_intra == .


/*count participants with intra_sample ct_scan readings from radioc*/
table (cohort) ()


keep sampa_id r3_pan_head_trans r3_pan_head_trans_intra


/*rename columns*/

rename r3_pan_head_trans read1
rename r3_pan_head_trans_intra read2

reshape long read, i(sampa_id) j(instance)


icc read sampa_id instance, mixed absolute


/*Calculate ICC comparing Radio B to CICADA radio*/


frame copy default radiobc, replace
frame change radiobc

keep if ct_scan==1 & cohort==3


keep sampa_id ct_pan_head_trans r2_pan_head_trans

drop if r2_pan_head_trans==.



/*rename columns*/

rename ct_pan_head_trans read1
rename r2_pan_head_trans read2

reshape long read, i(sampa_id) j(instance)

label define instance 1 "cohort" 2 "radio B" 3 "radio C"
label values  instance instance

table (instance) (), statistic(count read) statistic(mean read) statistic(sd read)

icc read sampa_id instance, mixed consistency
icc read sampa_id instance, mixed absolute




/*Calculate ICC comparing Radio B to NUSTART radio*/


frame copy default radiobc, replace
frame change radiobc

keep if ct_scan==1 & cohort==4


keep sampa_id ct_pan_head_trans r2_pan_head_trans

drop if r2_pan_head_trans==.



/*rename columns*/

rename ct_pan_head_trans read1
rename r2_pan_head_trans read2

reshape long read, i(sampa_id) j(instance)

label define instance 1 "cohort" 2 "radio B" 3 "radio C"
label values  instance instance

table (instance) (), statistic(count read) statistic(mean read) statistic(sd read)

icc read sampa_id instance, mixed consistency
icc read sampa_id instance, mixed absolute




/*Calculate ICC comparing Radio C to CICADA radio*/


frame copy default radiobc, replace
frame change radiobc

keep if ct_scan==1 & cohort==3


keep sampa_id ct_pan_head_trans r3_pan_head_trans

drop if r3_pan_head_trans==.



/*rename columns*/

rename ct_pan_head_trans read1
rename r3_pan_head_trans read3

reshape long read, i(sampa_id) j(instance)

label define instance 1 "cohort" 2 "radio B" 3 "radio C"
label values  instance instance

table (instance) (), statistic(count read) statistic(mean read) statistic(sd read)

icc read sampa_id instance, mixed consistency
icc read sampa_id instance, mixed absolute




/*Calculate ICC comparing Radio C to NUSTART radio*/


frame copy default radiobc, replace
frame change radiobc

keep if ct_scan==1 & cohort==4


keep sampa_id ct_pan_head_trans r3_pan_head_trans

drop if r3_pan_head_trans==.



/*rename columns*/

rename ct_pan_head_trans read1
rename r3_pan_head_trans read3

reshape long read, i(sampa_id) j(instance)

label define instance 1 "cohort" 2 "radio B" 3 "radio C"
label values  instance instance

table (instance) (), statistic(count read) statistic(mean read) statistic(sd read)

icc read sampa_id instance, mixed consistency
icc read sampa_id instance, mixed absolute





















/*calculate inter rater ICC for radio B and C*/

frame copy default radiobc, replace
frame change radiobc

drop if r2_pan_head_trans == . 
drop if r3_pan_head_trans == .

keep sampa_id r2_pan_head_trans r3_pan_head_trans



/*rename columns*/

rename r2_pan_head_trans read1
rename r3_pan_head_trans read2

reshape long read, i(sampa_id) j(instance)


icc read sampa_id instance, mixed consistency
icc read sampa_id instance, mixed absolute



/*calculate inter rater ICC for original, radio B and C*/

frame copy default radiobc, replace
frame change radiobc

drop if r2_pan_head_trans == . 
drop if r3_pan_head_trans == .

keep sampa_id ct_pan_head_trans r2_pan_head_trans r3_pan_head_trans



/*rename columns*/

rename ct_pan_head_trans read1
rename r2_pan_head_trans read2
rename r3_pan_head_trans read3

reshape long read, i(sampa_id) j(instance)


icc read sampa_id instance, mixed consistency
icc read sampa_id instance, consistency

icc read sampa_id instance, mixed absolute
icc read sampa_id instance, absolute
















