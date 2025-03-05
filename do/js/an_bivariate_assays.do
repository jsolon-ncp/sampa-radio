/*
Sampa
an__bivariate_assays.do 
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

local filter "if flag_fecal_elastase!=1"
table (var) (ever_mal) `filter', ///
stat(frequency) ///
stat(fvfrequency 1.assay_fecal_elastase 1.epi_binary 2.epi_ordinal 3.epi_ordinal) ///
stat(fvpercent 1.epi_binary 2.epi_ordinal 3.epi_ordinal) 

regress epi_binary ever_mal
ologit epi_ordinal ever_mal

local filter "if flag_fecal_elastase!=1"
table (var) (cohort) `filter', ///
stat(frequency) ///
stat(fvfrequency 1.assay_fecal_elastase 1.epi_binary 2.epi_ordinal 3.epi_ordinal) ///
stat(fvpercent 1.epi_binary 2.epi_ordinal 3.epi_ordinal) 


regress epi_binary cohort
regress epi_ordinal cohort

collect export 03-tables/bivariate_assays.html, as(html) replace
