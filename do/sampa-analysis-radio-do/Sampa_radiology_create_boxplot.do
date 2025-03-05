
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


drop if cohort<3


label variable ct_pan_head_trans "original"
label variable avg_ct_pan_head_trans "average"
label variable r2_pan_head_trans "Radio B only"
label variable r3_pan_head_trans "Radio C only"

graph box ct_pan_head_trans r2_pan_head_trans r3_pan_head_trans avg_ct_pan_head_trans, over(cohort)


