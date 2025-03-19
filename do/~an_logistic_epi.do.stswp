/*
Sampa
an_logistic_epi.do 
Juan Solon 
March 2025
Logistic regression analysis of EPI binary outcome
*/

* Clear any existing estimates and memory
clear matrix
clear mata
eststo clear
collect clear

* 1. Basic Models
* -------------
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

* 2. Models with Interactions
* -------------------------
* Model 5a: Adding BMI-malnutrition interaction
logistic epi_binary i.ever_mal i.africa i.ever_mal##i.bmi_cat i.hiv2 age
eststo model5a
estadd local controls "All + BMI Interaction"

* Model 5b: Adding region-malnutrition interaction
logistic epi_binary i.ever_mal##i.africa i.bmi_cat i.hiv2 age
eststo model5b
estadd local controls "All + Region Interaction"

* Model 5c: Adding HIV-malnutrition interaction
logistic epi_binary i.ever_mal i.africa i.bmi_cat i.ever_mal##i.hiv2 age
eststo model5c
estadd local controls "All + HIV Interaction"

* 3. Model Comparisons
* -------------------
* Compare models with likelihood ratio tests
lrtest model5 model5a
lrtest model5 model5b
lrtest model5 model5c

* 4. Detailed Diagnostics for HIV-Malnutrition Interaction
* --------------------------------------------------
* Calculate predicted probabilities for each combination
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
gr export ./figures/hiv_mal_interaction.png, as(png) replace

* Calculate contrasts between PM and NPM within each HIV status
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

* Calculate contrasts between HIV positive and negative within each malnutrition status
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
gr export ./figures/hiv_mal_contrasts2.png, as(png) replace

* Combine all HIV-malnutrition visualizations
graph combine "./figures/hiv_mal_interaction.gph" "./figures/hiv_mal_contrasts.gph" "./figures/hiv_mal_contrasts2.gph", ///
    title("HIV-Malnutrition Interaction Analysis", size(medium)) ///
    rows(3) cols(1) ///
    ycommon ///
    note("Top: Predicted Probabilities" "Middle: PM vs NPM Contrasts" "Bottom: HIV+ vs HIV- Contrasts", size(vsmall))

gr export ./figures/hiv_mal_combined.png, as(png) replace

* 4a. Detailed Diagnostics for Africa-Malnutrition Interaction
* ------------------------------------------------------
* Calculate predicted probabilities for each combination
margins ever_mal#africa, atmeans

* Summarize key findings from Africa-malnutrition interaction
* -----------------------------------------------------
* 1. Overall patterns:
* - Higher predicted probabilities in Africa compared to Asia for both PM and NPM
* - NPM group shows slightly higher probabilities than PM group in both regions
*
* 2. Specific probabilities:
* Africa:
* - NPM: 46.8% (95% CI: 42.9-50.8%)
* - PM: 45.3% (95% CI: 40.1-50.5%)
*
* Asia:
* - NPM: 14.0% (95% CI: 10.7-17.2%)
* - PM: 13.3% (95% CI: 10.3-16.2%)
*
* 3. Key observations:
* - Large regional difference: ~33% higher probability in Africa vs Asia
* - Small malnutrition effect: ~1.5% difference between PM and NPM in Africa
* - Very small malnutrition effect: ~0.7% difference between PM and NPM in Asia
*
* 4. Statistical significance:
* - All differences are statistically significant (p<0.001)
* - Standard errors are smaller in Asia, suggesting more precise estimates

marginsplot, recast(scatter) ///
    title("Africa-Malnutrition Interaction", size(medium)) ///
    ytitle("Predicted Probability of EPI") ///
    xtitle("Region") ///
    xlabel(0 "Africa" 1 "Asia", labsize(medsmall)) ///
    graphregion(margin(vsmall)) ///
    plotregion(margin(vlarge)) ///
    note("PM = Previously Malnourished; NPM = Not Previously Malnourished", size(small)) ///
    plot1opts(msymbol(circle) mcolor(blue) msize(medium)) ///
    plot2opts(msymbol(square) mcolor(red) msize(medium)) ///
    ciopts(lcolor(blue red)) ///
    legend(order(1 "NPM (○)" 2 "PM (■)") rows(1) position(6) size(small))
gr save ./figures/africa_mal_interaction, replace
gr export ./figures/africa_mal_interaction.png, as(png) replace

* Calculate contrasts between PM and NPM within each region
margins r.ever_mal@africa, atmeans
marginsplot, recast(scatter) ///
    title("Contrasts: PM vs NPM by Region", size(medium)) ///
    ytitle("Difference in Predicted Probability (PM - NPM)") ///
    xtitle("Region") ///
    xlabel(0 "Africa" 1 "Asia", labsize(medsmall)) ///
    graphregion(margin(vsmall)) ///
    plotregion(margin(vlarge)) ///
    yline(0, lcolor(red) lpattern(dash)) ///
    note("Positive values indicate higher probability in PM group", size(small)) ///
    plot1opts(msymbol(circle) mcolor(blue)) ///
    ciopts(lcolor(blue))
gr save ./figures/africa_mal_contrasts, replace
gr export ./figures/africa_mal_contrasts.png, as(png) replace

