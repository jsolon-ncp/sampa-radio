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

* Model 5: Adjusted for region, BMI, HIV, and age
logistic epi_binary ever_mal i.africa i.bmi_cat i.hiv2 age
eststo model5
estadd local controls "Region + BMI + HIV + Age"

* Check for prioritized interactions
* 1. Region-malnutrition interaction (highest priority)
logistic epi_binary i.ever_mal##i.africa i.bmi_cat i.hiv2 age
eststo model5b
lrtest model5 model5b

* 2. BMI-malnutrition interaction (second priority)
logistic epi_binary i.ever_mal i.africa i.ever_mal##i.bmi_cat i.hiv2 age
eststo model5a
lrtest model5 model5a

* 3. HIV-malnutrition interaction (third priority)
logistic epi_binary i.ever_mal i.africa i.bmi_cat i.ever_mal##i.hiv2 age
eststo model5c
lrtest model5 model5c

* Export results to RTF
esttab model5 model5b model5a model5c using ./tables/logistic_models.rtf, replace ///
    eform cells(b(star fmt(3)) ci(fmt(3) par)) ///
    starlevels(* 0.05 ** 0.01 *** 0.001) ///
    style(rtf) ///
    title("Table 2: Logistic Regression Models for EPI Binary Outcome") ///
    label ///
    varlabels(_cons Constant) ///
    stats(N controls r2_p chi2 p chi2_ll, fmt(%9.0fc %9.3f %9.2f %9.3f %9.2f) ///
    labels("N" "Controls" "Pseudo R-squared" "Chi-squared" "p-value" "Log likelihood")) ///
    mtitles("Model 5" "Model 5b" "Model 5a" "Model 5c") ///
    note("Note: Coefficients are odds ratios" ///
         "PM = Previously Malnourished; NPM = Not Previously Malnourished" ///
         "Reference categories: NPM, Normal BMI, Africa, HIV negative" ///
         "Standard errors in parentheses" ///
         "* p<0.05, ** p<0.01, *** p<0.001")

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

* Model 5: Adjusted for region, BMI, HIV, and age
logistic epi_binary ever_mal i.africa i.bmi_cat i.hiv2 age
eststo model5
estadd local controls "Region + BMI + HIV + Age"

* Check for prioritized interactions
* 1. Region-malnutrition interaction (highest priority)
logistic epi_binary i.ever_mal##i.africa i.bmi_cat i.hiv2 age
eststo model5b
lrtest model5 model5b

* 2. BMI-malnutrition interaction (second priority)
logistic epi_binary i.ever_mal i.africa i.ever_mal##i.bmi_cat i.hiv2 age
eststo model5a
lrtest model5 model5a

* 3. HIV-malnutrition interaction (third priority)
logistic epi_binary i.ever_mal i.africa i.bmi_cat i.ever_mal##i.hiv2 age
eststo model5c
lrtest model5 model5c

* Export results to RTF
esttab model5 model5b model5a model5c using ./tables/logistic_models.rtf, replace ///
    eform cells(b(star fmt(3)) ci(fmt(3) par)) ///
    starlevels(* 0.05 ** 0.01 *** 0.001) ///
    style(rtf) ///
    title("Table 2: Logistic Regression Models for EPI Binary Outcome") ///
    label ///
    varlabels(_cons Constant) ///
    stats(N controls r2_p chi2 p chi2_ll, fmt(%9.0fc %9.3f %9.2f %9.3f %9.2f) ///
    labels("N" "Controls" "Pseudo R-squared" "Chi-squared" "p-value" "Log likelihood")) ///
    mtitles("Model 5" "Model 5b" "Model 5a" "Model 5c") ///
    note("Note: Coefficients are odds ratios" ///
         "PM = Previously Malnourished; NPM = Not Previously Malnourished" ///
         "Reference categories: NPM, Normal BMI, Africa, HIV negative" ///
         "Standard errors in parentheses" ///
         "* p<0.05, ** p<0.01, *** p<0.001")

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

* Logistic Regression Analysis for EPI Binary Outcome
* ------------------------------------------------

* 1. Basic Model
* -------------
* Model 1: Basic model with main effects only
logistic epi_bin i.ever_mal i.bmi_cat i.africa i.child i.exposure i.hiv2
estimates store m1
estimates title: "Basic Model"

