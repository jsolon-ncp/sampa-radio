* Perform PCA on the four measurements
pca pan_head_ap pan_head_trans pan_body_trans pan_tail_trans

* Generate both PC1 and PC2 scores
predict pc1 pc2, score

* Look at how the components relate to each other
scatter pc2 pc1, by(ever_mal) ///
    title("PC2 vs PC1") ///
    subtitle("By Malnutrition Status") ///
    ytitle("PC2") ///
    xtitle("PC1")

* Look at the loadings for PC2 to understand what it represents
* From your results:
* PC2 loadings:
* pan_head_ap: -0.0552
* pan_head_trans: -0.6518
* pan_body_trans: 0.0273
* pan_tail_trans: 0.7559

* logisitc with 1 component
logistic epi_binary pc1 ever_mal age cohort


* Logistic regression using both components
logistic epi_binary pc1 pc2 ever_mal age cohort

* Or create a combined score weighted by their eigenvalues
gen combined_score = (2.27605*pc1 + 0.861804*pc2)/(2.27605 + 0.861804)

logistic epi_binary i.ever_mal i.africa i.bmi_cat i.ever_mal##i.hiv2 age

logistic epi_binary i.ever_mal i.africa i.bmi_cat i.ever_mal##i.hiv2 age pc1

logistic epi_binary i.ever_mal i.africa i.bmi_cat i.ever_mal##i.hiv2 age pc1 pc2

logistic epi_binary i.ever_mal  pc1 pc2 age

logistic epi_binary i.ever_mal pc1 pc2 

table ()(cohort) , statistic(mean pc1 pc2) statistic(sd pc1 pc2)


pc2 age

Component |   Eigenvalue   Proportion   Cumulative
-----------+----------------------------------------
    Comp1 |      2.27605      0.5690       0.5690
    Comp2 |      .861804      0.2155       0.7845
    Comp3 |       .47208      0.1180       0.9025
    Comp4 |      .390062      0.0975       1.0000


* Test if PCA structure differs by cohort
foreach cohort of numlist 1/6 {
    pca pan_head_ap pan_head_trans pan_body_trans pan_tail_trans if cohort==`cohort'
}

misstable pattern pan_head_ap pan_head_trans pan_body_trans pan_tail_trans

// First, let's see sample sizes by cohort for visualized scans
tab cohort if radio3==1

// Do cohort-specific PCAs for complete cases
forvalues c = 1/6 {
    // Full PCA (all 4 measurements)
    pca pan_head_ap pan_head_trans pan_body_trans pan_tail_trans if radio3==1 & cohort==`c'
    predict pc_full1_c`c' pc_full2_c`c' if e(sample), score
    
    // PCA without tail
    pca pan_head_ap pan_head_trans pan_body_trans if radio3==1 & cohort==`c'
    predict pc_notail1_c`c' pc_notail2_c`c' if e(sample), score
    
    // PCA without head trans
    pca pan_head_ap pan_body_trans pan_tail_trans if radio3==1 & cohort==`c'
    predict pc_noheadtr1_c`c' pc_noheadtr2_c`c' if e(sample), score
    
    // Standardize within cohort
    foreach type in full notail noheadtr {
        egen std_pc_`type'1_c`c' = std(pc_`type'1_c`c')
        egen std_pc_`type'2_c`c' = std(pc_`type'2_c`c')
    }
}

// Combine scores within each cohort
gen pc1_combined = .
gen pc2_combined = .

forvalues c = 1/6 {
    replace pc1_combined = std_pc_full1_c`c' if cohort==`c' & radio3==1
    replace pc1_combined = std_pc_notail1_c`c' if missing(pc1_combined) & cohort==`c' & radio3==1
    replace pc1_combined = std_pc_noheadtr1_c`c' if missing(pc1_combined) & cohort==`c' & radio3==1
    
    replace pc2_combined = std_pc_full2_c`c' if cohort==`c' & radio3==1
    replace pc2_combined = std_pc_notail2_c`c' if missing(pc2_combined) & cohort==`c' & radio3==1
    replace pc2_combined = std_pc_noheadtr2_c`c' if missing(pc2_combined) & cohort==`c' & radio3==1
}

// Look at eigenvalues and loadings by cohort
forvalues c = 1/6 {
    display _n "Cohort `c'" _n "===================="
    pca pan_head_ap pan_head_trans pan_body_trans pan_tail_trans if radio3==1 & cohort==`c'
    estat loadings
}

// Look at missing patterns separately for each cohort
forvalues c = 1/6 {
    display _n _n "Cohort `c'" _n "===================="
    misstable pattern pan_head_ap pan_head_trans pan_body_trans pan_tail_trans if radio3==1 & cohort==`c'
}

// Create a table of loadings by cohort
foreach var in pan_head_ap pan_head_trans pan_body_trans pan_tail_trans {
    display _n "`var' loadings across cohorts:"
    display "Cohort   PC1     PC2"
    display "======================"
    forvalues c = 1/6 {
        pca pan_head_ap pan_head_trans pan_body_trans pan_tail_trans if radio3==1 & cohort==`c'
        matrix list e(L)
    }
}

// Calculate correlation between PC scores from different cohorts
forvalues c = 1/6 {
    forvalues d = `=`c'+1'/6 {
        display _n "Correlation between cohort `c' and `d' PC scores:"
        correlate pc_full1_c`c' pc_full1_c`d' if !missing(pc_full1_c`c', pc_full1_c`d')
        correlate pc_full2_c`c' pc_full2_c`d' if !missing(pc_full2_c`c', pc_full2_c`d')
    }
}

// Graph loadings by cohort
foreach comp in 1 2 {
    graph bar (asis) pc_full`comp'_c*, over(cohort) ///
        title("PC`comp' scores by cohort") ///
        ytitle("PC`comp' score")
}

// Scatterplots of PC1 vs PC2 by cohort
scatter pc_full2_c* pc_full1_c*, by(cohort) ///
    title("PC2 vs PC1 by cohort") ///
    ytitle("PC2") xtitle("PC1")

// Set up multiple imputation for each cohort
forvalues c = 1/6 {
    // Save original dataset
    preserve
    
    // Keep only cohort c
    keep if cohort==`c'
    
    // Multiple imputation
    mi set wide
    mi register imputed pan_head_ap pan_head_trans pan_body_trans pan_tail_trans
    mi impute mvn pan_head_ap pan_head_trans pan_body_trans pan_tail_trans = age bmi, add(20)
    
    // Run PCA on each imputed dataset
    mi xeq: pca pan_head_ap pan_head_trans pan_body_trans pan_tail_trans
    mi xeq: predict pc1_imp pc2_imp, score
    
    // Combine results across imputations
    mi estimate: mean pc1_imp pc2_imp
    
    restore
}

// Compare distributions of original vs imputed values
foreach var of varlist pan_head_ap pan_head_trans pan_body_trans pan_tail_trans {
    twoway (kdensity `var' if !missing(`var')) ///
           (kdensity `var'_imp if missing(`var')), ///
    by(cohort) title("Original vs Imputed `var'")
}

// Compare PCA structures pre/post imputation
forvalues c = 1/6 {
    // Original PCA
    pca pan_head_ap pan_head_trans pan_body_trans pan_tail_trans if cohort==`c'
    // Imputed PCA
    mi xeq: pca pan_head_ap pan_head_trans pan_body_trans pan_tail_trans if cohort==`c'
}