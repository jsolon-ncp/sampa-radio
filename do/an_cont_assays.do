/*
an_cont_assays.do 
Analysis of fecal elastase levels
ul_amylp mgl_crp mgl_cystatin
ngml tryp

*/
capture log close
log using ./log/an_cont.txt, replace

* 1. Descriptive Statistics
* ------------------------
* Basic statistics for key variables
table (cohort) (ever_mal), ///
stat(frequency) /// 
stat(mean fecal_elastase ul_amylp lipase ngml_trypsinogen) ///
stat(p25 fecal_elastase ul_amylp lipase ngml_trypsinogen) ///
stat(p50 fecal_elastase ul_amylp lipase ngml_trypsinogen) ///
stat(p75 fecal_elastase ul_amylp lipase ngml_trypsinogen) ///
stat(iqr fecal_elastase ul_amylp lipase ngml_trypsinogen)



dtable if subset==1, by(ever_mal, tests) ///
continuous(fecal_elastase ul_amylp lipase ngml_trypsinogen, ///
statistics(p50 iqr) test(kwallis)) 


table () (bmi_cat), ///
stat(frequency) /// 
stat(mean fecal_elastase) ///
stat(p25 fecal_elastase) ///
stat(p50 fecal_elastase) ///
stat(p75 fecal_elastase) ///
stat(iqr fecal_elastase)

* 2. Basic Model
* -------------
* Model 1: Basic model with main effects only
tobit fecal_elastase i.ever_mal i.bmi_cat i.africa i.child i.exposure i.hiv2, ul(600)
	estimates store m1
estimates title: "Basic Model"

* 3. Model with BMI-Malnutrition Interaction
* ----------------------------------------
* Model 2: Adding BMI-malnutrition interaction
tobit fecal_elastase i.ever_mal##i.bmi_cat i.africa i.child i.exposure i.hiv2, ul(600)
	estimates store m2
estimates title: "Model with BMI-Malnutrition Interaction"

* Compare models
lrtest m1 m2

* 4. Marginal Effects Analysis
* --------------------------
* Calculate marginal effects for the interaction model
margins, dydx(*) atmeans

* Create margins plots for BMI-malnutrition interaction
margins ever_mal#bmi_cat, atmeans

marginsplot, title("Marginal Effects of Malnutrition by BMI Category") ///
    ytitle("Marginal Effect on Fecal Elastase") ///
    xtitle("Previous Malnutrition") ///
    note("Interaction between Malnutrition and BMI", size(small)) ///
	graphregion(margin(vsmall)) ///
        plotregion(margin(vlarge)) ///
        xlabel(,labsize(medsmall))	
	
gr export ./figures/fe_mal_bmi_interaction.png, as(png) replace

* 5. Predicted Values
* ------------------
* Calculate predicted values for each combination
margins ever_mal#bmi_cat, atmeans

* Test contrasts between PM and NPM within each BMI category
margins r.ever_mal@bmi_cat, atmeans
marginsplot, recast(scatter) ///
    title("Contrasts of PM vs NPM by BMI - FE-1") ///
    ytitle("Contrast of Linear Prediction ") ///
    xtitle("BMI Category") ///
    xlabel(, labsize(medsmall) angle(forty_five)) ///
    graphregion(margin(vsmall)) ///
    plotregion(margin(vlarge)) ///
    yline(0)
gr export ./figures/fe_contrasts_by_bmi.png, as(png) replace

* Visualize predicted values
marginsplot, bydimension(bmi_cat) recast(scatter) ///
    ytitle("Linear Prediction Fecal Elastase") ///
    xtitle("Current BMI Categories") ///
    xlabel(, labsize(medsmall) angle(forty_five)) ///
    graphregion(margin(vsmall)) ///
    plotregion(margin(vlarge)) ///
    byopts(yrescale title("Predicted Fecal Elastase by BMI Category and Malnutrition Status") ///
           note("PM = Previously Malnourished; NPM = Not Previously Malnourished", size(small)) rows(2))
gr export ./figures/fe_predicted_by_bmi.png, as(png) replace

* 6. Additional Interactions
* ------------------------
* Only after confirming BMI-malnutrition interaction, we can explore other interactions
* Model 3: Adding region-malnutrition interaction
tobit fecal_elastase i.ever_mal##i.bmi_cat i.ever_mal##i.africa i.child i.exposure i.hiv2, ul(600)
estimates store m3
estimates title: "Model with BMI and Region Interactions"

* Compare with previous model
lrtest m2 m3

* Calculate and plot region-malnutrition interaction
margins ever_mal#africa, atmeans

