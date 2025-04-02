
local subj1 "record_id cohort sampa_id orgid sex dob age hiv"

local nutrition "bmi haz bmiz bmi_cat_child bmi_cat weight height muac waist hip"

local subj2 "indepth_sample indepth_exp ct_sample ct ivgtt_sample ivgtt uss_sample uss ever_mal degree_mal"

local ses "ses_tercile"

local uss "radio_exam pan_size_qual pan_head_trans pan_head_ap pan_body_trans pan_tail_trans pan_shape pan_shape_problem pan_shape_prob_specify pan_contour pan_contour_problem pan_contour_prob_specify pan_parenchyma pan_paren_inflam pan_paren_fibrosis pan_paren_steatosis pan_duct pan_duct_stones pan_duct_mass pan_calci pan_calci_place pan_cyst_yes pan_oth_abnormal pan_oth_abn_specify pancreatic"

local ct "ct_pan_size_qual ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head ct_pan_shape ct_pan_shape_problem ct_pan_shape_prob_spec ct_pan_contour ct_pan_contour_problem ct_pan_contour_prob_spec ct_pan_parenchyma ct_pan_paren_inflam ct_pan_paren_fibrosis ct_pan_paren_steatosis ct_pan_duct ct_pan_duct_stones ct_pan_duct_mass ct_pan_calci ct_pan_calci_place ct_pan_oth_abnormal ct_pan_oth_abn_spec"

local derived1 "ct_pan_vol"

local adjwt_uss "adj_wt_pan_head_ap adj_wt_pan_head_trans adj_wt_pan_body_trans adj_wt_pan_tail_trans"  

local adjsq_uss "adj_sqrt_pan_head_ap adj_sqrt_pan_head_trans adj_sqrt_pan_body_trans adj_sqrt_pan_tail_trans"  

local adjwt_ct "adj_wt_ct_pan_head_ap adj_wt_ct_pan_head_trans adj_wt_ct_pan_body_trans adj_wt_ct_pan_tail_trans adj_wt_ct_pan_body_tail adj_wt_ct_pan_vol"  

local adjsq_ct "adj_sqrt_ct_pan_head_ap adj_sqrt_ct_pan_head_trans adj_sqrt_ct_pan_body_trans adj_sqrt_ct_pan_tail_trans adj_sqrt_ct_pan_body_tail adj_sqrt_ct_pan_vol"  




/*local derived2 "adj_wt_ct_pan_head_trans adj_wt_ct_pan_head_ap adj_wt_ct_pan_body_trans adj_wt_ct_pan_tail_trans adj_wt_ct_pan_body_tail adj_wt_ct_pan_cc_body adj_wt_ct_pan_cc_head adj_sqrt_ct_pan_head_trans adj_sqrt_ct_pan_head_ap adj_sqrt_ct_pan_body_trans adj_sqrt_ct_pan_tail_trans adj_sqrt_ct_pan_body_tail adj_sqrt_ct_pan_cc_body adj_sqrt_ct_pan_cc_head adj_wt_pan_head_ap adj_wt_pan_head_trans adj_wt_pan_body_trans adj_wt_pan_tail_trans adj_sqrt_pan_head_ap adj_sqrt_pan_head_trans adj_sqrt_pan_body_trans adj_sqrt_pan_tail_trans"
*/


local derived3 "flag_fecal_elastase recruited assay_fecal_elastase assay_lipase assay_trypsinogen assay_amylase radio2 ct2 radio_mis_dims radio_mis_all radio3 subset subset2 epi_binary epi_ordinal child africa exposuretime fec_cohort"

local glucose "metformin insulin ogttr_confirm hba1c glu0 mmol_glu0 ogtt_time0 hba1c mmol_glu120 gluc_mean_mgdl insulin_mean_mul Matsuda_index insulinogenic_index rhba1c diab_hb_gl120" 

local enzymes "fecal_elastase lipase ngml_trypsinogen mgl_crp mgl_cystatin ul_amylp tryp_high tryp_low amyl_low "

local body "bia fm_kg fm_per ffm_kg ffm_per fmi ffmi impedance bia_prob bia_comment adp adpfm_kg adpffm_kg adpfm_per adpffm_per adp_prob adp_comment"

local organs "hepatomegaly splenomegaly cholelithiasis steatosis mass gynecologic atherosclerosis nephrolithiasis pancreatic"


keep `subj1' `subj2' `nutrition' `ses' `uss' `ct' `derived1' `adjwt_uss' `adjsq_uss' `adjwt_ct' `adjsq_ct' `derived3' `glucose' `enzymes' `body' `organs'

keep if subset==1
