

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

use "../../DATA monitoring/Data/SAMPA/All_CRF14_Computed_tomography_CT_scans.dta", clear
drop redcap_data_access_group cohort sex dob age

//merge radiologist_b
merge 1:1 orgid using "../../DATA monitoring/Data/SAMPA/radiologist_b.dta"

drop redcap_data_access_group cohort sex dob age
drop _merge



//merge final weight data anthropometry
merge 1:1 orgid using "../../DATA monitoring/Data/SAMPA/radiologist_c.dta"

drop _merge



putexcel clear

*** cerate a document
putdocx clear
putdocx begin
putdocx paragraph, style(Title)
putdocx text ("Abdominal CT Scan Report")
putdocx save "../../Data Analysis/Radiology/Descriptives/reports/SAMPA_abdominal_ctscan_report.docx", replace




* clear collection
collect clear

* check collections
collect dir
collect dims
collect label list result, all

table  (cohort) (ct_pan_size_qual) , statistic(frequency) statistic(percent, across(ct_pan_size_qual)) totals(cohort)




** customize the column labels
collect label dim pan_size_qual "Qualitative indicator of pancreas size ", modify
collect preview

** customize the row labels
collect style row stack, nobinder spacer
collect preview

collect style cell border_block, border(right, pattern(nil))
collect preview



** output to an excel file

local table_title `"Qualitative indicator of pancreas size"'

putexcel set "../../Data Analysis/Radiology/Descriptives/tables/SAMPA_abdominal_ctscan_report.xlsx", sheet(Sheet2, replace) modify
putexcel A1 = `"`table_title'"'
putexcel A4 = collect
putexcel save



*** output to a document
putdocx begin
putdocx paragraph
collect style putdocx, layout(autofitcontents) ///
title("Qualitative indicator of pancreas size by cohort")
putdocx collect
putdocx save "../../Data Analysis/Radiology/Descriptives/reports/SAMPA_abdominal_ctscan_report.docx", append







table  (cohort) () , statistic(count r2_pan_head_trans) statistic(mean r2_pan_head_trans) statistic(sd r2_pan_head_trans) 




** customize the column labels
collect label dim pan_size_qual "Qualitative indicator of pancreas size ", modify
collect preview

** customize the row labels
collect style row stack, nobinder spacer
collect preview

collect style cell border_block, border(right, pattern(nil))
collect preview



** output to an excel file

local table_title `"Qualitative indicator of pancreas size"'

putexcel set "../../Data Analysis/Radiology/Descriptives/tables/SAMPA_abdominal_ctscan_report.xlsx", sheet(Sheet2, replace) modify
putexcel A1 = `"`table_title'"'
putexcel A4 = collect
putexcel save



*** output to a document
putdocx begin
putdocx paragraph
collect style putdocx, layout(autofitcontents) ///
title("Qualitative indicator of pancreas size by cohort")
putdocx collect
putdocx save "../../Data Analysis/Radiology/Descriptives/reports/SAMPA_abdominal_ctscan_report.docx", append

















