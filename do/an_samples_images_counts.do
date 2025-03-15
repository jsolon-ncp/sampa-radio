/*
Sampa
an_samples_images_counts.do 
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

	collect : count if assay_fecal_elastase ==1 
	collect : count if assay_fecal_elastase ==1 & radio2==1
	collect : count if assay_fecal_elastase ==1 & radio2==1 & ct2==1
	collect : count if assay_fecal_elastase ==1 | radio2==1 
	collect : count if radio2 ==1 & ct2==1 
	
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
collect label levels cmdset 14 "FE-1 or USS"
collect label levels cmdset 15 "CT and USS"

collect layout (cmdset)(result)

collect export tables/counts.html, as(html) replace

collect clear

table () (ever_mal) , stat(frequency) ///
stat(fvfrequency 1.assay_f 1.radio2 1.ct2)

table ()(ever_mal) if radio2==1, statistic(frequency) statistic(p50 pan_head_trans pan_head_ap) 

collect export tables/trial.html, as(html) replace
collect export tables/trial.xls, as(xlsx) replace
collect export tables/trial.docx, as(docx) replace