* Test for significant interaction between region and malnutrition
test 1.ever_mal#1.africa 1.ever_mal#0.africa

* Alternative way to test the interaction using margins
margins r.ever_mal@africa, atmeans
marginsplot, recast(scatter) ///
    title("Contrasts of PM vs NPM by Region") ///
    ytitle("Contrast of Linear Prediction") ///
    xtitle("Region") ///
    xlabel(, labsize(medsmall) angle(forty_five)) ///
    graphregion(margin(vsmall)) ///
    plotregion(margin(vlarge)) ///
    yline(0)
gr export ./figures/fe_contrasts_by_region.png, as(png) replace

* Calculate and display the difference in malnutrition effect between regions
margins r.ever_mal@africa, atmeans

* 7. Final Model Diagnostics
* -------------------------
* Create table of results from final model
estout m3 using ./tables/final_model.rtf, replace ///
    cells(b(star fmt(3)) se(par fmt(3))) ///
    starlevels(* 0.05 ** 0.01 *** 0.001) ///
    style(rtf) ///
    title("Table 1: Final Tobit Model Results") ///
    label ///
    varlabels(_cons Constant) ///
    stats(N r2_p chi2 p chi2_ll, fmt(%9.0fc %9.3f %9.2f %9.3f %9.2f) ///
    labels("N" "Pseudo R-squared" "Chi-squared" "p-value" "Log likelihood")) ///
    note("Note: Coefficients are from Tobit model with upper limit of 600" ///
         "PM = Previously Malnourished; NPM = Not Previously Malnourished" ///
         "Reference categories: NPM, Normal BMI, Africa, Child, Early exposure, HIV negative" ///
         "Standard errors in parentheses" ///
         "* p<0.05, ** p<0.01, *** p<0.001")

* Create table of predicted values
margins ever_mal#bmi_cat ever_mal#africa, atmeans
matrix b = r(b)
matrix V = r(V)
matrix list b
matrix list V

* Create table of contrasts
margins r.ever_mal@bmi_cat r.ever_mal@africa, atmeans
matrix b = r(b)
matrix V = r(V)
matrix list b
matrix list V

* Create table of joint tests
test 1.ever_mal#1.africa 1.ever_mal#0.africa
test 1.ever_mal#1.bmi_cat 1.ever_mal#2.bmi_cat 1.ever_mal#3.bmi_cat

* Create table of model fit statistics
estat ic

* Create combined graph of all interactions
margins ever_mal#bmi_cat, atmeans
marginsplot, recast(scatter) ///
    title("BMI Category Effects", size(medium)) ///
    ytitle("Linear Prediction Fecal Elastase") ///
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

margins ever_mal#africa, atmeans
marginsplot, recast(scatter) ///
    title("Regional Effects", size(medium)) ///
    ytitle("Linear Prediction Fecal Elastase") ///
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

* Create a new graph specifically for regional contrasts
margins r.ever_mal@africa, atmeans
marginsplot, recast(scatter) ///
    title("Regional Differences in Malnutrition Effect", size(medium)) ///
    subtitle("PM vs NPM by Region", size(small)) ///
    ytitle("Difference in Fecal Elastase (PM - NPM)") ///
    xtitle("Region") ///
    xlabel(, labsize(medsmall) angle(forty_five)) ///
    graphregion(margin(vsmall)) ///
    plotregion(margin(vlarge)) ///
    yline(0, lcolor(red) lpattern(dash)) ///
    note("Africa: +18.74 (p=0.306)" "Asia: +61.24 (p=0.007)" "Joint test p=0.020", size(small))
gr export ./figures/fe_regional_contrasts.png, as(png) replace

* Combine all graphs
graph combine "./figures/m1.gph" "./figures/m2.gph", ///
    title("Combined Effects of BMI and Region", size(medium)) ///
    subtitle("Interactions with Malnutrition", size(small)) ///
    rows(2) cols(1) ///
    ycommon ///
    note("Top: BMI Interaction" "Bottom: Region Interaction", size(vsmall))

gr export ./figures/fe_combined_interactions.png, as(png) replace

// Clean up temporary files
erase ./figures/m1.gph
erase ./figures/m2.gph

marginsplot, title("Marginal Effects of Malnutrition by Region") ///
    ytitle("Marginal Effect on Fecal Elastase") ///
    xtitle("Region") ///
    note("Asia vs Reference", size(small)) ///
        graphregion(margin(vsmall)) ///
        plotregion(margin(vlarge)) ///
        xlabel(,labsize(medsmall)) 

