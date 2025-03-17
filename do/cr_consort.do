/* cr_consort.do 
March 17 2025
Creates subset of data for both consort and venn diagrams in R
keeps cohort radio2 ct2 assay_fecal_elastase
generates sets as consort vars
generates sets of vennvars

*/


preserve
keep cohort ct2 radio2 assay_fecal_elastase assay_lipase

save ./data-temp/sampa_consort.dta, replace

restore 


 