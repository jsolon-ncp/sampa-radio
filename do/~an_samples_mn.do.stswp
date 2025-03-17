/*
Sampa
an__samples_mn.do 
Juan Solon 
March 2025
bivariate anaysis - of all lab assays by mn 

assay_fecal_elastase
assay_amylase
assay_lipase
assay_trypsinogen
ever_mal
*/

collect clear

table ever_mal 

collect clear
collect : count if cohort!= .
collect : count if ever_mal==0
collect : count if ever_mal==1
collect : count if radio2==0
collect : count if radio2==1

collect : count if ct2==0
collect : count if ct2==1
collect : count if assay_fecal_elastase==0
collect : count if assay_fecal_elastase==1
collect : count if flag_fecal_elastase==1

tempvar fe1
gen `fe1' = 0
replace `fe1' = 1 if assay_fecal_elastase==1 & flag_fecal_elastase ==.
collect : count if `fe1' ==1 
collect : count if `fe1' ==1 & radio2==1
collect : count if `fe1' ==1 & radio2==1 & ct2==1

*collect : count if assay_lipase==1

collect label levels cmdset 1 "Recruited Participants"
collect label levels cmdset 2 "NPM"
collect label levels cmdset 3 "PM"
collect label levels cmdset 4 "No Ultrasound"
collect label levels cmdset 5 "With Ultrasound"
collect label levels cmdset 6 "No CT Scan"
collect label levels cmdset 7 "With CT Scan"
collect label levels cmdset 8 "No Fecal Elastase Assay"
collect label levels cmdset 9 "With Fecal Elastase Assay"
collect label levels cmdset 10 "with FE-1 Standards Problem"

collect label levels cmdset 11 "FE-1"
collect label levels cmdset 12 "FE-1 and USS"
collect label levels cmdset 13 "FE-1 and USS and CT"

collect layout (cmdset)(result)


