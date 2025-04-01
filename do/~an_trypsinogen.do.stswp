
local filter "if assay_trypsinogen ==1"
table ()(assay_trypsinogen), statistic(mean age bmi) statistic(sd age bmi) ///
													statistic(fvpercent hiv) ///
													statistic(fvpercent diab_hb_gl120) ///
													statistic(fvpercent exposuretime)

													
table () (ever_mal), statistic(count ngml_trypsinogen) statistic(p50 ngml_trypsinogen) statistic(iqr ngml_trypsinogen)

table () (exposuretime), statistic(count ngml_trypsinogen) statistic(p50 ngml_trypsinogen) statistic(iqr ngml_trypsinogen)


cap prog drop mystats
program mystats, rclass
return scalar p_adj= chi2tail(r(df), r(chi2_adj))
return scalar Chi2_adj =  r(chi2_adj)
return scalar  DF =  r(df)
return scalar p= chi2tail(r(df), r(chi2))
return scalar  Chi2 =   r(chi2)
end

kwallis ngml_trypsinogen, by(ever_mal)
kwallis ngml_trypsinogen, by(sex)
kwallis ngml_trypsinogen, by(cohort)
kwallis ngml_trypsinogen, by(exposuretime)
kwallis ngml_trypsinogen, by(diab_hb_gl120)


regress ngml_trypsinogen age // increase with age 
regress ngml_trypsinogen bmi // decrease with bmi
regress ngml_trypsinogen i.ever_mal // decrease with ever_mal  6.2 ( -.0174089    12.49045)
regress ngml_trypsinogen i.cohort // decrease with female  -7 ( -13.28108   -.7973518)
regress ngml_trypsinogen i.sex // decrease with female  -7 ( -13.28108   -.7973518)
regress ngml_trypsinogen i.exposuretime // exposure as adultst 11 (5-17)
regress ngml_trypsinogen i.hiv // hiv 
regress ngml_trypsinogen i.diab_hb_gl120 // diab 
regress ngml_trypsinogen adj_wt_ct_pan_vol // 12 (2,21)
regress ngml_trypsinogen adj_wt_pan_head_ap // 12 (2,21)
regress ngml_trypsinogen mgl_crp // 12 (2,21)

regress ngml_trypsinogen age bmi i.cohort adj_wt_ct_pan_vol
regress ngml_trypsinogen age i.bmi_cat i.cohort adj_wt_ct_pan_vol
regress ngml_trypsinogen age bmi i.cohort adj_wt_ct_pan_vol

dotplot ngml, over(cohort) msize(tiny) msymbol(oh) center median

stripplot ngml_trypsinogen, over(cohort) stack msize(small) msymbol(oh) tufte 

stripplot ngml_trypsinogen, over(bmi_cat) stack msize(small) msymbol(oh) tufte 

stripplot ngml_trypsinogen, over(cohort) cumul cumprob tufte centre vertical mcolor(blue)

stripplot ngml_trypsinogen, over(cohort) cumul tufte centre mcolor(gray) msize(vsmall)

dotplot ngml_trypsinogen 

local filter "if assay_trypsinogen==1"
gr box ngml_trypsinogen  `filter', over(cohort) ///
								medtype(marker) ///
								medmarker(msymbol(D) msize(small) mlstyle(none))
													


stripplot ngml_trypsinogen, over(ever_mal) msize(small) msymbol(oh) tufte 
ct_pan_vol // exposure as adultst 11 (5-17) 

regress ngml_trypsinogen age sex bmi exposuretime ever_mal##bmi_cat

dotplot ngml, over(diab_hb_gl120) msize(tiny) msymbol(oh) center mlabel(hiv)
dotplot ngml, over(ever_mal) msize(tiny) msymbol(oh) center mlabel(cohort)

scatter ngml muac

scatter ngml bmi || lfitci ngml bmi

scatter ngml age || lfitci ngml age

scatter age bmi if ngml!=. || lfitci age bmi if ngml!=.

scatter age bmi if ngml!=. &  cohort!=6 || lfitci age bmi if ngml!=. &  cohort!=6

scatter ngml_trypsinogen mmol_glu120,  mlabel(diab_hb_gl120)
scatter  ngml_trypsinogen ct_pan_vol, mlabel(cohort)

stripplot ngml_trypsinogen, over(diab_hb_gl120) cumul separate(cohort) msize(tiny)
dotplot ngml_trypsinogen, over(africa) msize(tiny) msymbol(oh) center mlabel(cohort)

dotplot ngml_trypsinogen, over(exposuretime) msize(tiny) msymbol(oh) center mlabel(cohort)

kwallis ngml_trypsinogen, by(exposuretime)


