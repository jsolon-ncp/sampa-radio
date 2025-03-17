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


table (var) (ever_mal) , ///
stat(frequency) ///
stat(fvfrequency 1.assay_fecal_elastase 1.epi_binary 2.epi_ordinal 3.epi_ordinal) ///
stat(fvpercent 1.epi_binary 2.epi_ordinal 3.epi_ordinal) 

// ... existing code ...


tab subcoh_child_adult if recruited==1


cc epi_binary ever_mal, exact 


logit epi_binary ever_mal, or 
logit epi_binary subcoh_geography, or 

cc epi_binary subcoh_geography, exact


contrast ever_mal

logit epi_binary i.ever_mal i.sex age bmi i.cohort, or

margins

margins ever_mal
margins sex

margins cohort

marginsplot

logit epi_binary i.ever_mal i.sex age c.bmi##i.cohort, or
margins cohort c.bmi##i.cohort
marginsplot

logit epi_binary ever_mal sex2 age bmi i.cohort, or

logit epi_binary bmi i.cohort, or 

*generating Hosmer-Lemeshow goodness of fit test

estat gof, group(10)

* margins

margins cohort 
*classification statistics

estat classification, all



logit epi_binary ever_mal sex age cohort, or

predict p 

*to generate predicted group memberships

generate prgp = .
replace prgp=0 if(p<.50) 
replace prgp=1 if(p>=.50)

br prgp p assay_fecal_elastase fecal_elastase



* Clear any existing estimates
eststo clear

* Model 1: Unadjusted (ever_mal only)
logistic epi_binary ever_mal
eststo model1
estadd local controls "No"

* Model 2: Adjusted for age
logistic epi_binary ever_mal age
eststo model2
estadd local controls "Age"

* Model 3: Adjusted for cohort
logistic epi_binary ever_mal cohort
eststo model3
estadd local controls "Cohort"

* Model 4: Fully adjusted
logistic epi_binary ever_mal age cohort
eststo model4
estadd local controls "Age + Cohort"

* Export results to HTML
esttab model1 model2 model3 model4 using "03-tables/logistic_models.html", ///
    eform cells(b(fmt(3)) ci(fmt(3) par)) ///
    star(* 0.05 ** 0.01 *** 0.001) ///
    stats(N controls, fmt(%9.0fc) labels("Observations" "Controls")) ///
    mtitles("Model 1" "Model 2" "Model 3" "Model 4") ///
    title("Logistic Regression Models for EPI Binary Outcome") ///
    replace html

* Clear stored estimates
eststo clear

// ... existing code ...




regress epi_binary ever_mal 
logistic epi_binary ever_mal 
ologit epi_ordinal ever_mal 


logistic epi_binary ever_mal 
logistic epi_binary ever_mal cohort 

ologit epi_ordinal ever_mal 
ologit epi_ordinal ever_mal cohort 



table (var) (cohort) , ///
stat(frequency) ///
stat(fvfrequency 1.assay_fecal_elastase 1.epi_binary 2.epi_ordinal 3.epi_ordinal) ///
stat(fvpercent 1.epi_binary 2.epi_ordinal 3.epi_ordinal) 


regress epi_binary cohort
regress epi_ordinal cohort

collect export 03-tables/bivariate_assays.html, as(html) replace

* Clear any existing estimates
eststo clear

* Model 1: Unadjusted (ever_mal only)
logistic epi_binary ever_mal
eststo model1
estadd local controls "No"

* Model 2: Adjusted for age
logistic epi_binary ever_mal age
eststo model2
estadd local controls "Age"

* Model 3: Adjusted for cohort
logistic epi_binary ever_mal cohort
eststo model3
estadd local controls "Cohort"

* Model 4: Fully adjusted
logistic epi_binary ever_mal age cohort
eststo model4
estadd local controls "Age + Cohort"

* Export results to HTML
esttab model1 model2 model3 model4 using "03-tables/logistic_models.html", ///
    eform cells(b(fmt(3)) ci(fmt(3) par)) ///
    star(* 0.05 ** 0.01 *** 0.001) ///
    stats(N controls, fmt(%9.0fc) labels("Observations" "Controls")) ///
    mtitles("Model 1" "Model 2" "Model 3" "Model 4") ///
    title("Logistic Regression Models for EPI Binary Outcome") ///
    replace html

* Clear stored estimates
eststo clear

****
// ... existing code ...

********************************************************************************
* Comparison of table creation approaches
********************************************************************************

estimates clear
collect clear

* 1. COLLECT TABLE APPROACH
logistic epi_binary ever_mal
collect clear
collect _r_b _r_ci _r_p, tag(model[1])
collect label values model 1 "Unadjusted", modify

logistic epi_binary ever_mal age cohort
collect _r_b _r_ci _r_p, tag(model[2])
collect label values model 2 "Adjusted", modify

collect style cell result[_r_b]!model[1], nformat(%9.3f)
collect style cell result[_r_ci]!model[1], nformat(%9.3f)
collect style cell result[_r_p]!model[1], nformat(%9.3f)

collect layout (colname) (model)
collect export "03-tables/logistic_models_collect.html", replace

* 2. ESTOUT APPROACH
estimates clear
logistic epi_binary ever_mal
eststo model1
estadd local controls "No"

logistic epi_binary ever_mal age cohort
eststo model2
estadd local controls "Yes"

esttab model1 model2 using "03-tables/logistic_models_estout.html", ///
    eform cells(b(fmt(3)) ci(fmt(3) par)) ///
    star(* 0.05 ** 0.01 *** 0.001) ///
    stats(N controls, fmt(%9.0fc) labels("Observations" "Controls")) ///
    mtitles("Unadjusted" "Adjusted") ///
    title("Logistic Regression Models") ///
    replace html

* 3. OUTREG2 APPROACH
estimates clear
logistic epi_binary ever_mal
outreg2 using "03-tables/logistic_models_outreg.xls", replace eform ///
    title("Logistic Regression Models") ///
    ctitle("Unadjusted") 

logistic epi_binary ever_mal age cohort
outreg2 using "03-tables/logistic_models_outreg.xls", append eform ///
    ctitle("Adjusted") 

// ... existing code ...
