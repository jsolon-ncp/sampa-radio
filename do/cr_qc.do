
/* QC variables */
cap drop r2_pan_vol
	gen r2_pan_vol=((r2_pan_tail_trans+r2_pan_body_trans)/2)*r2_pan_body_tail*r2_pan_cc_body+((r2_pan_head_ap/2)^2)*3.14*r2_pan_cc_head
	cap label variable r2_pan_vol "Calculated Pancreatic Volume; Radiologist 2"

cap drop r3_pan_vol
	gen r3_pan_vol=((r3_pan_tail_trans+r3_pan_body_trans)/2)*r3_pan_body_tail*r3_pan_cc_body+((r3_pan_head_ap/2)^2)*3.14*r3_pan_cc_head
	cap label variable r3_pan_vol "Calculated Pancreatic Volume; Radiologist 3"

cap drop r2_pan_vol_intra
	gen r2_pan_vol_intra=((r2_pan_tail_trans_intra+r2_pan_body_trans_intra)/2)*r2_pan_body_tail_intra*r2_pan_cc_body_intra+((r2_pan_head_ap_intra/2)^2)*3.14*r2_pan_cc_head_intra
	cap label variable r2_pan_vol_intra "Calculated Pancreatic Volume Intra; Radiologist 2"

cap drop r3_pan_vol_intra
	gen r3_pan_vol_intra=((r3_pan_tail_trans_intra+r3_pan_body_trans_intra)/2)*r3_pan_body_tail_intra*r3_pan_cc_body_intra+((r3_pan_head_ap_intra/2)^2)*3.14*r3_pan_cc_head_intra
	cap label variable r3_pan_vol_intra "Calculated Pancreatic Volume Intra; Radiologist 3"