* 2. Model with BMI-Malnutrition Interaction
* ----------------------------------------
* Model 2: Adding BMI-malnutrition interaction
logistic epi_bin i.ever_mal##i.bmi_cat i.africa i.child i.exposure i.hiv2
estimates store m2
estimates title: "Model with BMI-Malnutrition Interaction"

* Compare models
lrtest m1 m2

* 3. Model with Region-Malnutrition Interaction
* ------------------------------------------
* Model 3: Adding region-malnutrition interaction
logistic epi_bin i.ever_mal##i.bmi_cat i.ever_mal##i.africa i.child i.exposure i.hiv2
estimates store m3
estimates title: "Model with BMI and Region Interactions"

* Compare with previous model
lrtest m2 m3

* 4. Marginal Effects Analysis
* --------------------------
* Calculate marginal effects for the interaction model
margins, dydx(*) atmeans

* Create margins plots for BMI-malnutrition interaction
margins ever_mal#bmi_cat, atmeans
marginsplot, recast(scatter) ///
    title("BMI Category Effects", size(medium)) ///
    ytitle("Predicted Probability of Low Fecal Elastase") ///
    xtitle("BMI Category") ///
    xlabel(, labsize(medsmall) angle(forty_five)) ///
    graphregion(margin(vsmall)) ///
    plotregion(margin(vlarge)) ///
    yline(0, lcolor(red) lpattern(dash)) ///
    note("PM = Previously Malnourished; NPM = Not Previously Malnourished", size(small)) ///
    plot1opts(msymbol(circle) mcolor(blue)) ///
    plot2opts(msymbol(square) mcolor(red)) ///
    ciopts(lcolor(blue red)) ///
    legend(order(1 "NPM" 2 "PM") rows(1) position(6))
gr save ./figures/m1, replace

* Create margins plot for region-malnutrition interaction
margins ever_mal#africa, atmeans
marginsplot, recast(scatter) ///
    title("Regional Effects", size(medium)) ///
    ytitle("Predicted Probability of Low Fecal Elastase") ///
    xtitle("Region") ///
    xlabel(, labsize(medsmall) angle(forty_five)) ///
    graphregion(margin(vsmall)) ///
    plotregion(margin(vlarge)) ///
    yline(0, lcolor(red) lpattern(dash)) ///
    note("PM = Previously Malnourished; NPM = Not Previously Malnourished", size(small)) ///
    plot1opts(msymbol(circle) mcolor(blue)) ///
    plot2opts(msymbol(square) mcolor(red)) ///
    ciopts(lcolor(blue red)) ///
    legend(order(1 "NPM" 2 "PM") rows(1) position(6))
gr save ./figures/m2, replace

* Combine graphs
graph combine "./figures/m1.gph" "./figures/m2.gph", ///
    title("Combined Effects of BMI and Region", size(medium)) ///
    subtitle("Interactions with Malnutrition", size(small)) ///
    rows(2) cols(1) ///
    ycommon ///
    note("Top: BMI Interaction" "Bottom: Region Interaction", size(vsmall))

gr export ./figures/epi_combined_interactions.png, as(png) replace

* 5. Model Diagnostics
* -------------------
* Create table of results from final model
estout m3 using ./tables/final_logistic_model.rtf, replace ///
    cells(b(star fmt(3)) se(par fmt(3))) ///
    starlevels(* 0.05 ** 0.01 *** 0.001) ///
    style(rtf) ///
    title("Table 2: Final Logistic Model Results") ///
    label ///
    varlabels(_cons Constant) ///
    stats(N r2_p chi2 p chi2_ll, fmt(%9.0fc %9.3f %9.2f %9.3f %9.2f) ///
    labels("N" "Pseudo R-squared" "Chi-squared" "p-value" "Log likelihood")) ///
    note("Note: Coefficients are odds ratios" ///
         "PM = Previously Malnourished; NPM = Not Previously Malnourished" ///
         "Reference categories: NPM, Normal BMI, Africa, Child, Early exposure, HIV negative" ///
         "Standard errors in parentheses" ///
         "* p<0.05, ** p<0.01, *** p<0.001")

* Model fit statistics
estat gof, group(10)
estat classification, all

* Clean up temporary files
erase ./figures/m1.gph
erase ./figures/m2.gph

