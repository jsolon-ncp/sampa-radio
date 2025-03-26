/* 
cr_sample_binary.do				// Generates or recodes ultrasound ct scan and elisa assays as binary with or without samples
								// Include here the same for presence or absence of functional enzyme assays 
								
Juan Solon
March 3 2025

*/

**# Generate recruitment and sample variables

gen recruited = 1
	la var recruited "Recruited"

gen assay_fecal_elastase = 1 if fecal_elastase !=. & fecal_elastase >0
	replace assay_fe = 0 if fecal_elastase==. 
	la var assay_fe "Fecal Elastase Assay"

gen assay_lipase = 1 if lipase !=. & lipase >0
	replace assay_lip = 0 if lipase ==.
	la var assay_lip "Lipase Assay"

gen assay_amylase = 1 if ul_amylp   !=. & ul_amylp   >0
	*replace assay_amylase = 0 if amylase ==.
	la var assay_amylase "Amylase Assay"
	
gen assay_trypsinogen = 1 if ngml_trypsinogen !=. & ngml_trypsinogen >0
	*replace assay_trypsinogen = 0 if trypsinogen ==.
	la var assay_trypsinogen "Trypsinogen Assay"
*/

**# Create new variables for imaging presence; Do not replace combined


clonevar radio2 = radio_exam
	replace radio2 = 0 if radio_exam==.
	la var radio2 "Ultrasound"

clonevar ct2 = ct_scan
	replace ct2 = 0 if ct_scan==.
	la var ct2 "CT Scan"

egen radio_mis_dims = rowmiss(pan_head_ap pan_head_trans pan_body_trans pan_tail_trans)


egen radio_mis_all = rowmiss(pan_size_qual pan_head_trans pan_head_ap pan_body_trans pan_tail_trans pan_shape pan_shape_problem pan_shape_prob_specify pan_contour pan_contour_problem pan_contour_prob_specify pan_parenchyma pan_paren_inflam pan_paren_fibrosis pan_paren_steatosis pan_duct pan_duct_stones pan_duct_mass pan_calci pan_calci_place pan_cyst_yes pan_oth_abnormal pan_oth_abn_specify)

clonevar radio3 = radio2
replace radio3 = 0 if radio_mis_dims ==4
la var radio3 "USS Scans Visualized"

	
gen subset = 0
replace subset = 1 if radio3==1 | assay_fecal_elastase ==1
la var subset "Analysis Subset (With Fe-1 or USS)"

gen subset2 = 0
replace subset2 = 1 if radio3==1 | assay_fecal_elastase ==1 | ct2==1
la var subset2 "Analysis Subset 2 (With Fe-1 or USS or CT Scan)"

