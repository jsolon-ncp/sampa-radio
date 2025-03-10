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

local filter "if flag_fecal_elastase !=1"

table (cohort) (ever_mal) `filter', ///
			stat(frequency) ///
			stat(fvfrequency 1.assay_f)  ///
			stat(fvpercent 1.assay_f) ///
			nformat(%5.0f fvpercent)
			
collect style cell result[fvpercent], sformat("(%s%%)")
			
collect title "Fecal Elastase Assays by Cohort and MN Status"
collect style title, font(,bold)

collect label dim ever_mal "Malnutrition Status", modify
collect label levels ever_mal 0 "NPM" 1 "PM", modify

collect recode result fvfrequency = column1
collect recode result fvpercent = column2

collect layout (cohort#result[column1 column2]) (ever_mal)


collect preview

collect _r_p :regress assay_fecal_elastase ever_mal
collect _r_p :regress assay_fecal_elastase cohort


collect preview