* Detailed Diagnostics for HIV-Malnutrition Interaction
* --------------------------------------------------

* 1. Calculate predicted probabilities for each combination
margins ever_mal#hiv2, atmeans
marginsplot, recast(scatter) ///
    title("HIV-Malnutrition Interaction", size(medium)) ///
    ytitle("Predicted Probability of EPI") ///
    xtitle("HIV Status") ///
    xlabel(0 "HIV Negative" 1 "HIV Positive", labsize(medsmall)) ///
    graphregion(margin(vsmall)) ///
    plotregion(margin(vlarge)) ///
    note("PM = Previously Malnourished; NPM = Not Previously Malnourished", size(small)) ///
    plot1opts(msymbol(circle) mcolor(blue) msize(medium)) ///
    plot2opts(msymbol(square) mcolor(red) msize(medium)) ///
    ciopts(lcolor(blue red)) ///
    legend(order(1 "NPM (○)" 2 "PM (■)") rows(1) position(6) size(small))
gr save ./figures/hiv_mal_interaction, replace
gr export ./figures//hiv_mal_interaction.png, as(png) replace

* 2. Calculate contrasts between PM and NPM within each HIV status
margins r.ever_mal@hiv2, atmeans
marginsplot, recast(scatter) ///
    title("Contrasts: PM vs NPM by HIV Status", size(medium)) ///
    ytitle("Difference in Predicted Probability (PM - NPM)") ///
    xtitle("HIV Status") ///
    xlabel(0 "HIV Negative" 1 "HIV Positive", labsize(medsmall)) ///
    graphregion(margin(vsmall)) ///
    plotregion(margin(vlarge)) ///
    yline(0, lcolor(red) lpattern(dash)) ///
    note("Positive values indicate higher probability in PM group", size(small)) ///
    plot1opts(msymbol(circle) mcolor(blue)) ///
    ciopts(lcolor(blue))
gr save ./figures/hiv_mal_contrasts, replace

gr export ./figures/hiv_mal_contrasts.png, as(png) replace

* 3. Calculate contrasts between HIV positive and negative within each malnutrition status
margins r.hiv2@ever_mal, atmeans
marginsplot, recast(scatter) ///
    title("Contrasts: HIV+ vs HIV- by Malnutrition Status", size(medium)) ///
    ytitle("Difference in Predicted Probability (HIV+ - HIV-)") ///
    xtitle("Malnutrition Status") ///
    xlabel(0 "NPM" 1 "PM", labsize(medsmall)) ///
    graphregion(margin(vsmall)) ///
    plotregion(margin(vlarge)) ///
    yline(0, lcolor(red) lpattern(dash)) ///
    note("Negative values indicate lower probability in HIV+ group", size(small)) ///
    plot1opts(msymbol(circle) mcolor(blue)) ///
    ciopts(lcolor(blue))
gr save ./figures/hiv_mal_contrasts2, replace
gr export ./figures/hiv_mal_contrasts2, as(png) replace

* 4. Combine all visualizations
graph combine "./figures/hiv_mal_interaction.gph" "./figures/hiv_mal_contrasts.gph" "./figures/hiv_mal_contrasts2.gph", ///
    title("HIV-Malnutrition Interaction Analysis", size(medium)) ///
    rows(3) cols(1) ///
    ycommon ///
    note("Top: Predicted Probabilities" "Middle: PM vs NPM Contrasts" "Bottom: HIV+ vs HIV- Contrasts", size(vsmall))

gr export ./figures/hiv_mal_combined.png, as(png) replace

* 5. Additional Model Diagnostics
* -----------------------------
* Hosmer-Lemeshow test with more groups
estat gof, group(10)

* Classification statistics
estat classification, all

* ROC curve
lroc

* 6. Calculate specific contrasts
* Contrast between PM and NPM in HIV negative
lincom 1.ever_mal

* Contrast between PM and NPM in HIV positive
lincom 1.ever_mal + 1.ever_mal#1.hiv2

* Contrast between HIV positive and negative in NPM
lincom 1.hiv2

* Contrast between HIV positive and negative in PM
lincom 1.hiv2 + 1.ever_mal#1.hiv2

* Clean up temporary files
erase ./figures/hiv_mal_interaction.gph
erase ./figures/hiv_mal_contrasts.gph
erase ./figures/hiv_mal_contrasts2.gph
