/*
an_cont_assays.do 
Analysis of fecal elastase levels
*/

log using ./log/an_cont.txt, replace

* 1. Descriptive Statistics
* ------------------------
* Basic statistics for key variables
table () (ever_mal), ///
    stat(frequency) /// 
    stat(mean fecal_elastase) ///
    stat(p25 fecal_elastase) ///
    stat(p50 fecal_elastase) ///
    stat(p75 fecal_elastase) ///
    stat(iqr fecal_elastase)

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
marginsplot, by(bmi_cat) ///
    title("Predicted Fecal Elastase by Malnutrition Status") ///
    subtitle("Stratified by BMI Category") ///
    ytitle("Predicted Fecal Elastase") ///
    xtitle("Malnutrition Status") ///
    note("PM = Previous Malnutrition", size(small))
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
marginsplot, title("Marginal Effects of Malnutrition by Region") ///
    ytitle("Marginal Effect on Fecal Elastase") ///
    xtitle("Region") ///
    note("Interaction between Malnutrition and Region", size(small))
gr export ./figures/fe_mal_region_interaction.png, as(png) replace

* 7. Final Model Diagnostics
* -------------------------
* Create combined graph of all interactions
margins ever_mal#bmi_cat, atmeans saving(m1, replace)
margins ever_mal#africa, atmeans saving(m2, replace)

graph combine "m1" "m2", ///
    title("Combined Effects of BMI and Region", size(medium)) ///
    subtitle("Interactions with Malnutrition", size(small)) ///
    rows(2) cols(1) ///
    ycommon ///
    note("Top: BMI Interaction" "Bottom: Region Interaction", size(vsmall))

gr export ./figures/fe_combined_interactions.png, as(png) replace

// Clean up temporary files
erase m1.gph
erase m2.gph

marginsplot, title("Marginal Effects of Malnutrition by Region") ///
>     ytitle("Marginal Effect on Fecal Elastase") ///
>     xtitle("Region") ///
>     note("Asia vs Reference", size(small)) ///
>         graphregion(margin(vsmall)) ///
>         plotregion(margin(vlarge)) ///
>         xlabel(,labsize(medsmall)) 

