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
	la var assay_fe "Fecal Elastase"

gen assay_lipase = 1 if lipase !=. & lipase >0
	replace assay_lip = 0 if lipase ==.
	la var assay_lip "Lipase"

gen assay_amylase = 1 if amylase !=. & amylase >0
	replace assay_amylase = 0 if amylase ==.
	la var assay_amylase "Amylase"
	
gen assay_trypsinogen = 0
	replace assay_trypsinogen = 1 if assay_tryp ==.
	la var assay_trypsinogen "Trypsinogen"

**# Create new variables for imaging presence; Do not replace combined

clonevar radio2 = radio_exam
	replace radio2 = 0 if radio_exam==.
	la var radio2 "Ultrasound"

clonevar ct2 = ct_scan
	replace ct2 = 0 if ct_scan==.
	la var ct2 "CT Scan"