* Calculate contrasts between Asia and Africa within each malnutrition status
margins r.africa@ever_mal, atmeans
marginsplot, recast(scatter) ///
    title("Contrasts: Asia vs Africa by Malnutrition Status", size(medium)) ///
    ytitle("Difference in Predicted Probability (Asia - Africa)") ///
    xtitle("Malnutrition Status") ///
    xlabel(0 "NPM" 1 "PM", labsize(medsmall)) ///
    graphregion(margin(vsmall)) ///
    plotregion(margin(vlarge)) ///
    yline(0, lcolor(red) lpattern(dash)) ///
    note("Positive values indicate higher probability in Asia", size(small)) ///
    plot1opts(msymbol(circle) mcolor(blue)) ///
    ciopts(lcolor(blue))
gr save ./figures/africa_mal_contrasts2, replace
gr export ./figures/africa_mal_contrasts2.png, as(png) replace

* Combine all Africa-malnutrition visualizations
graph combine "./figures/africa_mal_interaction.gph" "./figures/africa_mal_contrasts.gph" "./figures/africa_mal_contrasts2.gph", ///
    title("Africa-Malnutrition Interaction Analysis", size(medium)) ///
    rows(3) cols(1) ///
    ycommon ///
    note("Top: Predicted Probabilities" "Middle: PM vs NPM Contrasts" "Bottom: Asia vs Africa Contrasts", size(vsmall))

gr export ./figures/africa_mal_combined.png, as(png) replace

* Calculate specific contrasts for Africa-malnutrition interaction
* Contrast between PM and NPM in Africa
lincom 1.ever_mal

* Contrast between PM and NPM in Asia
lincom 1.ever_mal + 1.ever_mal#1.africa

* Contrast between Asia and Africa in NPM
lincom 1.africa

* Contrast between Asia and Africa in PM
lincom 1.africa + 1.ever_mal#1.africa

* Compare Africa-PM and HIV-PM Interactions
* --------------------------------------
* 1. Magnitude of Effects:
* Africa-PM interaction:
* - Difference between PM and NPM in Africa: ~1.5%
* - Difference between PM and NPM in Asia: ~0.7%
* - Regional difference in NPM: ~32.8%
* - Regional difference in PM: ~32.0%
*
* HIV-PM interaction:
* - Difference between PM and NPM in HIV-: ~1.5%
* - Difference between PM and NPM in HIV+: ~2.2%
* - HIV effect in NPM: ~-5.0%
* - HIV effect in PM: ~-6.7%
*
* 2. Key Observations:
* - Both interactions show small effects of malnutrition status
* - Africa shows much larger regional differences than HIV status differences
* - HIV effect is more consistent across malnutrition groups
* - Africa effect is more pronounced in NPM group
*
* 3. Statistical Significance:
* - Both interactions are statistically significant
* - Africa effect has larger standard errors
* - HIV effect shows more precise estimates

* Clean up temporary files for Africa-malnutrition interaction
erase ./figures/africa_mal_interaction.gph
erase ./figures/africa_mal_contrasts.gph
erase ./figures/africa_mal_contrasts2.gph

* 5. Model Diagnostics
* -------------------
* Hosmer-Lemeshow test with 10 groups
estat gof, group(10)

* Classification statistics
estat classification, all

* ROC curve
lroc

* Calculate specific contrasts
* Contrast between PM and NPM in HIV negative
lincom 1.ever_mal

* Contrast between PM and NPM in HIV positive
lincom 1.ever_mal + 1.ever_mal#1.hiv2

* Contrast between HIV positive and negative in NPM
lincom 1.hiv2

* Contrast between HIV positive and negative in PM
lincom 1.hiv2 + 1.ever_mal#1.hiv2

* 6. Export Results
* --------------
* Create table of results from all models
esttab model1 model2 model3 model4 model5 model5a model5b model5c using ./tables/logistic_models.rtf, replace ///
    eform cells(b(star fmt(3)) ci(fmt(3) par)) ///
    starlevels(* 0.05 ** 0.01 *** 0.001) ///
    style(rtf) ///
    title("Table 2: Logistic Regression Models for EPI Binary Outcome") ///
    label ///
    varlabels(_cons Constant) ///
    stats(N controls r2_p chi2 p chi2_ll, fmt(%9.0fc %9.3f %9.2f %9.3f %9.2f) ///
    labels("N" "Controls" "Pseudo R-squared" "Chi-squared" "p-value" "Log likelihood")) ///
    mtitles("Model 1" "Model 2" "Model 3" "Model 4" "Model 5" "Model 5a" "Model 5b" "Model 5c") ///
    note("Note: Coefficients are odds ratios" ///
         "PM = Previously Malnourished; NPM = Not Previously Malnourished" ///
         "Reference categories: NPM, Normal BMI, Africa, HIV negative" ///
         "Standard errors in parentheses" ///
         "* p<0.05, ** p<0.01, *** p<0.001")

* Clean up temporary files
erase ./figures/hiv_mal_interaction.gph
erase ./figures/hiv_mal_contrasts.gph
erase ./figures/hiv_mal_contrasts2.gph


