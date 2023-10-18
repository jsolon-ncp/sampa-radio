version 13
clear

import delimited record_id redcap_data_access_group personnel timestamp languages cohort incorrect_cohort sampa_id orgid first middle last sex dob age confirm___1 confirm____97 confirm____98 confirm____99 confirm____100 confirm____101 confirm____102 confirm____103 confirm____104 confirm____105 confirm____106 confirm____107 confirm____108 gr_date1 tr_contact1 tr_method1 tr_reas_noc_phone1 tr_reas_other1 gr_date2 tr_contact2 tr_method2 tr_reas_noc_phone2 tr_reas_other2 gr_date3 tr_contact3 tr_method3 tr_reas_noc_phone3 tr_reas_other3 agree disagree_why cohort_tracing_complete personnel1 timestamp1 control cont_age cont_site cont_mald cont_hiv_test cont_art cont_art_yrs explain___1 rec_diab rec_diab_drug___0 rec_diab_drug___1 rec_diab_drug___2 rec_diab_drug___3 rec_diab_drug___4 rec_diab_drug____97 rec_diab_drug____98 rec_diab_drug____99 rec_diab_drug____100 rec_diab_drug____101 rec_diab_drug____102 rec_diab_drug____103 rec_diab_drug____104 rec_diab_drug____105 rec_diab_drug____106 rec_diab_drug____107 rec_diab_drug____108 insulin_dep flag_insulin consent_basic assent preg_test preg_result flag_preg indepth_sample indepth_exp flag_group mri_sample mri ct_sample ct xray_sample xray ivgtt_sample ivgtt uss_sample uss file_consent crf_1_eligibility_co_v_0 personnel13 timestamp13 radio_exam date_exam_uss time_exam_uss pan_size_head pan_size_body pan_size_tail pan_size_normal pan_size_ab_why pan_size_qual pan_head_trans pan_head_ap pan_body_trans pan_tail_trans pan_shape pan_shape_problem pan_shape_prob_specify pan_contour pan_contour_problem pan_contour_prob_specify pan_parenchyma parenchyma_ab_why pan_paren_inflam pan_paren_fibrosis pan_paren_steatosis pan_duct_normal pan_duct_ab pan_duct pan_duct_stones pan_duct_mass pan_peri_normal pan_peri_ab pan_calci pan_calci_yes pan_calci_place pan_cyst pan_cyst_yes pan_collect pan_collect_yes pan_fluid pan_fluid_yes pan_masses pan_masses_yes pan_others pan_con pan_oth_abnormal pan_oth_abn_specify image_qual_uss image_not_optimal image_non_why uss_problem uss_problem_specify name_radio sig_radio sig_uss_upload file_uss file_uss2 file_uss3 file_uss4 file_uss5 file_uss6 file_uss7 file_uss8 file_uss9 file_uss10 crf_13_abdomen_uss_complete personnel4 timestamp4 clinic_date_ogtt sample_gp standard_ogtt fasting ogtt_unit ogtt_time0 time0_w time0_x time0_y time0_z time0_a time0_b time0_c time0_e time0_f time0_g time0_h time0_j time0_k ogtt_sample_serum ogtt_sample_edta0 ogtt_sample_apro0 ogtt_sample_edta0_cold ogtt_comment_time0 hba1c glu0 mmol_glu0 out_glu0 glu0_missing glu0_mis_specify cpeptide0 insulin0 ogtt_time15 time15_z time15_a time15_b time15_c ogtt_sample_edta15 ogtt_comment_time15 glu15 mmol_glu15 out_glu15 glu15_missing glu15_mis_specify cpeptide15 insulin15 ogtt_time30 time30_z time30_a time30_b time30_c time30_e time30_f time30_g time30_h time30_j time30_k ogtt_sample_edta30 ogtt_sample_apro30 ogtt_sample_edta30_cold ogtt_comment_time30 glu30 mmol_glu30 out_glu30 glu30_missing glu30_mis_specify cpeptide30 insulin30 ogtt_time45 time45_z time45_a time45_b time45_c ogtt_sample_edta45 ogtt_comment_time45 glu45 mmol_glu45 out_glu45 glu45_missing glu45_mis_specify cpeptide45 insulin45 ogtt_time60 time60_z time60_a time60_b time60_c time60_e time60_f time60_g time60_h time60_j time60_k ogtt_sample_edta60 ogtt_sample_apro60 ogtt_sample_edta60_cold ogtt_comment_time60 glu60 mmol_glu60 out_glu60 glu60_missing glu60_mis_specify cpeptide60 insulin60 ogtt_time90 time90_z time90_a time90_b time90_c time90_e time90_f time90_g time90_h time90_j time90_k ogtt_sample_edta90 ogtt_sample_apro90 ogtt_sample_edta90_cold ogtt_comment_time90 glu90 mmol_glu90 out_glu90 glu90_missing glu90_mis_specify cpeptide90 insulin90 ogtt_time120 time120_z time120_a time120_b time120_c time120_e time120_f time120_g time120_h time120_j time120_k ogtt_sample_edta120 ogtt_sample_apro120 ogtt_sample_edta120_cold ogtt_comment_time120 glu120 mmol_glu120 out_glu120 glu120_missing glu120_mis_specify cpeptide120 insulin120 high_hba1c_1 high_glu120_1 repeat_test_needed repeat_date crf_4a_blood_samplin_v_1 personnel3 timestamp3 clinic_date_history pregnant preg_result1 suspect_hiv hiv art art_yrs art_type art_type_others diab diab_other diag_drug___0 diag_drug___1 diag_drug___2 diag_drug___3 diag_drug___4 diag_drug____97 diag_drug____98 diag_drug____99 diag_drug____100 diag_drug____101 diag_drug____102 diag_drug____103 diag_drug____104 diag_drug____105 diag_drug____106 diag_drug____107 diag_drug____108 diag_drug_others diag_yn diag_1 diag1_spec diag_2 diag2_spec diag_3 diag3_spec diag_4 diag4_spec lung_dis1 contissue_dis1 contissue_dis1_spec peptic_ulcer1 liver_dis1 kidney_dis1 cancer1 lung_dis2 contissue_dis2 contissue_dis2_spec peptic_ulcer2 liver_dis2 kidney_dis2 cancer2 lung_dis3 contissue_dis3 contissue_dis3_spec peptic_ulcer3 liver_dis3 kidney_dis3 cancer3 lung_dis4 contissue_dis4 contissue_dis4_spec peptic_ulcer4 liver_dis4 kidney_dis4 cancer4 hosp_freq hosp_diag hosp_diag_others med med_type___1 med_type___2 med_type___3 med_type___4 med_type___5 med_type____97 med_type____98 med_type____99 med_type____100 med_type____101 med_type____102 med_type____103 med_type____104 med_type____105 med_type____106 med_type____107 med_type____108 med_type_others thirst polyuria fatigue polydipsia blurred_vision numbness other_symptoms___1 other_symptoms___2 other_symptoms___3 other_symptoms___4 other_symptoms___5 other_symptoms___6 other_symptoms___7 other_symptoms___8 other_symptoms___9 other_symptoms___10 other_symptoms___11 other_symptoms___12 other_symptoms___13 other_symptoms___14 other_symptoms___15 other_symptoms___16 other_symptoms___17 other_symptoms___18 other_symptoms____97 other_symptoms____98 other_symptoms____99 other_symptoms____100 other_symptoms____101 other_symptoms____102 other_symptoms____103 other_symptoms____104 other_symptoms____105 other_symptoms____106 other_symptoms____107 other_symptoms____108 symptoms_others med_exam___1 med_exam___2 med_exam___3 med_exam___4 med_exam___5 med_exam___6 med_exam___7 med_exam___8 med_exam____97 med_exam____98 med_exam____99 med_exam____100 med_exam____101 med_exam____102 med_exam____103 med_exam____104 med_exam____105 med_exam____106 med_exam____107 med_exam____108 clin_summary exam_by sig_exam sig_exam_upload crf_3_clinical_histo_v_2 personnel10 timestamp10 clinic_date_referral refer_reason radiol_refer radiol_refer_others elastase_level fecal_fat elastase_refer refer refer_possible_diag___1 refer_possible_diag___2 refer_possible_diag___3 refer_possible_diag___4 refer_possible_diag___7 refer_possible_diag___8 refer_possible_diag___9 refer_possible_diag___10 refer_possible_diag___5 refer_possible_diag___6 refer_possible_diag____97 refer_possible_diag____98 refer_possible_diag____99 refer_possible_diag____100 refer_possible_diag____101 refer_possible_diag____102 refer_possible_diag____103 refer_possible_diag____104 refer_possible_diag____105 refer_possible_diag____106 refer_possible_diag____107 refer_possible_diag____108 refer_posdiag_o refer_mri refer_uss refer_diag___1 refer_diag___2 refer_diag___3 refer_diag___4 refer_diag___7 refer_diag___8 refer_diag___9 refer_diag___10 refer_diag___5 refer_diag___6 refer_diag____97 refer_diag____98 refer_diag____99 refer_diag____100 refer_diag____101 refer_diag____102 refer_diag____103 refer_diag____104 refer_diag____105 refer_diag____106 refer_diag____107 refer_diag____108 refer_diag_others refer_place1 refer_place2 refer_place3 refer_place4 refer_place7 refer_place8 refer_place9 refer_place10 refer_place5 refer_place6 crf_10_referral_complete personnel2 timestamp2 clinic_date_demo marital education edu_father edu_mother edu_child employ employ_father employ_mother num_reside dwelltype dwelltype_o tenurhws tenurhws_o house house_o rooms cook cook_o fuel fuel_o electric electric_o water water_o toilet toilet_o vcd tv ref wmachine computer stove radio phone cellphone efan ac sewing cow pig goat poultry_own bike motorcycle car boat tractor table chair crf_2_demography_and_v_3 personnel12 timestamp12 clinic_date_diet citrus berries bananas apples pineapples mango melon dry_fruit fruit_oth tomato pepper orange_veg green_leafy cruciferous gourd veg_oth legumes nuts_seeds red_meat poultry processed_meat organ_meat fish seafood eggs milk milk_tea yogurt yogurt_sweet yogurt_drink cheese icecream dairy_oth fruit_juice soda alcohol fries fried_meat crisps crackers samosas pizza_burger savoury_oth cake cookies pudding candy street_food fast_food alcohol_amt crf_12_diet_complete personnel6 timestamp6 clinic_date_anthro systolic1 systolic2 systolic3 diastolic1 diastolic2 diastolic3 weight1 weight2 weight3 weight_unit height1 height2 height3 stand_unit sit_ht1 sit_ht2 sit_ht3 sit_unit sit_box sit_box_unit tibia1 tibia2 tibia3 tibia_unit grip_dominanthand grip_measured_r1 grip_measured_r2 grip_measured_r3 grip_unit_r grip_measured_l1 grip_measured_l2 grip_measured_l3 grip_unit_l muac1 muac2 muac3 muac_unit waist1 waist2 waist3 waist_unit hip1 hip2 hip3 hip_unit triceps1 triceps2 triceps3 triceps_unit subscap1 subscap2 subscap3 subscap_unit anthro_prob menstruate menst_month tanner tanner_method crf_6_anthropometry_complete personnel7 timestamp7 clinic_date_body bia fm_kg ffm_kg fm_per ffm_per impedance bia_prob bia_comment adp adpfm_kg adpffm_kg adpfm_per adpffm_per adp_prob adp_comment crf_7_body_compositi_v_4 personnel11 timestamp11 clinic_date_urine_feces urine urine_collect_dt urine_time urine_ali_q urine_ali_r feces flag_feces feces_collect_dt feces_time feces_ali_s feces_ali_t feces_ali_u feces_temp feces_date feces_mode crf_11a_urine_and_fe_v_5 personnel111 timestamp111 u_collect u_leucs u_gluc u_ketone u_prot u_nitrite u_blood urine_problem feces_collect fecal_elastase feces_problem crf_11b_urine_and_fe_v_6 personnel41 timestamp41 ogttr_confirm rogtt_unit ogttr_time0 ogttr_time0_1 ogttr_sample_edta ogttr_comments_time0 rglu0 rglu0_missing rglu0_mis_specify rhba1c ogttr_time30 ogttr_time30_1 ogttr_sample_edta30 ogttr_comments_time30 rglu30 rglu30_missing rglu30_mis_specify ogttr_time120 ogttr_time120_1 ogttr_sample_edta120 ogttr_comments_time120 rglu120 rglu120_missing rglu120_mis_specify mmol_rglu120 high_glu120_2 dia_referral glu_comment crf_4b_repeat_ogtt_complete personnel51 timestamp51 total_cho total_cho_prob total_cho_prob_spec ldl_cho ldl_cho_prob ldl_cho_prob_spec hdl_cho hdl_cho_prob hdl_cho_prob_spec trig trig_prob trig_prob_spec lipid_unit hgb hgb_prob hgb_prob_spec rbc rbc_prob rbc_prob_spec wbc wbc_prob wbc_prob_spec platelet platelet_prob platelet_prob_spec lipase lipase_prob lipase_prob_spec crp crp_prob crp_prob_spec crf_5_more_blood_tes_v_7 personnel14 timestamp14 ct_scan ct_date ct_time ct_pan_size_qual ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head ct_pan_shape ct_pan_shape_problem ct_pan_shape_prob_spec ct_pan_contour ct_pan_contour_problem ct_pan_contour_prob_spec ct_pan_parenchyma ct_pan_paren_inflam ct_pan_paren_fibrosis ct_pan_paren_steatosis ct_pan_duct ct_pan_duct_stones ct_pan_duct_mass ct_pan_calci ct_pan_calci_place ct_pan_oth_abnormal ct_pan_oth_abn_spec ct_image_qual ct_problem ct_problem_why name_ct sig_ct sig_ct_upload file_ct file_ct2 file_ct3 file_ct4 file_ct5 file_ct6 file_ct7 file_ct8 file_ct9 file_ct10 crf_14_computed_tomo_v_8 personnel15 timestamp15 ivgtt_time_ne10 ivgtt_time_ne1 ivgtt_time_2 ivgtt_time_4 ivgtt_time_6 ivgtt_time_8 ivgtt_time_10 ivgtt_ne10 ivgtt_ne1 ivgtt_2 ivgtt_4 ivgtt_6 ivgtt_8 ivgtt_10 ivtime_ne10_l ivtime_ne10_m ivtime_ne10_n ivtime_ne10_p ivtime_ne1_l ivtime_ne1_m ivtime_ne1_n ivtime_ne1_p ivtime_2_l ivtime_2_m ivtime_2_n ivtime_2_p ivtime_4_l ivtime_4_m ivtime_4_n ivtime_4_p ivtime_6_l ivtime_6_m ivtime_6_n ivtime_6_p ivtime_8_l ivtime_8_m ivtime_8_n ivtime_8_p ivtime_10_l ivtime_10_m ivtime_10_n ivtime_10_p ivgtt_complete using "/Users/sharoncox/Downloads/SAMPA_DATA_NOHDRS_2023-10-16_0707.csv", varnames(nonames)

label data "SAMPA_DATA_NOHDRS_2023-09-08_0243.csv"


label define languages_ 1 "English" 2 "Swahili" 3 "Cebuano" 4 "Hiligaynon" 
label define cohort_ 1 "DIVIDS" 2 "SAM Lusaka" 3 "CICADA" 4 "NUSTART Lusaka" 5 "St-ATT" 6 "CLHNS" 
label define sex_ 1 "Male" 2 "Female" 
label define confirm___1_ 0 "Unchecked" 1 "Checked" 
label define confirm____97_ 0 "Unchecked" 1 "Checked" 
label define confirm____98_ 0 "Unchecked" 1 "Checked" 
label define confirm____99_ 0 "Unchecked" 1 "Checked" 
label define confirm____100_ 0 "Unchecked" 1 "Checked" 
label define confirm____101_ 0 "Unchecked" 1 "Checked" 
label define confirm____102_ 0 "Unchecked" 1 "Checked" 
label define confirm____103_ 0 "Unchecked" 1 "Checked" 
label define confirm____104_ 0 "Unchecked" 1 "Checked" 
label define confirm____105_ 0 "Unchecked" 1 "Checked" 
label define confirm____106_ 0 "Unchecked" 1 "Checked" 
label define confirm____107_ 0 "Unchecked" 1 "Checked" 
label define confirm____108_ 0 "Unchecked" 1 "Checked" 
label define tr_contact1_ 0 "No" 1 "Yes" 
label define tr_method1_ 1 "cellphone" 2 "telephone" 3 "email" 4 "home visit" 
label define tr_reas_noc_phone1_ 1 "wrong phone number" 2 "incorrect email" 3 "address changed" 4 "Others {tr_reas_other1}" 
label define tr_contact2_ 0 "No" 1 "Yes" 
label define tr_method2_ 1 "cellphone" 2 "telephone" 3 "email" 4 "home visit" 
label define tr_reas_noc_phone2_ 1 "wrong phone number" 2 "incorrect email" 3 "address changed" 4 "Others  {tr_reas_other2}" 
label define tr_contact3_ 0 "No" 1 "Yes" 
label define tr_method3_ 1 "cellphone" 2 "telephone" 3 "email" 4 "home visit" 
label define tr_reas_noc_phone3_ 1 "wrong phone number" 2 "incorrect email" 3 "address changed" 4 "Others  {tr_reas_other3}" 
label define agree_ 0 "No, they do not agree" 1 "Yes, they agree" 2 "Unable to contact participant" 3 "Undecided" 4 "participant is deceased" 
label define cohort_tracing_complete_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define control_ 0 "No" 1 "Yes" 
label define cont_age_ 0 "No" 1 "Yes" 
label define cont_site_ 1 "From a local ART clinic" 2 "Neighbour" 3 "Sibling" 4 "Other" 
label define cont_mald_ 0 "No" 1 "Yes" 
label define cont_hiv_test_ 1 "Known HIV-infected from ART clinic" 2 "Willing to test for HIV and is positive" 3 "Willing to test for HIV and is negative" 4 "Refuses HIV test" 
label define cont_art_ 1 "Not HIV-infected" 2 "Yes" 3 "HIV-infected but not on ART" 
label define explain___1_ 0 "Unchecked" 1 "Checked" 
label define rec_diab_ 0 "No" 1 "Yes, uncomplicated" 2 "Yes with complications, e.g. blindness, peripheral neuropathy, amputation" 
label define rec_diab_drug___0_ 0 "Unchecked" 1 "Checked" 
label define rec_diab_drug___1_ 0 "Unchecked" 1 "Checked" 
label define rec_diab_drug___2_ 0 "Unchecked" 1 "Checked" 
label define rec_diab_drug___3_ 0 "Unchecked" 1 "Checked" 
label define rec_diab_drug___4_ 0 "Unchecked" 1 "Checked" 
label define rec_diab_drug____97_ 0 "Unchecked" 1 "Checked" 
label define rec_diab_drug____98_ 0 "Unchecked" 1 "Checked" 
label define rec_diab_drug____99_ 0 "Unchecked" 1 "Checked" 
label define rec_diab_drug____100_ 0 "Unchecked" 1 "Checked" 
label define rec_diab_drug____101_ 0 "Unchecked" 1 "Checked" 
label define rec_diab_drug____102_ 0 "Unchecked" 1 "Checked" 
label define rec_diab_drug____103_ 0 "Unchecked" 1 "Checked" 
label define rec_diab_drug____104_ 0 "Unchecked" 1 "Checked" 
label define rec_diab_drug____105_ 0 "Unchecked" 1 "Checked" 
label define rec_diab_drug____106_ 0 "Unchecked" 1 "Checked" 
label define rec_diab_drug____107_ 0 "Unchecked" 1 "Checked" 
label define rec_diab_drug____108_ 0 "Unchecked" 1 "Checked" 
label define insulin_dep_ 0 "No" 1 "Yes" 
label define consent_basic_ 1 "Consents to standard OGTT" 2 "Consents to basic OGTT" 3 "Does not consent to either of the above" 
label define assent_ 0 "No" 1 "Yes" 
label define preg_test_ 1 "No, is male" 2 "No, is female, and says they are post-menopausal" 3 "No, since they already know they are pregnant" 4 "Yes, will agree to test {preg_result}" 5 "No, will not agree to test" 
label define preg_result_ 1 "has documented negative pregnancy test performed by SAMPA" 2 "has documented positive pregnancy test performed by SAMPA" 
label define indepth_sample_ 0 "No" 1 "Yes" 
label define indepth_exp_ 0 "No" 1 "Yes" 
label define mri_sample_ 0 "No" 1 "Yes" 
label define mri_ 0 "No" 1 "Yes" 2 "Not randomized to MRI" 
label define ct_sample_ 0 "No" 1 "Yes" 
label define ct_ 0 "No" 1 "Yes" 2 "Not randomized to CT scan" 
label define xray_sample_ 0 "No" 1 "Yes" 
label define xray_ 0 "No" 1 "Yes" 2 "Not randomized to X-ray" 
label define ivgtt_sample_ 0 "No" 1 "Yes" 
label define ivgtt_ 0 "No" 1 "Yes" 2 "Not randomized to ivgtt" 
label define uss_sample_ 0 "No" 1 "Yes" 
label define uss_ 0 "No" 1 "Yes" 2 "Not randomized to Ultrasound" 
label define crf_1_eligibility_co_v_0_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define radio_exam_ 0 "No" 1 "Yes" -98 "Refused" -100 "Pending" -102 "Absconded" -103 "Equipment NA" 
label define pan_size_normal_ 1 "Normal" 2 "Abnormal {pan_size_ab_why:icons}" 
label define pan_size_qual_ 1 "Normal" 2 "Small" 3 "Enlarged" 4 "Cant see well enough to tell" 
label define pan_shape_ 1 "Normal" 2 "Abnormal" 3 "Cant see well enough to tell" 
label define pan_shape_problem_ 1 "Imbalance in size of head compared to tail" 2 "Other shape abnormality, specify {pan_shape_prob_specify}" 
label define pan_contour_ 1 "Normal/Smooth" 2 "Abnormal" 3 "Cant see well enough to tell" 
label define pan_contour_problem_ 1 "Irregular border" 2 "Lobulated" 3 "Other contour problem, specify {pan_contour_prob_specify}" 
label define pan_parenchyma_ 1 "Normal" 2 "Abnormal" 3 "Cant see well enough to tell" 
label define pan_paren_inflam_ 0 "No" 1 "Yes" 
label define pan_paren_fibrosis_ 0 "No" 1 "Yes" 
label define pan_paren_steatosis_ 0 "No" 1 "Yes" 
label define pan_duct_normal_ 1 "Normal" 2 "Abnormal {pan_duct_ab:icons}" 
label define pan_duct_ 1 "Normal" 2 "Abnormal" 3 "Cant see well enough to tell" 
label define pan_duct_stones_ 0 "No" 1 "Yes" 
label define pan_duct_mass_ 0 "No" 1 "Yes" 
label define pan_peri_normal_ 1 "Normal" 2 "Abnormal {pan_peri_ab:icons}" 
label define pan_calci_ 0 "Absent" 1 "Present" 3 "Cant see well enough to tell" 
label define pan_calci_place_ 1 "Parenchymal" 2 "Peripancreatic" 
label define pan_cyst_ 0 "No" 1 "Yes {pan_cyst_yes:icons}" 
label define pan_collect_ 0 "No" 1 "Yes {pan_collect_yes:icons}" 
label define pan_fluid_ 0 "No" 1 "Yes {pan_fluid_yes:icons}" 
label define pan_masses_ 0 "No" 1 "Yes {pan_masses_yes:icons}" 
label define pan_oth_abnormal_ 0 "No" 1 "Yes, specify {pan_oth_abn_specify}" 
label define image_qual_uss_ 1 "Optimal" 2 "Non-optimal" 
label define image_not_optimal_ 1 "Bowel gas" 2 "Obese participant" 3 "Participant uncooperative, e.g. could not stay still" 4 "Others, specify {image_non_why}" 
label define uss_problem_ 0 "No" 1 "Yes" 
label define crf_13_abdomen_uss_complete_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define sample_gp_ 1 "Adults agreeing to Standard OGTT but not in in-depth subsample" 2 "SAM Lusaka, DIVIDS, adults who want only 3-time point OGTT" 3 "OGTT for adults in CICADA or St-ATT who agree and are part of the in-depth subset" 
label define standard_ogtt_ 1 "7 timepoint OGTT" 2 "5 timepoint OGTT" 
label define fasting_ 1 "Nothing or only water" 2 "Has had other drinks than water, e.g. tea, coffee, juice" 3 "Has had a meal or snack" 
label define ogtt_unit_ 2 "mg/dL" 1 "mmol/L" 
label define ogtt_sample_serum_ 0 "No" 1 "Yes" 
label define ogtt_sample_edta0_ 0 "No" 1 "Yes" 
label define ogtt_sample_apro0_ 0 "No" 1 "Yes" 
label define ogtt_sample_edta0_cold_ 0 "No" 1 "Yes" 
label define glu0_missing_ 0 "No" -104 "glucose less than min" -105 "glucose greater than max" 9 "Others, specify {glu0_mis_specify}" 
label define ogtt_sample_edta15_ 0 "No" 1 "Yes" 
label define glu15_missing_ 0 "No" -104 "glucose less than min" -105 "glucose greater than max" 9 "Others, specify {glu15_mis_specify}" 
label define ogtt_sample_edta30_ 0 "No" 1 "Yes" 
label define ogtt_sample_apro30_ 0 "No" 1 "Yes" 
label define ogtt_sample_edta30_cold_ 0 "No" 1 "Yes" 
label define glu30_missing_ 0 "No" -104 "glucose less than min" -105 "glucose greater than max" 9 "Others, specify {glu30_mis_specify}" 
label define ogtt_sample_edta45_ 0 "No" 1 "Yes" 
label define glu45_missing_ 0 "No" -104 "glucose less than min" -105 "glucose greater than max" 9 "Others, specify {glu45_mis_specify}" 
label define ogtt_sample_edta60_ 0 "No" 1 "Yes" 
label define ogtt_sample_apro60_ 0 "No" 1 "Yes" 
label define ogtt_sample_edta60_cold_ 0 "No" 1 "Yes" 
label define glu60_missing_ 0 "No" -104 "glucose less than min" -105 "glucose greater than max" 9 "Others, specify {glu60_mis_specify}" 
label define ogtt_sample_edta90_ 0 "No" 1 "Yes" 
label define ogtt_sample_apro90_ 0 "No" 1 "Yes" 
label define ogtt_sample_edta90_cold_ 0 "No" 1 "Yes" 
label define glu90_missing_ 0 "No" -104 "glucose less than min" -105 "glucose greater than max" 9 "Others, specify {glu90_mis_specify}" 
label define ogtt_sample_edta120_ 0 "No" 1 "Yes" 
label define ogtt_sample_apro120_ 0 "No" 1 "Yes" 
label define ogtt_sample_edta120_cold_ 0 "No" 1 "Yes" 
label define glu120_missing_ 0 "No" -104 "glucose less than min" -105 "glucose greater than max" 9 "Others, specify {glu120_mis_specify}" 
label define repeat_test_needed_ 0 "No" 1 "Yes" 2 "Repeat OGTT not needed, has diabetes" -100 "Pending" -102 "Absconded" -103 "Equipment NA" 
label define crf_4a_blood_samplin_v_1_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define pregnant_ 1 "male" 2 "female, >50 years and says they are post-menopausal" 3 "they know they are pregnant" 4 "Yes agree to test" 5 "Did not agree to pregnancy test" 102 "Absconded" 
label define preg_result1_ 1 "has documented negative pregnancy test performed by SAMPA" 2 "has documented positive pregnancy test performed by SAMPA" 
label define suspect_hiv_ 0 "No" 1 "Yes" 
label define hiv_ 0 "No" 1 "Yes" -97 "Dont know" -98 "Refused" -100 "Pending" 
label define art_ 0 "No" 1 "Yes" -97 "Dont know" 
label define art_type_ 1 "Tenofovir-based" 2 "AZT (zidovudine)-based" 3 "abacavir-based" 4 "dolutegravir-based" 5 "Others {art_type_others:icons}" -97 "Dont know" 
label define diab_ 0 "No" 1 "Yes, uncomplicated" 2 "Yes with complications, e.g. blindness, peripheral neuropathy, amputation" 
label define diag_drug___0_ 0 "Unchecked" 1 "Checked" 
label define diag_drug___1_ 0 "Unchecked" 1 "Checked" 
label define diag_drug___2_ 0 "Unchecked" 1 "Checked" 
label define diag_drug___3_ 0 "Unchecked" 1 "Checked" 
label define diag_drug___4_ 0 "Unchecked" 1 "Checked" 
label define diag_drug____97_ 0 "Unchecked" 1 "Checked" 
label define diag_drug____98_ 0 "Unchecked" 1 "Checked" 
label define diag_drug____99_ 0 "Unchecked" 1 "Checked" 
label define diag_drug____100_ 0 "Unchecked" 1 "Checked" 
label define diag_drug____101_ 0 "Unchecked" 1 "Checked" 
label define diag_drug____102_ 0 "Unchecked" 1 "Checked" 
label define diag_drug____103_ 0 "Unchecked" 1 "Checked" 
label define diag_drug____104_ 0 "Unchecked" 1 "Checked" 
label define diag_drug____105_ 0 "Unchecked" 1 "Checked" 
label define diag_drug____106_ 0 "Unchecked" 1 "Checked" 
label define diag_drug____107_ 0 "Unchecked" 1 "Checked" 
label define diag_drug____108_ 0 "Unchecked" 1 "Checked" 
label define diag_yn_ 0 "No" 1 "Yes" -97 "Dont know" -98 "Refused" 
label define diag_1_ 1 "Myocardial infarction, heart attack" 2 "Heart failure" 3 "Peripheral vascular disease" 4 "Stroke, TIA" 5 "Lung disease {lung_dis1:icons}" 6 "Connective tissue disease {contissue_dis1:icons}" 7 "Peptic ulcer {peptic_ulcer1:icons}" 8 "Liver disease {liver_dis1:icons}" 9 "Chronic kidney disease {kidney_dis1:icons}" 10 "Cancer {cancer1:icons}" 11 "hypertension" 12 "Others, specify {diag1_spec:icons}" 13 "None" 
label define diag_2_ 1 "Myocardial infarction, heart attack" 2 "Heart failure" 3 "Peripheral vascular disease" 4 "Stroke, TIA" 5 "Lung disease {lung_dis2:icons}" 6 "Connective tissue disease {contissue_dis2:icons}" 7 "Peptic ulcer {peptic_ulcer2:icons}" 8 "Liver disease {liver_dis2:icons}" 9 "Chronic kidney disease {kidney_dis2:icons}" 10 "Cancer {cancer2:icons}" 11 "hypertension" 12 "Others, specify {diag2_spec:icons}" 13 "None" 
label define diag_3_ 1 "Myocardial infarction, heart attack" 2 "Heart failure" 3 "Peripheral vascular disease" 4 "Stroke, TIA" 5 "Lung disease {lung_dis3:icons}" 6 "Connective tissue disease {contissue_dis3:icons}" 7 "Peptic ulcer {peptic_ulcer3:icons}" 8 "Liver disease {liver_dis3:icons}" 9 "Chronic kidney disease {kidney_dis3:icons}" 10 "Cancer {cancer3:icons}" 11 "hypertension" 12 "Others, specify {diag3_spec:icons}" 13 "None" 
label define diag_4_ 1 "Myocardial infarction, heart attack" 2 "Heart failure" 3 "Peripheral vascular disease" 4 "Stroke, TIA" 5 "Lung disease {lung_dis4:icons}" 6 "Connective tissue disease {contissue_dis4:icons}" 7 "Peptic ulcer {peptic_ulcer4:icons}" 8 "Liver disease {liver_dis4:icons}" 9 "Chronic kidney disease {kidney_dis4:icons}" 10 "Cancer {cancer4:icons}" 11 "hypertension" 12 "Others, specify {diag4_spec:icons}" 13 "None" 
label define lung_dis1_ 1 "COPD" 2 "asthma" 3 "Tuberculosis" 
label define contissue_dis1_ 1 "lupus" 2 "fibromyalgia" 3 "rheumatoid disease" 4 "others  {contissue_dis1_spec:icons}" 
label define peptic_ulcer1_ 1 "history of treatment for ulcer disease" 2 "history of ulcer bleeding" 3 "ulcer confirmed by endoscopy" 
label define liver_dis1_ 1 "mild" 2 "moderate" 3 "severe" 4 "schistosomiasis with varices" 
label define kidney_dis1_ 1 "yes but no dialysis" 2 "dialysis" 3 "kidney transplant" 
label define cancer1_ 1 "solid tumour" 2 "metastatic" 3 "blood cancer" 
label define lung_dis2_ 1 "COPD" 2 "asthma" 3 "Tuberculosis" 
label define contissue_dis2_ 1 "lupus" 2 "fibromyalgia" 3 "rheumatoid disease" 4 "others  {contissue_dis2_spec:icons}" 
label define peptic_ulcer2_ 1 "history of treatment for ulcer disease" 2 "history of ulcer bleeding" 3 "ulcer confirmed by endoscopy" 
label define liver_dis2_ 1 "mild" 2 "moderate" 3 "severe" 4 "schistosomiasis with varices" 
label define kidney_dis2_ 1 "yes but no dialysis" 2 "dialysis" 3 "kidney transplant" 
label define cancer2_ 1 "solid tumour" 2 "metastatic" 3 "blood cancer" 
label define lung_dis3_ 1 "COPD" 2 "asthma" 3 "Tuberculosis" 
label define contissue_dis3_ 1 "lupus" 2 "fibromyalgia" 3 "rheumatoid disease" 4 "others  {contissue_dis3_spec:icons}" 
label define peptic_ulcer3_ 1 "history of treatment for ulcer disease" 2 "history of ulcer bleeding" 3 "ulcer confirmed by endoscopy" 
label define liver_dis3_ 1 "mild" 2 "moderate" 3 "severe" 4 "schistosomiasis with varices" 
label define kidney_dis3_ 1 "yes but no dialysis" 2 "dialysis" 3 "kidney transplant" 
label define cancer3_ 1 "solid tumour" 2 "metastatic" 3 "blood cancer" 
label define lung_dis4_ 1 "COPD" 2 "asthma" 3 "Tuberculosis" 
label define contissue_dis4_ 1 "lupus" 2 "fibromyalgia" 3 "rheumatoid disease" 4 "others  {contissue_dis4_spec:icons}" 
label define peptic_ulcer4_ 1 "history of treatment for ulcer disease" 2 "history of ulcer bleeding" 3 "ulcer confirmed by endoscopy" 
label define liver_dis4_ 1 "mild" 2 "moderate" 3 "severe" 4 "schistosomiasis with varices" 
label define kidney_dis4_ 1 "yes but no dialysis" 2 "dialysis" 3 "kidney transplant" 
label define cancer4_ 1 "solid tumour" 2 "metastatic" 3 "blood cancer" 
label define hosp_diag_ 1 "HIV" 2 "Tuberculosis (TB)" 3 "Hypertension" 4 "Asthma" 5 "Diabetes" 6 "Heart disease" 7 "Kidney disease" 8 "Cancer" 9 "Eye disease" 10 "Helminth/schistosomiasis" 11 "Malaria" 12 "Respiratory infections" 13 "Fungal infections" 14 "Dont know" 15 "Others {hosp_diag_others:icons}" -97 "Dont know" -98 "Refused" 
label define med_ 0 "No" 1 "Yes" -97 "Dont know" -98 "Refused" 
label define med_type___1_ 0 "Unchecked" 1 "Checked" 
label define med_type___2_ 0 "Unchecked" 1 "Checked" 
label define med_type___3_ 0 "Unchecked" 1 "Checked" 
label define med_type___4_ 0 "Unchecked" 1 "Checked" 
label define med_type___5_ 0 "Unchecked" 1 "Checked" 
label define med_type____97_ 0 "Unchecked" 1 "Checked" 
label define med_type____98_ 0 "Unchecked" 1 "Checked" 
label define med_type____99_ 0 "Unchecked" 1 "Checked" 
label define med_type____100_ 0 "Unchecked" 1 "Checked" 
label define med_type____101_ 0 "Unchecked" 1 "Checked" 
label define med_type____102_ 0 "Unchecked" 1 "Checked" 
label define med_type____103_ 0 "Unchecked" 1 "Checked" 
label define med_type____104_ 0 "Unchecked" 1 "Checked" 
label define med_type____105_ 0 "Unchecked" 1 "Checked" 
label define med_type____106_ 0 "Unchecked" 1 "Checked" 
label define med_type____107_ 0 "Unchecked" 1 "Checked" 
label define med_type____108_ 0 "Unchecked" 1 "Checked" 
label define thirst_ 0 "No" 1 "Yes" 
label define polyuria_ 0 "No" 1 "Yes" 
label define fatigue_ 0 "No" 1 "Yes" 
label define polydipsia_ 0 "No" 1 "Yes" 
label define blurred_vision_ 0 "No" 1 "Yes" 
label define numbness_ 0 "No" 1 "Yes" 
label define other_symptoms___1_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms___2_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms___3_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms___4_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms___5_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms___6_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms___7_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms___8_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms___9_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms___10_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms___11_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms___12_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms___13_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms___14_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms___15_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms___16_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms___17_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms___18_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms____97_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms____98_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms____99_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms____100_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms____101_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms____102_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms____103_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms____104_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms____105_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms____106_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms____107_ 0 "Unchecked" 1 "Checked" 
label define other_symptoms____108_ 0 "Unchecked" 1 "Checked" 
label define med_exam___1_ 0 "Unchecked" 1 "Checked" 
label define med_exam___2_ 0 "Unchecked" 1 "Checked" 
label define med_exam___3_ 0 "Unchecked" 1 "Checked" 
label define med_exam___4_ 0 "Unchecked" 1 "Checked" 
label define med_exam___5_ 0 "Unchecked" 1 "Checked" 
label define med_exam___6_ 0 "Unchecked" 1 "Checked" 
label define med_exam___7_ 0 "Unchecked" 1 "Checked" 
label define med_exam___8_ 0 "Unchecked" 1 "Checked" 
label define med_exam____97_ 0 "Unchecked" 1 "Checked" 
label define med_exam____98_ 0 "Unchecked" 1 "Checked" 
label define med_exam____99_ 0 "Unchecked" 1 "Checked" 
label define med_exam____100_ 0 "Unchecked" 1 "Checked" 
label define med_exam____101_ 0 "Unchecked" 1 "Checked" 
label define med_exam____102_ 0 "Unchecked" 1 "Checked" 
label define med_exam____103_ 0 "Unchecked" 1 "Checked" 
label define med_exam____104_ 0 "Unchecked" 1 "Checked" 
label define med_exam____105_ 0 "Unchecked" 1 "Checked" 
label define med_exam____106_ 0 "Unchecked" 1 "Checked" 
label define med_exam____107_ 0 "Unchecked" 1 "Checked" 
label define med_exam____108_ 0 "Unchecked" 1 "Checked" 
label define clin_summary_ 1 "Generally well" 2 "Minor, self-limiting complaints not requiring treatment" 3 "Minor complaints requiring over-the-counter treatments, e.g. painkillers" 4 "Moderate conditions requiring referral to local services for further care" 5 "Serious conditions requiring specialist care" 
label define crf_3_clinical_histo_v_2_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define refer_reason_ 1 "Findings from main clinic visit" 2 "Diagnosed with diabetes or pre-diabetes on both 1st and 2nd OGTT" 3 "Abnormalities seen on ultrasound or CT scan" 4 "Low fecal elastase" 
label define radiol_refer_ 1 "Diabetes care" 2 "Gastroenterology" 3 "Liver specialist" 4 "Oncology" 5 "Kidney specialist" 6 "Others {radiol_refer_others}" 
label define elastase_level_ 1 "Low" 2 "Very low" 
label define fecal_fat_ 0 "No" 1 "Yes" 
label define elastase_refer_ 0 "No" 1 "Yes" 
label define refer_ 0 "No" 1 "Yes" 
label define refer_possible_diag___1_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag___2_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag___3_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag___4_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag___7_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag___8_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag___9_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag___10_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag___5_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag___6_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag____97_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag____98_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag____99_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag____100_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag____101_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag____102_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag____103_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag____104_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag____105_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag____106_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag____107_ 0 "Unchecked" 1 "Checked" 
label define refer_possible_diag____108_ 0 "Unchecked" 1 "Checked" 
label define refer_mri_ 0 "No" 1 "Yes" 
label define refer_uss_ 0 "No" 1 "Yes" 
label define refer_diag___1_ 0 "Unchecked" 1 "Checked" 
label define refer_diag___2_ 0 "Unchecked" 1 "Checked" 
label define refer_diag___3_ 0 "Unchecked" 1 "Checked" 
label define refer_diag___4_ 0 "Unchecked" 1 "Checked" 
label define refer_diag___7_ 0 "Unchecked" 1 "Checked" 
label define refer_diag___8_ 0 "Unchecked" 1 "Checked" 
label define refer_diag___9_ 0 "Unchecked" 1 "Checked" 
label define refer_diag___10_ 0 "Unchecked" 1 "Checked" 
label define refer_diag___5_ 0 "Unchecked" 1 "Checked" 
label define refer_diag___6_ 0 "Unchecked" 1 "Checked" 
label define refer_diag____97_ 0 "Unchecked" 1 "Checked" 
label define refer_diag____98_ 0 "Unchecked" 1 "Checked" 
label define refer_diag____99_ 0 "Unchecked" 1 "Checked" 
label define refer_diag____100_ 0 "Unchecked" 1 "Checked" 
label define refer_diag____101_ 0 "Unchecked" 1 "Checked" 
label define refer_diag____102_ 0 "Unchecked" 1 "Checked" 
label define refer_diag____103_ 0 "Unchecked" 1 "Checked" 
label define refer_diag____104_ 0 "Unchecked" 1 "Checked" 
label define refer_diag____105_ 0 "Unchecked" 1 "Checked" 
label define refer_diag____106_ 0 "Unchecked" 1 "Checked" 
label define refer_diag____107_ 0 "Unchecked" 1 "Checked" 
label define refer_diag____108_ 0 "Unchecked" 1 "Checked" 
label define crf_10_referral_complete_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define marital_ 1 "Married/cohabiting" 2 "Single/Never married" 3 "Divorced/Annulled/Separated" 4 "Widow/widower" 
label define education_ 1 "No education/kindergarten" 2 "Some primary" 3 "Completed primary (with or without some secondary)" 4 "Completed (ordinary) secondary" 5 "Completed advance secondary (Tanzania only)" 6 "Post-secondary vocational or other non-university education" 7 "Completed university" 
label define edu_father_ 1 "No education/kindergarten" 2 "Some primary" 3 "Completed primary (with or without some secondary)" 4 "Completed (ordinary) secondary" 5 "Completed advance secondary (Tanzania only)" 6 "Post-secondary vocational or other non-university education" 7 "Completed university" -97 "Dont know" 
label define edu_mother_ 1 "No education/kindergarten" 2 "Some primary" 3 "Completed primary (with or without some secondary)" 4 "Completed (ordinary) secondary" 5 "Completed advance secondary (Tanzania only)" 6 "Post-secondary vocational or other non-university education" 7 "Completed university" -97 "Dont know" 
label define edu_child_ 1 "Government school" 2 "Fee-paying school" 3 "Not in school" 
label define employ_ 1 "Professional (eg. teacher/doctor/engineer)" 2 "Salaried office other than professional" 3 "Self-employed or owns small business (eg.shop/store owner, carpenter, online reselling)" 4 "Salaried manual work, e.g. farm work, fishing, construction, domestic worker (fulltime)" 5 "Casual labour, i.e. daily wager (farming, fishing, petty trading, domestic worker (part time)" 6 "Household work [eg. housewife/husband, caring for family members]" 7 "Retired" 8 "Unemployed [looking for a job]" 
label define employ_father_ 1 "Professional (eg. teacher/doctor/engineer)" 2 "Salaried office other than professional" 3 "Self-employed or owns small business (eg.shop/store owner, carpenter, online reselling)" 4 "Salaried manual work, e.g. farm work, fishing, construction, domestic worker (fulltime)" 5 "Casual labour, i.e. daily wager (farming, fishing, petty trading, domestic worker (part time)" 6 "Household work [eg. housewife/husband, caring for family members]" 7 "Retired" 8 "Unemployed [looking for a job]" -97 "Dont know" 
label define employ_mother_ 1 "Professional (eg. teacher/doctor/engineer)" 2 "Salaried office other than professional" 3 "Self-employed or owns small business (eg.shop/store owner, carpenter, online reselling)" 4 "Salaried manual work, e.g. farm work, fishing, construction, domestic worker (fulltime)" 5 "Casual labour, i.e. daily wager (farming, fishing, petty trading, domestic worker (part time)" 6 "Household work [eg. housewife/husband, caring for family members]" 7 "Retired" 8 "Unemployed [looking for a job]" -97 "Dont know" 
label define dwelltype_ 1 "Single house" 2 "Apartment /Condo/Tenement" 3 "Makeshift/Barong-barong" 4 "Others, Specify: {dwelltype_o:icons}" 
label define tenurhws_ 1 "Own" 2 "Rent" 3 "Free (caretaker, owned by parents/relatives)" 4 "Squat (settle in public/private dwelling units" 5 "Others, Specify:{tenurhws_o:icons}" 
label define house_ 1 "High quality material throughout including roof, walls and floor (eg. Pucca)" 2 "Partly low quality and partly high quality (eg. Semi-pucca )" 3 "Made from mud, thatch or other low quality materials (eg Kutcha )" 4 "Others, specify {house_o:icons}" 
label define cook_ 1 "In separate room/kitchen in the house" 2 "In the main room of the house" 3 "Indoor corridor" 4 "In a separate building" 5 "Outdoors" 6 "Others {cook_o:icons}" 
label define fuel_ 1 "Electricity" 2 "Liquefied petroleum Gas (LPG)" 3 "Natural gas" 4 "Kerosene" 5 "Charcoal" 6 "Wood" 7 "Biomass/Agricultural Crop (Sawdust/Hull, etc.)" 8 "Animal Dung" 9 "Others, Specify: {fuel_o:icons}" 
label define electric_ 1 "Yes, own source" 2 "Yes, tap from neighbor or other joint sources" 3 "No" 4 "Others, Specify: {electric_o:icons}" 
label define water_ 1 "Piped private source" 2 "Private tube well or borehole" 3 "Piped public or communal source" 4 "Public tube well or borehole" 5 "Unprotected well" 6 "Tanker or other water delivery" 7 "Surface water" 8 "Other Specify: {water_o:icons}" 
label define toilet_ 1 "Own Flush toilet" 2 "Own Ventilated pit latrine" 3 "Own Pit latrine" 4 "Shared/ public Flush toilet" 5 "Shared/ public Ventilated pit latrine" 6 "Shared/ public Pit latrine" 7 "None-we defecate in the bush/field" 8 "Others, specify: {toilet_o:icons}" 
label define vcd_ 0 "No" 1 "Yes" 
label define tv_ 0 "No" 1 "Yes" 
label define ref_ 0 "No" 1 "Yes" 
label define wmachine_ 0 "No" 1 "Yes" 
label define computer_ 0 "No" 1 "Yes" 
label define stove_ 0 "No" 1 "Yes" 
label define radio_ 0 "No" 1 "Yes" 
label define phone_ 0 "No" 1 "Yes" 
label define cellphone_ 0 "No" 1 "Yes" 
label define efan_ 0 "No" 1 "Yes" 
label define ac_ 0 "No" 1 "Yes" 
label define sewing_ 0 "No" 1 "Yes" 
label define cow_ 0 "No" 1 "Yes" 
label define pig_ 0 "No" 1 "Yes" 
label define goat_ 0 "No" 1 "Yes" 
label define poultry_own_ 0 "No" 1 "Yes" 
label define bike_ 0 "No" 1 "Yes" 
label define motorcycle_ 0 "No" 1 "Yes" 
label define car_ 0 "No" 1 "Yes" 
label define boat_ 0 "No" 1 "Yes" 
label define tractor_ 0 "No" 1 "Yes" 
label define table_ 0 "No" 1 "Yes" 
label define chair_ 0 "No" 1 "Yes" 
label define crf_2_demography_and_v_3_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define citrus_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define berries_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define bananas_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define apples_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define pineapples_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define mango_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define melon_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define dry_fruit_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define tomato_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define pepper_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define orange_veg_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define green_leafy_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define cruciferous_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define gourd_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define legumes_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define nuts_seeds_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define red_meat_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define poultry_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define processed_meat_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define organ_meat_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define fish_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define seafood_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define eggs_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define milk_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define milk_tea_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define yogurt_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define yogurt_sweet_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define yogurt_drink_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define cheese_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define icecream_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define dairy_oth_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define fruit_juice_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define soda_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define alcohol_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define fries_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define fried_meat_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define crisps_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define crackers_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define samosas_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define pizza_burger_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define savoury_oth_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define cake_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define cookies_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define pudding_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define candy_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define street_food_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define fast_food_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define alcohol_amt_ 1 "Never" 2 "< 1 serving/week (small portions or rarely)" 3 "1 serving/week" 4 "2-3 servings / week" 5 "4-5 servings / week" 6 "6 or more servings / week" 
label define crf_12_diet_complete_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define weight_unit_ 1 "kg" 2 "lbs" 
label define stand_unit_ 1 "cm" 2 "ft" 3 "m" 
label define sit_unit_ 1 "cm" 2 "ft" 3 "m" 
label define sit_box_unit_ 1 "cm" 2 "ft" 3 "m" 
label define tibia_unit_ 1 "cm" 2 "in" 
label define grip_dominanthand_ 1 "Right" 2 "Left" 3 "Ambidextrous" 
label define grip_unit_r_ 1 "kg" 2 "N" 
label define grip_unit_l_ 1 "kg" 2 "N" 
label define muac_unit_ 1 "cm" 2 "in" 
label define waist_unit_ 1 "cm" 2 "in" 
label define hip_unit_ 1 "cm" 2 "in" 
label define triceps_unit_ 1 "mm" 2 "cm" 
label define subscap_unit_ 1 "mm" 2 "cm" 
label define menstruate_ 0 "No" 1 "Yes" -97 "Dont know" -98 "Refused" 
label define tanner_ 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 9 "9" -97 "Dont know" -98 "Refused" 
label define tanner_method_ 1 "Direct observation by study staff" 2 "Boy pointed to the diagram which represents his stage" 
label define crf_6_anthropometry_complete_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define bia_ 0 "No" 1 "Yes" -100 "Pending" -102 "Absconded" -103 "Equipment NA" 
label define bia_prob_ 0 "No" 1 "Yes" -100 "Pending" -102 "Absconded" -103 "Equipment NA" 
label define adp_ 0 "No" 1 "Yes" -100 "Pending" -102 "Absconded" -103 "Equipment NA" 
label define adp_prob_ 0 "No" 1 "Yes" -100 "Pending" -102 "Absconded" -103 "Equipment NA" 
label define crf_7_body_compositi_v_4_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define urine_ 0 "No" 1 "Yes" -98 "Refused" -100 "Pending" 
label define feces_ 1 "Provided one during the visit" 2 "Brought one from home" 3 "No sample" -98 "Refused" -100 "Pending" 
label define feces_temp_ 0 "No" 1 "Yes" 
label define feces_mode_ 1 "Will bring to clinic" 2 "Staff need to collect it" 
label define crf_11a_urine_and_fe_v_5_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define u_collect_ 0 "No" 1 "Yes" -98 "Refused" -100 "Pending" -102 "Absconded" -103 "Equipment NA" 
label define u_leucs_ 0 "0" 4 "trace" 1 "+" 2 "++" 3 "+++" 
label define u_gluc_ 0 "0" 4 "trace" 1 "+" 2 "++" 3 "+++" 
label define u_ketone_ 0 "0" 4 "trace" 1 "+" 2 "++" 3 "+++" 
label define u_prot_ 0 "0" 4 "trace" 1 "+" 2 "++" 3 "+++" 
label define u_nitrite_ 0 "0" 4 "trace" 1 "+" 2 "++" 3 "+++" 
label define u_blood_ 0 "0" 4 "trace" 1 "+" 2 "++" 3 "+++" 
label define feces_collect_ 0 "No" 1 "Yes" -98 "Refused" -100 "Pending" -102 "Absconded" -103 "Equipment NA" 
label define crf_11b_urine_and_fe_v_6_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define ogttr_confirm_ 0 "No" 1 "Yes" -98 "Refused" -100 "Pending" -102 "Absconded" -103 "Equipment NA" 
label define rogtt_unit_ 2 "mg/dL" 1 "mmol/L" 
label define ogttr_sample_edta_ 0 "No" 1 "Yes" 
label define rglu0_missing_ 0 "No" -104 "glucose less than min" -105 "glucose greater than max" 9 "Others, specify {rglu0_mis_specify}" 
label define ogttr_sample_edta30_ 0 "No" 1 "Yes" 
label define rglu30_missing_ 0 "No" -104 "glucose less than min" -105 "glucose greater than max" 9 "Others, specify {rglu30_mis_specify}" 
label define ogttr_sample_edta120_ 0 "No" 1 "Yes" 
label define rglu120_missing_ 0 "No" -104 "glucose less than min" -105 "glucose greater than max" 9 "Others specify {rglu120_mis_specify}" 
label define dia_referral_ 0 "No" 1 "Yes" 
label define crf_4b_repeat_ogtt_complete_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define total_cho_prob_ 0 "No" -104 "value less than min" -105 "value greater than max" 9 "Others, specify {total_cho_prob_spec:icons}" 
label define ldl_cho_prob_ 0 "No" -104 "value less than min" -105 "value greater than max" 9 "Others, specify {ldl_cho_prob_spec:icons}" 
label define hdl_cho_prob_ 0 "No" -104 "value less than min" -105 "value greater than max" 9 "Others, specify {hdl_cho_prob_spec:icons}" 
label define trig_prob_ 0 "No" -104 "value less than min" -105 "value greater than max" 9 "Others, specify {trig_prob_spec:icons}" 
label define lipid_unit_ 1 "mmol/L" 2 "mg/dL" 
label define hgb_prob_ 0 "No" -104 "value less than min" -105 "value greater than max" 9 "Others, specify {hgb_prob_spec:icons}" 
label define rbc_prob_ 0 "No" -104 "value less than min" -105 "value greater than max" 9 "Others, specify {rbc_prob_spec:icons}" 
label define wbc_prob_ 0 "No" -104 "value less than min" -105 "value greater than max" 9 "Others, specify {wbc_prob_spec:icons}" 
label define platelet_prob_ 0 "No" -104 "value less than min" -105 "value greater than max" 9 "Others, specify {platelet_prob_spec:icons}" 
label define lipase_prob_ 0 "No" -104 "value less than min" -105 "value greater than max" 9 "Others, specify {lipase_prob_spec:icons}" 
label define crp_prob_ 0 "No" -104 "value less than min" -105 "value greater than max" 9 "Others, specify {crp_prob_spec:icons}" 
label define crf_5_more_blood_tes_v_7_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define ct_scan_ 0 "No" 1 "Yes" -98 "Refused" -100 "Pending" -102 "Absconded" -103 "Equipment NA" 
label define ct_pan_size_qual_ 1 "Normal" 2 "Small" 3 "Enlarged" 4 "Cant see well enough to tell" 
label define ct_pan_shape_ 1 "Normal" 2 "Abnormal" 3 "Cant see well enough to tell" 
label define ct_pan_shape_problem_ 1 "Imbalance in size of head compared to tail" 2 "Other shape abnormality, specify {ct_pan_shape_prob_spec}" 
label define ct_pan_contour_ 1 "Normal/Smooth" 2 "Abnormal" 3 "Cant see well enough to tell" 
label define ct_pan_contour_problem_ 1 "Irregular border" 2 "Lobulated" 3 "Other contour problem, specify {ct_pan_contour_prob_spec}" 
label define ct_pan_parenchyma_ 1 "Normal" 2 "Abnormal" 3 "Cant see well enough to tell" 
label define ct_pan_paren_inflam_ 0 "No" 1 "Yes" 
label define ct_pan_paren_fibrosis_ 0 "No" 1 "Yes" 
label define ct_pan_paren_steatosis_ 0 "No" 1 "Yes" 
label define ct_pan_duct_ 1 "Normal" 2 "Abnormal" 3 "Cant see well enough to tell" 
label define ct_pan_duct_stones_ 0 "No" 1 "Yes" 
label define ct_pan_duct_mass_ 0 "No" 1 "Yes" 
label define ct_pan_calci_ 0 "Absent" 1 "Present" 3 "Cant see well enough to tell" 
label define ct_pan_calci_place_ 1 "Parenchymal" 2 "Per-pancreas" 
label define ct_pan_oth_abnormal_ 0 "No" 1 "Yes, specify {ct_pan_oth_abn_spec}" 
label define ct_image_qual_ 1 "Optimal" 2 "Non-optimal" 
label define ct_problem_ 1 "Bowel gas" 2 "Obese participant" 3 "Participant uncooperative, e.g. could not stay still" 4 "Others, specify {ct_problem_why}" 
label define crf_14_computed_tomo_v_8_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define ivgtt_complete_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label values languages languages_
label values cohort cohort_
label values sex sex_
label values confirm___1 confirm___1_
label values confirm____97 confirm____97_
label values confirm____98 confirm____98_
label values confirm____99 confirm____99_
label values confirm____100 confirm____100_
label values confirm____101 confirm____101_
label values confirm____102 confirm____102_
label values confirm____103 confirm____103_
label values confirm____104 confirm____104_
label values confirm____105 confirm____105_
label values confirm____106 confirm____106_
label values confirm____107 confirm____107_
label values confirm____108 confirm____108_
label values tr_contact1 tr_contact1_
label values tr_method1 tr_method1_
label values tr_reas_noc_phone1 tr_reas_noc_phone1_
label values tr_contact2 tr_contact2_
label values tr_method2 tr_method2_
label values tr_reas_noc_phone2 tr_reas_noc_phone2_
label values tr_contact3 tr_contact3_
label values tr_method3 tr_method3_
label values tr_reas_noc_phone3 tr_reas_noc_phone3_
label values agree agree_
label values cohort_tracing_complete cohort_tracing_complete_
label values control control_
label values cont_age cont_age_
label values cont_site cont_site_
label values cont_mald cont_mald_
label values cont_hiv_test cont_hiv_test_
label values cont_art cont_art_
label values explain___1 explain___1_
label values rec_diab rec_diab_
label values rec_diab_drug___0 rec_diab_drug___0_
label values rec_diab_drug___1 rec_diab_drug___1_
label values rec_diab_drug___2 rec_diab_drug___2_
label values rec_diab_drug___3 rec_diab_drug___3_
label values rec_diab_drug___4 rec_diab_drug___4_
label values rec_diab_drug____97 rec_diab_drug____97_
label values rec_diab_drug____98 rec_diab_drug____98_
label values rec_diab_drug____99 rec_diab_drug____99_
label values rec_diab_drug____100 rec_diab_drug____100_
label values rec_diab_drug____101 rec_diab_drug____101_
label values rec_diab_drug____102 rec_diab_drug____102_
label values rec_diab_drug____103 rec_diab_drug____103_
label values rec_diab_drug____104 rec_diab_drug____104_
label values rec_diab_drug____105 rec_diab_drug____105_
label values rec_diab_drug____106 rec_diab_drug____106_
label values rec_diab_drug____107 rec_diab_drug____107_
label values rec_diab_drug____108 rec_diab_drug____108_
label values insulin_dep insulin_dep_
label values consent_basic consent_basic_
label values assent assent_
label values preg_test preg_test_
label values preg_result preg_result_
label values indepth_sample indepth_sample_
label values indepth_exp indepth_exp_
label values mri_sample mri_sample_
label values mri mri_
label values ct_sample ct_sample_
label values ct ct_
label values xray_sample xray_sample_
label values xray xray_
label values ivgtt_sample ivgtt_sample_
label values ivgtt ivgtt_
label values uss_sample uss_sample_
label values uss uss_
label values crf_1_eligibility_co_v_0 crf_1_eligibility_co_v_0_
label values radio_exam radio_exam_
label values pan_size_normal pan_size_normal_
label values pan_size_qual pan_size_qual_
label values pan_shape pan_shape_
label values pan_shape_problem pan_shape_problem_
label values pan_contour pan_contour_
label values pan_contour_problem pan_contour_problem_
label values pan_parenchyma pan_parenchyma_
label values pan_paren_inflam pan_paren_inflam_
label values pan_paren_fibrosis pan_paren_fibrosis_
label values pan_paren_steatosis pan_paren_steatosis_
label values pan_duct_normal pan_duct_normal_
label values pan_duct pan_duct_
label values pan_duct_stones pan_duct_stones_
label values pan_duct_mass pan_duct_mass_
label values pan_peri_normal pan_peri_normal_
label values pan_calci pan_calci_
label values pan_calci_place pan_calci_place_
label values pan_cyst pan_cyst_
label values pan_collect pan_collect_
label values pan_fluid pan_fluid_
label values pan_masses pan_masses_
label values pan_oth_abnormal pan_oth_abnormal_
label values image_qual_uss image_qual_uss_
label values image_not_optimal image_not_optimal_
label values uss_problem uss_problem_
label values crf_13_abdomen_uss_complete crf_13_abdomen_uss_complete_
label values sample_gp sample_gp_
label values standard_ogtt standard_ogtt_
label values fasting fasting_
label values ogtt_unit ogtt_unit_
label values ogtt_sample_serum ogtt_sample_serum_
label values ogtt_sample_edta0 ogtt_sample_edta0_
label values ogtt_sample_apro0 ogtt_sample_apro0_
label values ogtt_sample_edta0_cold ogtt_sample_edta0_cold_
label values glu0_missing glu0_missing_
label values ogtt_sample_edta15 ogtt_sample_edta15_
label values glu15_missing glu15_missing_
label values ogtt_sample_edta30 ogtt_sample_edta30_
label values ogtt_sample_apro30 ogtt_sample_apro30_
label values ogtt_sample_edta30_cold ogtt_sample_edta30_cold_
label values glu30_missing glu30_missing_
label values ogtt_sample_edta45 ogtt_sample_edta45_
label values glu45_missing glu45_missing_
label values ogtt_sample_edta60 ogtt_sample_edta60_
label values ogtt_sample_apro60 ogtt_sample_apro60_
label values ogtt_sample_edta60_cold ogtt_sample_edta60_cold_
label values glu60_missing glu60_missing_
label values ogtt_sample_edta90 ogtt_sample_edta90_
label values ogtt_sample_apro90 ogtt_sample_apro90_
label values ogtt_sample_edta90_cold ogtt_sample_edta90_cold_
label values glu90_missing glu90_missing_
label values ogtt_sample_edta120 ogtt_sample_edta120_
label values ogtt_sample_apro120 ogtt_sample_apro120_
label values ogtt_sample_edta120_cold ogtt_sample_edta120_cold_
label values glu120_missing glu120_missing_
label values repeat_test_needed repeat_test_needed_
label values crf_4a_blood_samplin_v_1 crf_4a_blood_samplin_v_1_
label values pregnant pregnant_
label values preg_result1 preg_result1_
label values suspect_hiv suspect_hiv_
label values hiv hiv_
label values art art_
label values art_type art_type_
label values diab diab_
label values diag_drug___0 diag_drug___0_
label values diag_drug___1 diag_drug___1_
label values diag_drug___2 diag_drug___2_
label values diag_drug___3 diag_drug___3_
label values diag_drug___4 diag_drug___4_
label values diag_drug____97 diag_drug____97_
label values diag_drug____98 diag_drug____98_
label values diag_drug____99 diag_drug____99_
label values diag_drug____100 diag_drug____100_
label values diag_drug____101 diag_drug____101_
label values diag_drug____102 diag_drug____102_
label values diag_drug____103 diag_drug____103_
label values diag_drug____104 diag_drug____104_
label values diag_drug____105 diag_drug____105_
label values diag_drug____106 diag_drug____106_
label values diag_drug____107 diag_drug____107_
label values diag_drug____108 diag_drug____108_
label values diag_yn diag_yn_
label values diag_1 diag_1_
label values diag_2 diag_2_
label values diag_3 diag_3_
label values diag_4 diag_4_
label values lung_dis1 lung_dis1_
label values contissue_dis1 contissue_dis1_
label values peptic_ulcer1 peptic_ulcer1_
label values liver_dis1 liver_dis1_
label values kidney_dis1 kidney_dis1_
label values cancer1 cancer1_
label values lung_dis2 lung_dis2_
label values contissue_dis2 contissue_dis2_
label values peptic_ulcer2 peptic_ulcer2_
label values liver_dis2 liver_dis2_
label values kidney_dis2 kidney_dis2_
label values cancer2 cancer2_
label values lung_dis3 lung_dis3_
label values contissue_dis3 contissue_dis3_
label values peptic_ulcer3 peptic_ulcer3_
label values liver_dis3 liver_dis3_
label values kidney_dis3 kidney_dis3_
label values cancer3 cancer3_
label values lung_dis4 lung_dis4_
label values contissue_dis4 contissue_dis4_
label values peptic_ulcer4 peptic_ulcer4_
label values liver_dis4 liver_dis4_
label values kidney_dis4 kidney_dis4_
label values cancer4 cancer4_
label values hosp_diag hosp_diag_
label values med med_
label values med_type___1 med_type___1_
label values med_type___2 med_type___2_
label values med_type___3 med_type___3_
label values med_type___4 med_type___4_
label values med_type___5 med_type___5_
label values med_type____97 med_type____97_
label values med_type____98 med_type____98_
label values med_type____99 med_type____99_
label values med_type____100 med_type____100_
label values med_type____101 med_type____101_
label values med_type____102 med_type____102_
label values med_type____103 med_type____103_
label values med_type____104 med_type____104_
label values med_type____105 med_type____105_
label values med_type____106 med_type____106_
label values med_type____107 med_type____107_
label values med_type____108 med_type____108_
label values thirst thirst_
label values polyuria polyuria_
label values fatigue fatigue_
label values polydipsia polydipsia_
label values blurred_vision blurred_vision_
label values numbness numbness_
label values other_symptoms___1 other_symptoms___1_
label values other_symptoms___2 other_symptoms___2_
label values other_symptoms___3 other_symptoms___3_
label values other_symptoms___4 other_symptoms___4_
label values other_symptoms___5 other_symptoms___5_
label values other_symptoms___6 other_symptoms___6_
label values other_symptoms___7 other_symptoms___7_
label values other_symptoms___8 other_symptoms___8_
label values other_symptoms___9 other_symptoms___9_
label values other_symptoms___10 other_symptoms___10_
label values other_symptoms___11 other_symptoms___11_
label values other_symptoms___12 other_symptoms___12_
label values other_symptoms___13 other_symptoms___13_
label values other_symptoms___14 other_symptoms___14_
label values other_symptoms___15 other_symptoms___15_
label values other_symptoms___16 other_symptoms___16_
label values other_symptoms___17 other_symptoms___17_
label values other_symptoms___18 other_symptoms___18_
label values other_symptoms____97 other_symptoms____97_
label values other_symptoms____98 other_symptoms____98_
label values other_symptoms____99 other_symptoms____99_
label values other_symptoms____100 other_symptoms____100_
label values other_symptoms____101 other_symptoms____101_
label values other_symptoms____102 other_symptoms____102_
label values other_symptoms____103 other_symptoms____103_
label values other_symptoms____104 other_symptoms____104_
label values other_symptoms____105 other_symptoms____105_
label values other_symptoms____106 other_symptoms____106_
label values other_symptoms____107 other_symptoms____107_
label values other_symptoms____108 other_symptoms____108_
label values med_exam___1 med_exam___1_
label values med_exam___2 med_exam___2_
label values med_exam___3 med_exam___3_
label values med_exam___4 med_exam___4_
label values med_exam___5 med_exam___5_
label values med_exam___6 med_exam___6_
label values med_exam___7 med_exam___7_
label values med_exam___8 med_exam___8_
label values med_exam____97 med_exam____97_
label values med_exam____98 med_exam____98_
label values med_exam____99 med_exam____99_
label values med_exam____100 med_exam____100_
label values med_exam____101 med_exam____101_
label values med_exam____102 med_exam____102_
label values med_exam____103 med_exam____103_
label values med_exam____104 med_exam____104_
label values med_exam____105 med_exam____105_
label values med_exam____106 med_exam____106_
label values med_exam____107 med_exam____107_
label values med_exam____108 med_exam____108_
label values clin_summary clin_summary_
label values crf_3_clinical_histo_v_2 crf_3_clinical_histo_v_2_
label values refer_reason refer_reason_
label values radiol_refer radiol_refer_
label values elastase_level elastase_level_
label values fecal_fat fecal_fat_
label values elastase_refer elastase_refer_
label values refer refer_
label values refer_possible_diag___1 refer_possible_diag___1_
label values refer_possible_diag___2 refer_possible_diag___2_
label values refer_possible_diag___3 refer_possible_diag___3_
label values refer_possible_diag___4 refer_possible_diag___4_
label values refer_possible_diag___7 refer_possible_diag___7_
label values refer_possible_diag___8 refer_possible_diag___8_
label values refer_possible_diag___9 refer_possible_diag___9_
label values refer_possible_diag___10 refer_possible_diag___10_
label values refer_possible_diag___5 refer_possible_diag___5_
label values refer_possible_diag___6 refer_possible_diag___6_
label values refer_possible_diag____97 refer_possible_diag____97_
label values refer_possible_diag____98 refer_possible_diag____98_
label values refer_possible_diag____99 refer_possible_diag____99_
label values refer_possible_diag____100 refer_possible_diag____100_
label values refer_possible_diag____101 refer_possible_diag____101_
label values refer_possible_diag____102 refer_possible_diag____102_
label values refer_possible_diag____103 refer_possible_diag____103_
label values refer_possible_diag____104 refer_possible_diag____104_
label values refer_possible_diag____105 refer_possible_diag____105_
label values refer_possible_diag____106 refer_possible_diag____106_
label values refer_possible_diag____107 refer_possible_diag____107_
label values refer_possible_diag____108 refer_possible_diag____108_
label values refer_mri refer_mri_
label values refer_uss refer_uss_
label values refer_diag___1 refer_diag___1_
label values refer_diag___2 refer_diag___2_
label values refer_diag___3 refer_diag___3_
label values refer_diag___4 refer_diag___4_
label values refer_diag___7 refer_diag___7_
label values refer_diag___8 refer_diag___8_
label values refer_diag___9 refer_diag___9_
label values refer_diag___10 refer_diag___10_
label values refer_diag___5 refer_diag___5_
label values refer_diag___6 refer_diag___6_
label values refer_diag____97 refer_diag____97_
label values refer_diag____98 refer_diag____98_
label values refer_diag____99 refer_diag____99_
label values refer_diag____100 refer_diag____100_
label values refer_diag____101 refer_diag____101_
label values refer_diag____102 refer_diag____102_
label values refer_diag____103 refer_diag____103_
label values refer_diag____104 refer_diag____104_
label values refer_diag____105 refer_diag____105_
label values refer_diag____106 refer_diag____106_
label values refer_diag____107 refer_diag____107_
label values refer_diag____108 refer_diag____108_
label values crf_10_referral_complete crf_10_referral_complete_
label values marital marital_
label values education education_
label values edu_father edu_father_
label values edu_mother edu_mother_
label values edu_child edu_child_
label values employ employ_
label values employ_father employ_father_
label values employ_mother employ_mother_
label values dwelltype dwelltype_
label values tenurhws tenurhws_
label values house house_
label values cook cook_
label values fuel fuel_
label values electric electric_
label values water water_
label values toilet toilet_
label values vcd vcd_
label values tv tv_
label values ref ref_
label values wmachine wmachine_
label values computer computer_
label values stove stove_
label values radio radio_
label values phone phone_
label values cellphone cellphone_
label values efan efan_
label values ac ac_
label values sewing sewing_
label values cow cow_
label values pig pig_
label values goat goat_
label values poultry_own poultry_own_
label values bike bike_
label values motorcycle motorcycle_
label values car car_
label values boat boat_
label values tractor tractor_
label values table table_
label values chair chair_
label values crf_2_demography_and_v_3 crf_2_demography_and_v_3_
label values citrus citrus_
label values berries berries_
label values bananas bananas_
label values apples apples_
label values pineapples pineapples_
label values mango mango_
label values melon melon_
label values dry_fruit dry_fruit_
label values tomato tomato_
label values pepper pepper_
label values orange_veg orange_veg_
label values green_leafy green_leafy_
label values cruciferous cruciferous_
label values gourd gourd_
label values legumes legumes_
label values nuts_seeds nuts_seeds_
label values red_meat red_meat_
label values poultry poultry_
label values processed_meat processed_meat_
label values organ_meat organ_meat_
label values fish fish_
label values seafood seafood_
label values eggs eggs_
label values milk milk_
label values milk_tea milk_tea_
label values yogurt yogurt_
label values yogurt_sweet yogurt_sweet_
label values yogurt_drink yogurt_drink_
label values cheese cheese_
label values icecream icecream_
label values dairy_oth dairy_oth_
label values fruit_juice fruit_juice_
label values soda soda_
label values alcohol alcohol_
label values fries fries_
label values fried_meat fried_meat_
label values crisps crisps_
label values crackers crackers_
label values samosas samosas_
label values pizza_burger pizza_burger_
label values savoury_oth savoury_oth_
label values cake cake_
label values cookies cookies_
label values pudding pudding_
label values candy candy_
label values street_food street_food_
label values fast_food fast_food_
label values alcohol_amt alcohol_amt_
label values crf_12_diet_complete crf_12_diet_complete_
label values weight_unit weight_unit_
label values stand_unit stand_unit_
label values sit_unit sit_unit_
label values sit_box_unit sit_box_unit_
label values tibia_unit tibia_unit_
label values grip_dominanthand grip_dominanthand_
label values grip_unit_r grip_unit_r_
label values grip_unit_l grip_unit_l_
label values muac_unit muac_unit_
label values waist_unit waist_unit_
label values hip_unit hip_unit_
label values triceps_unit triceps_unit_
label values subscap_unit subscap_unit_
label values menstruate menstruate_
label values tanner tanner_
label values tanner_method tanner_method_
label values crf_6_anthropometry_complete crf_6_anthropometry_complete_
label values bia bia_
label values bia_prob bia_prob_
label values adp adp_
label values adp_prob adp_prob_
label values crf_7_body_compositi_v_4 crf_7_body_compositi_v_4_
label values urine urine_
label values feces feces_
label values feces_temp feces_temp_
label values feces_mode feces_mode_
label values crf_11a_urine_and_fe_v_5 crf_11a_urine_and_fe_v_5_
label values u_collect u_collect_
label values u_leucs u_leucs_
label values u_gluc u_gluc_
label values u_ketone u_ketone_
label values u_prot u_prot_
label values u_nitrite u_nitrite_
label values u_blood u_blood_
label values feces_collect feces_collect_
label values crf_11b_urine_and_fe_v_6 crf_11b_urine_and_fe_v_6_
label values ogttr_confirm ogttr_confirm_
label values rogtt_unit rogtt_unit_
label values ogttr_sample_edta ogttr_sample_edta_
label values rglu0_missing rglu0_missing_
label values ogttr_sample_edta30 ogttr_sample_edta30_
label values rglu30_missing rglu30_missing_
label values ogttr_sample_edta120 ogttr_sample_edta120_
label values rglu120_missing rglu120_missing_
label values dia_referral dia_referral_
label values crf_4b_repeat_ogtt_complete crf_4b_repeat_ogtt_complete_
label values total_cho_prob total_cho_prob_
label values ldl_cho_prob ldl_cho_prob_
label values hdl_cho_prob hdl_cho_prob_
label values trig_prob trig_prob_
label values lipid_unit lipid_unit_
label values hgb_prob hgb_prob_
label values rbc_prob rbc_prob_
label values wbc_prob wbc_prob_
label values platelet_prob platelet_prob_
label values lipase_prob lipase_prob_
label values crp_prob crp_prob_
label values crf_5_more_blood_tes_v_7 crf_5_more_blood_tes_v_7_
label values ct_scan ct_scan_
label values ct_pan_size_qual ct_pan_size_qual_
label values ct_pan_shape ct_pan_shape_
label values ct_pan_shape_problem ct_pan_shape_problem_
label values ct_pan_contour ct_pan_contour_
label values ct_pan_contour_problem ct_pan_contour_problem_
label values ct_pan_parenchyma ct_pan_parenchyma_
label values ct_pan_paren_inflam ct_pan_paren_inflam_
label values ct_pan_paren_fibrosis ct_pan_paren_fibrosis_
label values ct_pan_paren_steatosis ct_pan_paren_steatosis_
label values ct_pan_duct ct_pan_duct_
label values ct_pan_duct_stones ct_pan_duct_stones_
label values ct_pan_duct_mass ct_pan_duct_mass_
label values ct_pan_calci ct_pan_calci_
label values ct_pan_calci_place ct_pan_calci_place_
label values ct_pan_oth_abnormal ct_pan_oth_abnormal_
label values ct_image_qual ct_image_qual_
label values ct_problem ct_problem_
label values crf_14_computed_tomo_v_8 crf_14_computed_tomo_v_8_
label values ivgtt_complete ivgtt_complete_



tostring dob, replace
gen _date_ = date(dob,"YMD")
drop dob
rename _date_ dob
format dob %dM_d,_CY

tostring gr_date1, replace
gen _date_ = date(gr_date1,"YMD")
drop gr_date1
rename _date_ gr_date1
format gr_date1 %dM_d,_CY

tostring gr_date2, replace
gen _date_ = date(gr_date2,"YMD")
drop gr_date2
rename _date_ gr_date2
format gr_date2 %dM_d,_CY

tostring gr_date3, replace
gen _date_ = date(gr_date3,"YMD")
drop gr_date3
rename _date_ gr_date3
format gr_date3 %dM_d,_CY

tostring date_exam_uss, replace
gen _date_ = date(date_exam_uss,"YMD")
drop date_exam_uss
rename _date_ date_exam_uss
format date_exam_uss %dM_d,_CY

tostring clinic_date_ogtt, replace
gen _date_ = date(clinic_date_ogtt,"YMD")
drop clinic_date_ogtt
rename _date_ clinic_date_ogtt
format clinic_date_ogtt %dM_d,_CY

tostring repeat_date, replace
gen _date_ = date(repeat_date,"YMD")
drop repeat_date
rename _date_ repeat_date
format repeat_date %dM_d,_CY

tostring clinic_date_history, replace
gen _date_ = date(clinic_date_history,"YMD")
drop clinic_date_history
rename _date_ clinic_date_history
format clinic_date_history %dM_d,_CY

tostring clinic_date_referral, replace
gen _date_ = date(clinic_date_referral,"YMD")
drop clinic_date_referral
rename _date_ clinic_date_referral
format clinic_date_referral %dM_d,_CY

tostring clinic_date_demo, replace
gen _date_ = date(clinic_date_demo,"YMD")
drop clinic_date_demo
rename _date_ clinic_date_demo
format clinic_date_demo %dM_d,_CY

tostring clinic_date_diet, replace
gen _date_ = date(clinic_date_diet,"YMD")
drop clinic_date_diet
rename _date_ clinic_date_diet
format clinic_date_diet %dM_d,_CY

tostring clinic_date_anthro, replace
gen _date_ = date(clinic_date_anthro,"YMD")
drop clinic_date_anthro
rename _date_ clinic_date_anthro
format clinic_date_anthro %dM_d,_CY

tostring clinic_date_body, replace
gen _date_ = date(clinic_date_body,"YMD")
drop clinic_date_body
rename _date_ clinic_date_body
format clinic_date_body %dM_d,_CY

tostring clinic_date_urine_feces, replace
gen _date_ = date(clinic_date_urine_feces,"YMD")
drop clinic_date_urine_feces
rename _date_ clinic_date_urine_feces
format clinic_date_urine_feces %dM_d,_CY

tostring urine_collect_dt, replace
gen _date_ = date(urine_collect_dt,"YMD")
drop urine_collect_dt
rename _date_ urine_collect_dt
format urine_collect_dt %dM_d,_CY

tostring feces_collect_dt, replace
gen _date_ = date(feces_collect_dt,"YMD")
drop feces_collect_dt
rename _date_ feces_collect_dt
format feces_collect_dt %dM_d,_CY

tostring feces_date, replace
gen _date_ = date(feces_date,"YMD")
drop feces_date
rename _date_ feces_date
format feces_date %dM_d,_CY

tostring ct_date, replace
gen _date_ = date(ct_date,"YMD")
drop ct_date
rename _date_ ct_date
format ct_date %dM_d,_CY

label variable record_id "Database ID"
label variable redcap_data_access_group "Data Access Group"
label variable personnel "REDCap ID of Data Entry Personnel"
label variable timestamp "Date of Data Entry"
label variable languages "Languages:"
label variable cohort "Study cohort"
label variable incorrect_cohort "Flag Incorrect Cohort"
label variable sampa_id "SAMPA ID"
label variable orgid "ID from original study"
label variable first "Participants First Name Initial"
label variable middle "Participants Middle Name Initial"
label variable last "Participants Last Name Initial"
label variable sex "[2.2] Participants sex"
label variable dob "[2.3] Participants date of birth"
label variable age "Age (years)"
label variable confirm___1 " I confirmed that the keyidentifiers have been verified to be correct.  (choice=Yes)"
label variable confirm____97 " I confirmed that the keyidentifiers have been verified to be correct.  (choice=Dont know)"
label variable confirm____98 " I confirmed that the keyidentifiers have been verified to be correct.  (choice=Refused)"
label variable confirm____99 " I confirmed that the keyidentifiers have been verified to be correct.  (choice=Not applicable)"
label variable confirm____100 " I confirmed that the keyidentifiers have been verified to be correct.  (choice=Pending information)"
label variable confirm____101 " I confirmed that the keyidentifiers have been verified to be correct.  (choice=Forgot/Misplaced)"
label variable confirm____102 " I confirmed that the keyidentifiers have been verified to be correct.  (choice=Participant absconded)"
label variable confirm____103 " I confirmed that the keyidentifiers have been verified to be correct.  (choice=Equipment not available)"
label variable confirm____104 " I confirmed that the keyidentifiers have been verified to be correct.  (choice=Less than Min)"
label variable confirm____105 " I confirmed that the keyidentifiers have been verified to be correct.  (choice=More than Max)"
label variable confirm____106 " I confirmed that the keyidentifiers have been verified to be correct.  (choice=Unclear utz/mri images)"
label variable confirm____107 " I confirmed that the keyidentifiers have been verified to be correct.  (choice=Sample not enough/extracted)"
label variable confirm____108 " I confirmed that the keyidentifiers have been verified to be correct.  (choice=Results invalid)"
label variable gr_date1 "Date of First Contact"
label variable tr_contact1 "Were you able to contact the participant?"
label variable tr_method1 "How did you attempt to contact the participant?"
label variable tr_reas_noc_phone1 "Why were you not able to contact the participant by [tr_method1]?"
label variable tr_reas_other1 "Others, specify"
label variable gr_date2 "Date of Second Contact"
label variable tr_contact2 "Were you able to contact the participant?"
label variable tr_method2 "How did you attempt to contact the participant?"
label variable tr_reas_noc_phone2 "Why were you not able to contact the participant by [tr_method2]?"
label variable tr_reas_other2 "Others, specify"
label variable gr_date3 "Date of Third Contact"
label variable tr_contact3 "Were you able to contact the participant?"
label variable tr_method3 "How did you attempt to contact the participant?"
label variable tr_reas_noc_phone3 "Why were you not able to contact the participant by [tr_method3]?"
label variable tr_reas_other3 "Others, specify"
label variable agree "Did the participant agree to join the SAMPA study?"
label variable disagree_why "If not, please specify reasons why they prefer not to join the study"
label variable cohort_tracing_complete "Complete?"
label variable personnel1 "REDCap ID of Data Entry Personnel"
label variable timestamp1 "Date of Data Entry"
label variable control "Is the participant part of Nustart controls?"
label variable cont_age "[1.3] > 18 years old?"
label variable cont_site "[1.4] recruitment site, i.e. ART clinic or neighbour of NUSTART Lusaka or other control"
label variable cont_mald "[1.5] Have you ever been diagnosed by a doctor as being malnourished?"
label variable cont_hiv_test "[1.6] We need to know HIV status of NUSTART controls, half who will be infected and half uninfected"
label variable cont_art "[1.7] Is the control on ART?"
label variable cont_art_yrs "[1.8] If on ART, how many years have they been on ART?"
label variable explain___1 "[1.9] Has the study been explained to the participant and, for child cohorts, their parents? (choice=Yes)"
label variable rec_diab "Does the participant have diabetes as diagnosed by a doctor?"
label variable rec_diab_drug___0 "If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought.  (choice=None (includes advice, e.g., to lose weight))"
label variable rec_diab_drug___1 "If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought.  (choice=Insulin)"
label variable rec_diab_drug___2 "If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought.  (choice=Metformin)"
label variable rec_diab_drug___3 "If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought.  (choice=Herbal or over-the-counter medicines)"
label variable rec_diab_drug___4 "If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought.  (choice=Others)"
label variable rec_diab_drug____97 "If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought.  (choice=Dont know)"
label variable rec_diab_drug____98 "If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought.  (choice=Refused)"
label variable rec_diab_drug____99 "If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought.  (choice=Not applicable)"
label variable rec_diab_drug____100 "If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought.  (choice=Pending information)"
label variable rec_diab_drug____101 "If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought.  (choice=Forgot/Misplaced)"
label variable rec_diab_drug____102 "If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought.  (choice=Participant absconded)"
label variable rec_diab_drug____103 "If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought.  (choice=Equipment not available)"
label variable rec_diab_drug____104 "If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought.  (choice=Less than Min)"
label variable rec_diab_drug____105 "If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought.  (choice=More than Max)"
label variable rec_diab_drug____106 "If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought.  (choice=Unclear utz/mri images)"
label variable rec_diab_drug____107 "If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought.  (choice=Sample not enough/extracted)"
label variable rec_diab_drug____108 "If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought.  (choice=Results invalid)"
label variable insulin_dep "Do you routinely use insulin to control your diabetes?"
label variable flag_insulin "Taking Insulin"
label variable consent_basic "[1.10] Participants must consent to either the standard (7 time point) or basic (3 time point) OGTT plus questionnaires and fecal and urine collection in order to consent to SAMPA overall.  All children in SAMPA should have just the basic 3 time point OGTT and should not be asked for the standard version with cannulas"
label variable assent "[1.11] Has the child given assent after parental consent?"
label variable preg_test "[1.12] Is the person willing to have a pregnancy test in order to determine eligibility for some additional tests? "
label variable preg_result "Pregnancy Test Results"
label variable flag_preg "Flag Pregnancy Results"
label variable indepth_sample "Are they in the indepth subsample? "
label variable indepth_exp "If so, have they had the extra volume of blood taken  explained to them do they consent to?"
label variable flag_group "Sample Group"
label variable mri_sample "Are they in the MRI subsample? "
label variable mri "If so, have they had the MRI test explained to them do they consent to MRI?"
label variable ct_sample "Are they in the CT scan subsample? "
label variable ct "If so, have they had the CT scan test explained to them do they consent to CT Scan?"
label variable xray_sample "Are they in the X-ray subsample? "
label variable xray "If so, have they had the X-ray test explained to them do they consent to X-ray?"
label variable ivgtt_sample "Are they in the in-depth subsample? "
label variable ivgtt "If so, have they had the larger OGTT and the IVGTT tests explained to them do they consent to these? "
label variable uss_sample "Are they in the Ultrasound subsample? "
label variable uss "If so, have they had the Ultrasound test explained to them do they consent to Ultrasound?"
label variable file_consent "Upload Signed Consent Form"
label variable crf_1_eligibility_co_v_0 "Complete?"
label variable personnel13 "REDCap ID of Data Entry Personnel"
label variable timestamp13 "Date of Data Entry"
label variable radio_exam "Was a radiological examination performed?"
label variable date_exam_uss "[13.1] Date of Examination"
label variable time_exam_uss "[13.1] Time of Examination"
label variable pan_size_head "Pancreatic Size in CM (Head)"
label variable pan_size_body "Pancreatic Size  in CM (Body)"
label variable pan_size_tail "Pancreatic Size  in CM  (Tail)"
label variable pan_size_normal "Pancreatic Size **If abnormal specify"
label variable pan_size_ab_why "If abnormal specify"
label variable pan_size_qual "[13.4] Qualitative indicator of pancreas size"
label variable pan_head_trans "[13.5] Pancreas head size measured in transverse dimension **Score -106 if cant be measured due to image quality"
label variable pan_head_ap "[13.6] Pancreas head size measured in anterior/posterior dimension **Score -106 if cant be measured due to image quality"
label variable pan_body_trans "[13.7] Pancreas body size measures in anterior/posterior dimension; maximum diameter **Score -106 if cant be measured due to image quality"
label variable pan_tail_trans "[13.8] Pancreas tail size measure in anterior/posterior dimension **Score -106 if cant be measured due to image quality"
label variable pan_shape "[13.9] Pancreas shape"
label variable pan_shape_problem "[13.10] For abnormal shape, specify the problem"
label variable pan_shape_prob_specify "Other shape abnormality, specify"
label variable pan_contour "[13.11] Pancreas contour"
label variable pan_contour_problem "[13.12] For abnormal contour, specify the problem"
label variable pan_contour_prob_specify "Other contour problem, specify"
label variable pan_parenchyma "[13.13] Pancreatic Parenchyma"
label variable parenchyma_ab_why "If abnormal specify"
label variable pan_paren_inflam "[13.14] Pancreas shows signs of inflammation of edema"
label variable pan_paren_fibrosis "[13.15] Pancreas shows signs of fibrosis"
label variable pan_paren_steatosis "[13.16] Pancreas shows signs of steatosis"
label variable pan_duct_normal "Pancreatic Duct Size **If abnormal specify"
label variable pan_duct_ab "If abnormal specify"
label variable pan_duct "[13.17] Pancreas Duct"
label variable pan_duct_stones "[13.18] Stones detected in the duct"
label variable pan_duct_mass "[13.19] Mass detected in the duct"
label variable pan_peri_normal "Peri-pancreatic Vessels **If abnormal specify"
label variable pan_peri_ab "If abnormal specify"
label variable pan_calci "[13.20] Calcifications"
label variable pan_calci_yes "If yes specify"
label variable pan_calci_place "[13.21] If calcification is present, indicate where it is"
label variable pan_cyst "Cyst(s) **If yes specify"
label variable pan_cyst_yes "If yes specify"
label variable pan_collect "Collection(s)**If yes specify"
label variable pan_collect_yes "If yes specify"
label variable pan_fluid "Free Fluid**If yes specify"
label variable pan_fluid_yes "If yes specify"
label variable pan_masses "Masses**If yes specify"
label variable pan_masses_yes "If yes specify"
label variable pan_others "Other findings, specify"
label variable pan_con "Conclusion"
label variable pan_oth_abnormal "[13.22] Any other abnormalities detected?"
label variable pan_oth_abn_specify "Specify other abnormalities detected"
label variable image_qual_uss "[13.23] Was the ultrasound scan optimal for obtaining the required information?"
label variable image_not_optimal "[13.24] Indicate why the ultrasound scan not optimal"
label variable image_non_why "If non-optimal specify why"
label variable uss_problem "Were there problems obtaining good ultrasound data?"
label variable uss_problem_specify "If yes, specify"
label variable name_radio "Name of Radiologist"
label variable sig_radio "Signature"
label variable sig_uss_upload "Upload radiologist signature"
label variable file_uss "Upload DICOM file"
label variable file_uss2 "Upload DICOM file"
label variable file_uss3 "Upload DICOM file"
label variable file_uss4 "Upload DICOM file"
label variable file_uss5 "Upload DICOM file"
label variable file_uss6 "Upload DICOM file"
label variable file_uss7 "Upload DICOM file"
label variable file_uss8 "Upload DICOM file"
label variable file_uss9 "Upload DICOM file"
label variable file_uss10 "Upload DICOM file"
label variable crf_13_abdomen_uss_complete "Complete?"
label variable personnel4 "REDCap ID of Data Entry Personnel"
label variable timestamp4 "Date of Data Entry"
label variable clinic_date_ogtt "[4.1] Date of First OGTT Test"
label variable sample_gp "[4.2] Which group does the person belong to?"
label variable standard_ogtt "For adult participants agreeing to do Standard OGTT but are not in the indepth sample, will they be doing 7-point or 5-point OGTT?"
label variable fasting "[4.3] What has the participant eaten or drunk in the last 8 hours OR since dinner last night? "
label variable ogtt_unit "Unit of measurement"
label variable ogtt_time0 "[4.4] Time 0 minutes"
label variable time0_w "Sample ID of Time 0: Onsite Serum"
label variable time0_x "Sample ID of Time 0: Aliquot X (Serum)"
label variable time0_y "Sample ID of Time 0: Aliquot Y (Serum)"
label variable time0_z "Sample ID of Time 0: Onsite EDTA"
label variable time0_a "Sample ID of Time 0: Aliquot A (EDTA)"
label variable time0_b "Sample ID of Time 0: Aliquot B (EDTA)"
label variable time0_c "Sample ID of Time 0: Aliquot C (EDTA)"
label variable time0_e "Sample ID of Time 0: Aliquot E (Cooled EDTA)"
label variable time0_f "Sample ID of Time 0: Aliquot F (Cooled EDTA)"
label variable time0_g "Sample ID of Time 0: Aliquot G (Cooled EDTA)"
label variable time0_h "Sample ID of Time 0: Aliquot H (Aprotinin)"
label variable time0_j "Sample ID of Time 0: Aliquot J (Aprotinin)"
label variable time0_k "Sample ID of Time 0: Aliquot K (Aprotinin)"
label variable ogtt_sample_serum "[4.5] Fasting serum"
label variable ogtt_sample_edta0 "[4.5] Fasting EDTA"
label variable ogtt_sample_apro0 "[4.11] Fasting aprotinin"
label variable ogtt_sample_edta0_cold "[4.11] Fasting cooled EDTA"
label variable ogtt_comment_time0 "[4.6] Explain any missing samples or problems in sample collection"
label variable hba1c "[5.3] Hba1c result [%] from baseline sample In OGTT"
label variable glu0 "[5.4] OGTT result_Time0"
label variable mmol_glu0 "Timepoint 0 Glucose in mmol/L"
label variable out_glu0 "glucose 0 minutes > 24.6"
label variable glu0_missing "Any problems with OGTT Results?"
label variable glu0_mis_specify "Others, specify"
label variable cpeptide0 "C_Peptide_Time0"
label variable insulin0 "Insulin_Time0"
label variable ogtt_time15 "[4.4] Time 15 minutes"
label variable time15_z "Sample ID of Time 15: Onsite EDTA"
label variable time15_a "Sample ID of Time 15: Aliquot A (EDTA)"
label variable time15_b "Sample ID of Time 15: Aliquot B (EDTA)"
label variable time15_c "Sample ID of Time 15: Aliquot C (EDTA)"
label variable ogtt_sample_edta15 "[4.5] 15 min EDTA"
label variable ogtt_comment_time15 "[4.6] Explain any missing samples or problems in sample collection"
label variable glu15 "[5.5] OGTT result_Time15"
label variable mmol_glu15 "Timepoint 15 Glucose in mmol/L"
label variable out_glu15 "glucose 15 minutes > 24.6"
label variable glu15_missing "Any problems with OGTT Results?"
label variable glu15_mis_specify "Others, specify"
label variable cpeptide15 "[5.5] C_Peptide_Time15"
label variable insulin15 "[5.5] Insulin_Time15"
label variable ogtt_time30 "[4.4] Time 30 minutes"
label variable time30_z "Sample ID of Time 30: Onsite EDTA"
label variable time30_a "Sample ID of Time 30: Aliquot A (EDTA)"
label variable time30_b "Sample ID of Time 30: Aliquot B (EDTA)"
label variable time30_c "Sample ID of Time 30: Aliquot C (EDTA)"
label variable time30_e "Sample ID of Time 30: Aliquot E (Cooled EDTA)"
label variable time30_f "Sample ID of Time 30: Aliquot F (Cooled EDTA)"
label variable time30_g "Sample ID of Time 30: Aliquot G (Cooled EDTA)"
label variable time30_h "Sample ID of Time 30: Aliquot H (Aprotinin)"
label variable time30_j "Sample ID of Time 30: Aliquot J (Aprotinin)"
label variable time30_k "Sample ID of Time 30: Aliquot K (Aprotinin)"
label variable ogtt_sample_edta30 "[4.5] 30 min EDTA"
label variable ogtt_sample_apro30 "[4.11] 30 min aprotinin"
label variable ogtt_sample_edta30_cold "[4.11] 30 min cooled EDTA"
label variable ogtt_comment_time30 "[4.6] Explain any missing samples or problems in sample collection"
label variable glu30 "[5.6] OGTT result_Time30"
label variable mmol_glu30 "Timepoint 30 Glucose in mmol/L"
label variable out_glu30 "glucose 30 minutes > 24.6"
label variable glu30_missing "Any problems with OGTT Results?"
label variable glu30_mis_specify "Others, specify"
label variable cpeptide30 "[5.6] C_Peptide_Time30"
label variable insulin30 "[5.6] Insulin_Time30"
label variable ogtt_time45 "[4.4] Time 45 minutes"
label variable time45_z "Sample ID of Time 45: Onsite EDTA"
label variable time45_a "Sample ID of Time 45: Aliquot A (EDTA)"
label variable time45_b "Sample ID of Time 45: Aliquot B (EDTA)"
label variable time45_c "Sample ID of Time 45: Aliquot C (EDTA)"
label variable ogtt_sample_edta45 "[4.5] 45 min EDTA"
label variable ogtt_comment_time45 "[4.6] Explain any missing samples or problems in sample collection"
label variable glu45 "[5.7] OGTT result_Time45"
label variable mmol_glu45 "Timepoint 45 Glucose in mmol/L"
label variable out_glu45 "glucose 45 minutes > 24.6"
label variable glu45_missing "Any problems with OGTT Results?"
label variable glu45_mis_specify "Others, specify"
label variable cpeptide45 "[5.7] C_Peptide_Time45"
label variable insulin45 "[5.7] Insulin_Time45"
label variable ogtt_time60 "[4.4] Time 60 minutes"
label variable time60_z "Sample ID of Time 60: Onsite EDTA"
label variable time60_a "Sample ID of Time 60: Aliquot A (EDTA)"
label variable time60_b "Sample ID of Time 60: Aliquot B (EDTA)"
label variable time60_c "Sample ID of Time 60: Aliquot C (EDTA)"
label variable time60_e "Sample ID of Time 60: Aliquot E (Cooled EDTA)"
label variable time60_f "Sample ID of Time 60: Aliquot F (Cooled EDTA)"
label variable time60_g "Sample ID of Time 60: Aliquot G (Cooled EDTA)"
label variable time60_h "Sample ID of Time 60: Aliquot H (Aprotinin)"
label variable time60_j "Sample ID of Time 60: Aliquot J (Aprotinin)"
label variable time60_k "Sample ID of Time 60: Aliquot K (Aprotinin)"
label variable ogtt_sample_edta60 "[4.5] 60 min EDTA"
label variable ogtt_sample_apro60 "[4.11] 60 min aprotinin"
label variable ogtt_sample_edta60_cold "[4.11] 60 min cooled EDTA"
label variable ogtt_comment_time60 "[4.6] Explain any missing samples or problems in sample collection"
label variable glu60 "[5.8] OGTT result_Time60"
label variable mmol_glu60 "Timepoint 60 Glucose in mmol/L"
label variable out_glu60 "glucose 60 minutes > 24.6"
label variable glu60_missing "Any problems with OGTT Results?"
label variable glu60_mis_specify "Others, specify"
label variable cpeptide60 "[5.8] C_Peptide_Time60"
label variable insulin60 "[5.8] Insulin_Time60"
label variable ogtt_time90 "[4.4] Time 90 minutes"
label variable time90_z "Sample ID of Time 90: Onsite EDTA"
label variable time90_a "Sample ID of Time 90: Aliquot A (EDTA)"
label variable time90_b "Sample ID of Time 90: Aliquot B (EDTA)"
label variable time90_c "Sample ID of Time 90: Aliquot C (EDTA)"
label variable time90_e "Sample ID of Time 90: Aliquot E (Cooled EDTA)"
label variable time90_f "Sample ID of Time 90: Aliquot F (Cooled EDTA)"
label variable time90_g "Sample ID of Time 90: Aliquot G (Cooled EDTA)"
label variable time90_h "Sample ID of Time 90: Aliquot H (Aprotinin)"
label variable time90_j "Sample ID of Time 90: Aliquot J (Aprotinin)"
label variable time90_k "Sample ID of Time 90: Aliquot K (Aprotinin)"
label variable ogtt_sample_edta90 "[4.5] 90 min EDTA"
label variable ogtt_sample_apro90 "[4.11] 90 min aprotinin"
label variable ogtt_sample_edta90_cold "[4.11] 90 min cooled EDTA"
label variable ogtt_comment_time90 "[4.6] Explain any missing samples or problems in sample collection"
label variable glu90 "[5.9] OGTT result_Time90"
label variable mmol_glu90 "Timepoint 90 Glucose in mmol/L"
label variable out_glu90 "glucose 90 minutes > 24.6"
label variable glu90_missing "Any problems with OGTT Results?"
label variable glu90_mis_specify "Others, specify"
label variable cpeptide90 "[5.9] C_Peptide_Time90"
label variable insulin90 "[5.9] Insulin_Time90"
label variable ogtt_time120 "[4.4] Time 120 minutes"
label variable time120_z "Sample ID of Time 120: Onsite EDTA"
label variable time120_a "Sample ID of Time 120: Aliquot A (EDTA)"
label variable time120_b "Sample ID of Time 120: Aliquot B (EDTA)"
label variable time120_c "Sample ID of Time 120: Aliquot C (EDTA)"
label variable time120_e "Sample ID of Time 120: Aliquot E (Cooled EDTA)"
label variable time120_f "Sample ID of Time 120: Aliquot F (Cooled EDTA)"
label variable time120_g "Sample ID of Time 120: Aliquot G (Cooled EDTA)"
label variable time120_h "Sample ID of Time 120: Aliquot H (Aprotinin)"
label variable time120_j "Sample ID of Time 120: Aliquot J (Aprotinin)"
label variable time120_k "Sample ID of Time 120: Aliquot K (Aprotinin)"
label variable ogtt_sample_edta120 "[4.5] 120 min EDTA"
label variable ogtt_sample_apro120 "[4.11] 120 min aprotinin"
label variable ogtt_sample_edta120_cold "[4.11] 120 min cooled EDTA"
label variable ogtt_comment_time120 "[4.6] Explain any missing samples or problems in sample collection"
label variable glu120 "[5.10] OGTT result_Time120"
label variable mmol_glu120 "Timepoint 120 Glucose in mmol/L"
label variable out_glu120 "glucose 120 minutes > 24.6"
label variable glu120_missing "Any problems with OGTT Results?"
label variable glu120_mis_specify "Others, specify"
label variable cpeptide120 "C_Peptide_Time120"
label variable insulin120 "Insulin_Time120"
label variable high_hba1c_1 "hba1c>6.5%"
label variable high_glu120_1 "glucose 120 minutes > 11.1 mmol/L"
label variable repeat_test_needed "[5.11] Does this participant in their first clinic visit have high HbA1c or glucose levels at 120 minutes which suggest they may have diabetes and need to come back for a second OGTT? A second OGTT should be booked WITHIN 2 WEEKS if either: 1. HbA1c ≥ 6.5% 2. 120-minute glucose in OGTT > 11.1 mmol/L"
label variable repeat_date "[5.12] Date of second OGTT appointment booked"
label variable crf_4a_blood_samplin_v_1 "Complete?"
label variable personnel3 "REDCap ID of Data Entry Personnel"
label variable timestamp3 "Date of Data Entry"
label variable clinic_date_history "[3.1] Date of Clinic Visit [Participant was seen by the Doctor]"
label variable pregnant "[3.2] Is the person pregnant?"
label variable preg_result1 "Pregnancy Test Results"
label variable suspect_hiv "Clinician suspects HIV infection on the person?"
label variable hiv "[3.3] Is the person HIV-infected? This should already be known for all adults but may not be for SAM Lusaka children.  If the person does not know their HIV status but would like to, refer them to local testing services and encourage them to return with their test result. "
label variable art "[3.4] For HIV-infected participants, are they currently taking ART?"
label variable art_yrs "[3.5] If on ART, how many years have they been on ART?"
label variable art_type "[3.6] We do not need much detail regarding the particular ART regimen but it would be useful to know about major types."
label variable art_type_others "Specify, ART type"
label variable diab "[3.7] Does the person have diabetes as diagnosed by a doctor?"
label variable diab_other "Specify any complications"
label variable diag_drug___0 "[3.8] If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought. (choice=None (includes advice, e.g., to lose weight))"
label variable diag_drug___1 "[3.8] If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought. (choice=Insulin)"
label variable diag_drug___2 "[3.8] If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought. (choice=Metformin)"
label variable diag_drug___3 "[3.8] If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought. (choice=Herbal or over-the-counter medicines)"
label variable diag_drug___4 "[3.8] If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought. (choice=Others {diag_drug_others:icons})"
label variable diag_drug____97 "[3.8] If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought. (choice=Dont know)"
label variable diag_drug____98 "[3.8] If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought. (choice=Refused)"
label variable diag_drug____99 "[3.8] If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought. (choice=Not applicable)"
label variable diag_drug____100 "[3.8] If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought. (choice=Pending information)"
label variable diag_drug____101 "[3.8] If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought. (choice=Forgot/Misplaced)"
label variable diag_drug____102 "[3.8] If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought. (choice=Participant absconded)"
label variable diag_drug____103 "[3.8] If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought. (choice=Equipment not available)"
label variable diag_drug____104 "[3.8] If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought. (choice=Less than Min)"
label variable diag_drug____105 "[3.8] If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought. (choice=More than Max)"
label variable diag_drug____106 "[3.8] If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought. (choice=Unclear utz/mri images)"
label variable diag_drug____107 "[3.8] If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought. (choice=Sample not enough/extracted)"
label variable diag_drug____108 "[3.8] If the person has been diagnosed with diabetes, what medication are they taking for it?  Check any medication bottles the person brought. (choice=Results invalid)"
label variable diag_drug_others "Specify other drugs"
label variable diag_yn "[3.9] Does the person have any other known diseases / conditions (pre-SAMPA), i.e. not including HIV or diabetes."
label variable diag_1 "[3.10] First diagnosis, i.e. the main complaint; see SOP 3 for more details "
label variable diag1_spec "Others, specify"
label variable diag_2 "[3.11] Second diagnosis"
label variable diag2_spec "Others, specify"
label variable diag_3 "[3.12] Third diagnosis"
label variable diag3_spec "Others, specify"
label variable diag_4 "[3.13] Fourth diagnosis"
label variable diag4_spec "Others, specify"
label variable lung_dis1 "Lung Disease"
label variable contissue_dis1 "Connective Tissue Disease"
label variable contissue_dis1_spec "Others, specify"
label variable peptic_ulcer1 "Peptic Ulcer"
label variable liver_dis1 "Liver Disease"
label variable kidney_dis1 "Chronic Kidney Disease"
label variable cancer1 "Cancer"
label variable lung_dis2 "Lung Disease"
label variable contissue_dis2 "Connective Tissue Disease"
label variable contissue_dis2_spec "Others, specify"
label variable peptic_ulcer2 "Peptic Ulcer"
label variable liver_dis2 "Liver Disease"
label variable kidney_dis2 "Chronic Kidney Disease"
label variable cancer2 "Cancer"
label variable lung_dis3 "Lung Disease"
label variable contissue_dis3 "Connective Tissue Disease"
label variable contissue_dis3_spec "Others, specify"
label variable peptic_ulcer3 "Peptic Ulcer"
label variable liver_dis3 "Liver Disease"
label variable kidney_dis3 "Chronic Kidney Disease"
label variable cancer3 "Cancer"
label variable lung_dis4 "Lung Disease"
label variable contissue_dis4 "Connective Tissue Disease"
label variable contissue_dis4_spec "Others, specify"
label variable peptic_ulcer4 "Peptic Ulcer"
label variable liver_dis4 "Liver Disease"
label variable kidney_dis4 "Chronic Kidney Disease"
label variable cancer4 "Cancer"
label variable hosp_freq "[3.14] How many times have they been admitted overnight in the last three years?"
label variable hosp_diag "[3.15] What were they in hospital for the most recent time they were there?"
label variable hosp_diag_others "Specify other"
label variable med "[3.16] Are they currently (within past 4 weeks) on any medication? "
label variable med_type___1 "[3.17] What type of medications do they take?  Do not include ART or diabetes medication since these are above. More than one other different medication can be listed. (choice=Tuberculosis medication)"
label variable med_type___2 "[3.17] What type of medications do they take?  Do not include ART or diabetes medication since these are above. More than one other different medication can be listed. (choice=Medications for other infections)"
label variable med_type___3 "[3.17] What type of medications do they take?  Do not include ART or diabetes medication since these are above. More than one other different medication can be listed. (choice=Statins)"
label variable med_type___4 "[3.17] What type of medications do they take?  Do not include ART or diabetes medication since these are above. More than one other different medication can be listed. (choice=Blood pressure medication)"
label variable med_type___5 "[3.17] What type of medications do they take?  Do not include ART or diabetes medication since these are above. More than one other different medication can be listed. (choice=Others {med_type_others:icons})"
label variable med_type____97 "[3.17] What type of medications do they take?  Do not include ART or diabetes medication since these are above. More than one other different medication can be listed. (choice=Dont know)"
label variable med_type____98 "[3.17] What type of medications do they take?  Do not include ART or diabetes medication since these are above. More than one other different medication can be listed. (choice=Refused)"
label variable med_type____99 "[3.17] What type of medications do they take?  Do not include ART or diabetes medication since these are above. More than one other different medication can be listed. (choice=Not applicable)"
label variable med_type____100 "[3.17] What type of medications do they take?  Do not include ART or diabetes medication since these are above. More than one other different medication can be listed. (choice=Pending information)"
label variable med_type____101 "[3.17] What type of medications do they take?  Do not include ART or diabetes medication since these are above. More than one other different medication can be listed. (choice=Forgot/Misplaced)"
label variable med_type____102 "[3.17] What type of medications do they take?  Do not include ART or diabetes medication since these are above. More than one other different medication can be listed. (choice=Participant absconded)"
label variable med_type____103 "[3.17] What type of medications do they take?  Do not include ART or diabetes medication since these are above. More than one other different medication can be listed. (choice=Equipment not available)"
label variable med_type____104 "[3.17] What type of medications do they take?  Do not include ART or diabetes medication since these are above. More than one other different medication can be listed. (choice=Less than Min)"
label variable med_type____105 "[3.17] What type of medications do they take?  Do not include ART or diabetes medication since these are above. More than one other different medication can be listed. (choice=More than Max)"
label variable med_type____106 "[3.17] What type of medications do they take?  Do not include ART or diabetes medication since these are above. More than one other different medication can be listed. (choice=Unclear utz/mri images)"
label variable med_type____107 "[3.17] What type of medications do they take?  Do not include ART or diabetes medication since these are above. More than one other different medication can be listed. (choice=Sample not enough/extracted)"
label variable med_type____108 "[3.17] What type of medications do they take?  Do not include ART or diabetes medication since these are above. More than one other different medication can be listed. (choice=Results invalid)"
label variable med_type_others "Specify other"
label variable thirst "Thirst"
label variable polyuria "Polyuria"
label variable fatigue "Fatigue"
label variable polydipsia "Polydipsia"
label variable blurred_vision "Blurred vision"
label variable numbness "Numbness or tingling in extremities"
label variable other_symptoms___1 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Extreme tiredness)"
label variable other_symptoms___2 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Shortness of breath)"
label variable other_symptoms___3 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Skin rash or itching)"
label variable other_symptoms___4 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Cough)"
label variable other_symptoms___5 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Chest pain)"
label variable other_symptoms___6 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Irregular heartbeat)"
label variable other_symptoms___7 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Fever)"
label variable other_symptoms___8 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Pain on swallowing)"
label variable other_symptoms___9 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Abdominal pain)"
label variable other_symptoms___10 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Nausea)"
label variable other_symptoms___11 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Vomiting)"
label variable other_symptoms___12 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Diarrhea)"
label variable other_symptoms___13 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Headache)"
label variable other_symptoms___14 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Visual changes)"
label variable other_symptoms___15 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Painful micturition)"
label variable other_symptoms___16 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Swollen ankles)"
label variable other_symptoms___17 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Other {symptoms_others:icons})"
label variable other_symptoms___18 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=None)"
label variable other_symptoms____97 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Dont know)"
label variable other_symptoms____98 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Refused)"
label variable other_symptoms____99 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Not applicable)"
label variable other_symptoms____100 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Pending information)"
label variable other_symptoms____101 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Forgot/Misplaced)"
label variable other_symptoms____102 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Participant absconded)"
label variable other_symptoms____103 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Equipment not available)"
label variable other_symptoms____104 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Less than Min)"
label variable other_symptoms____105 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=More than Max)"
label variable other_symptoms____106 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Unclear utz/mri images)"
label variable other_symptoms____107 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Sample not enough/extracted)"
label variable other_symptoms____108 "[3.19] Has the person in the past week had any of the following other symptoms? Up to 4 codes are allowed (choice=Results invalid)"
label variable symptoms_others "Specify other"
label variable med_exam___1 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=head, eye, ear, nose, throat)"
label variable med_exam___2 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=skin and hair)"
label variable med_exam___3 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=cardiac)"
label variable med_exam___4 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=chest)"
label variable med_exam___5 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=abdomen)"
label variable med_exam___6 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=neurological)"
label variable med_exam___7 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=extremities)"
label variable med_exam___8 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=none)"
label variable med_exam____97 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=Dont know)"
label variable med_exam____98 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=Refused)"
label variable med_exam____99 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=Not applicable)"
label variable med_exam____100 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=Pending information)"
label variable med_exam____101 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=Forgot/Misplaced)"
label variable med_exam____102 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=Participant absconded)"
label variable med_exam____103 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=Equipment not available)"
label variable med_exam____104 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=Less than Min)"
label variable med_exam____105 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=More than Max)"
label variable med_exam____106 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=Unclear utz/mri images)"
label variable med_exam____107 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=Sample not enough/extracted)"
label variable med_exam____108 "[3.20] Results of medical exam. Indicate up to 4 of the following systems with identified medical problems. (choice=Results invalid)"
label variable clin_summary "[3.21] This refers to the overall current health of the participant as determined from both recent morbidity and clinical exam, i.e. 3.18-3.20."
label variable exam_by "Examined By"
label variable sig_exam "Signature"
label variable sig_exam_upload "Upload MD signature"
label variable crf_3_clinical_histo_v_2 "Complete?"
label variable personnel10 "REDCap ID of Data Entry Personnel"
label variable timestamp10 "Date of Data Entry"
label variable clinic_date_referral "[10.1] Date of Clinic Visit [Participant was seen by the Doctor]"
label variable refer_reason "[10.2] There are several routes by which some participant may need to be assessed for referral to a specialist."
label variable radiol_refer "[10.3] What specialist does the radiologist or site clinician think the participant should be referred to?"
label variable radiol_refer_others "Others, specify"
label variable elastase_level "[10.4] Was the fecal elastase in the low (100-200 ug/g) or very low category (< 100 ug/g)?"
label variable fecal_fat "[10.5] Did the lab technician report seeing fat in the feces?"
label variable elastase_refer "[10.6] [Did the participant report any of the following in either CRF 3 or in the telephone call or meeting when followed up for the abnormal elastase result:  Chronic abdominal pain Chronic diarrhea Inability to stop losing weight "
label variable refer "[10.7] Has the patient been referred for evaluation by another physician or specialist?"
label variable refer_possible_diag___1 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Diabetes)"
label variable refer_possible_diag___2 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Kidney disease)"
label variable refer_possible_diag___3 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Heart disease)"
label variable refer_possible_diag___4 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=HIV known or possible)"
label variable refer_possible_diag___7 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Gastrointestinal disease)"
label variable refer_possible_diag___8 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Liver Disease)"
label variable refer_possible_diag___9 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Cancer)"
label variable refer_possible_diag___10 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Pancreatic insufficiency)"
label variable refer_possible_diag___5 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Unknown/No diagnosis)"
label variable refer_possible_diag___6 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Other)"
label variable refer_possible_diag____97 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Dont know)"
label variable refer_possible_diag____98 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Refused)"
label variable refer_possible_diag____99 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Not applicable)"
label variable refer_possible_diag____100 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Pending information)"
label variable refer_possible_diag____101 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Forgot/Misplaced)"
label variable refer_possible_diag____102 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Participant absconded)"
label variable refer_possible_diag____103 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Equipment not available)"
label variable refer_possible_diag____104 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Less than Min)"
label variable refer_possible_diag____105 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=More than Max)"
label variable refer_possible_diag____106 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Unclear utz/mri images)"
label variable refer_possible_diag____107 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Sample not enough/extracted)"
label variable refer_possible_diag____108 "[10.8] What does the project physician think is the likely problem, e.g. reason for referral? (choice=Results invalid)"
label variable refer_posdiag_o "[10.9] Other reason for referral, specify"
label variable refer_mri "Was the person referred after MRI scans were reviewed?"
label variable refer_uss "Was the person referred after Ultrasound scans were reviewed?"
label variable refer_diag___1 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Diabetes)"
label variable refer_diag___2 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Kidney disease)"
label variable refer_diag___3 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Heart disease)"
label variable refer_diag___4 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=HIV known or possible)"
label variable refer_diag___7 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Gastrointestinal disease)"
label variable refer_diag___8 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Liver Disease)"
label variable refer_diag___9 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Cancer)"
label variable refer_diag___10 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Pancreatic insufficiency)"
label variable refer_diag___5 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Unknown/No diagnosis)"
label variable refer_diag___6 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Others)"
label variable refer_diag____97 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Dont know)"
label variable refer_diag____98 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Refused)"
label variable refer_diag____99 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Not applicable)"
label variable refer_diag____100 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Pending information)"
label variable refer_diag____101 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Forgot/Misplaced)"
label variable refer_diag____102 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Participant absconded)"
label variable refer_diag____103 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Equipment not available)"
label variable refer_diag____104 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Less than Min)"
label variable refer_diag____105 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=More than Max)"
label variable refer_diag____106 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Unclear utz/mri images)"
label variable refer_diag____107 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Sample not enough/extracted)"
label variable refer_diag____108 "[10.10] Final diagnoses after work-up in a referral health facility  (choice=Results invalid)"
label variable refer_diag_others "[10.11] Other diagnosis from referral, specify"
label variable refer_place1 "[10.12] What clinic or hospital gave this final diagnosis?[Diabetes]"
label variable refer_place2 "[10.12] What clinic or hospital gave this final diagnosis?[Kidney Disease]"
label variable refer_place3 "[10.12] What clinic or hospital gave this final diagnosis?[Heart Disease]"
label variable refer_place4 "[10.12] What clinic or hospital gave this final diagnosis?[HIV known or possible]"
label variable refer_place7 "[10.12] What clinic or hospital gave this final diagnosis?[Gastrointestinal Disease]"
label variable refer_place8 "[10.12] What clinic or hospital gave this final diagnosis?[Liver Disease]"
label variable refer_place9 "[10.12] What clinic or hospital gave this final diagnosis?[Cancer]"
label variable refer_place10 "[10.12] What clinic or hospital gave this final diagnosis?[Pancreatic insufficiency]"
label variable refer_place5 "[10.12] What clinic or hospital gave this final diagnosis?[Unknown/No Diagnosis]"
label variable refer_place6 "[10.12] What clinic or hospital gave this final diagnosis?[Others]"
label variable crf_10_referral_complete "Complete?"
label variable personnel2 "REDCap ID of Data Entry Personnel"
label variable timestamp2 "Date of Data Entry"
label variable clinic_date_demo "[2.1] Date of clinic visit"
label variable marital "[2.4] Marital status"
label variable education "[2.5] Highest level of education reached by adult participant "
label variable edu_father "[2.6] Education of child participants father"
label variable edu_mother "[2.7] Education of child participants mother"
label variable edu_child "[2.8] Are you going to a government school or a fee-paying school?"
label variable employ "[2.9] Current occupation of adult participant?  If engaged in 2 jobs, consider the one that occupies most of his/her time and with higher salary or income. "
label variable employ_father "[2.10] Current occupation of child participants father  If engaged in 2 jobs, consider the one that occupies most of his/her time and with higher salary or income. "
label variable employ_mother "[2.11] Current occupation of child participants mother  If engaged in 2 jobs, consider the one that occupies most of his/her time and with higher salary or income. "
label variable num_reside "[2.14] How many people, including you, regularly sleep at this house?"
label variable dwelltype "[2.16] What is the type of dwelling unit of the household?"
label variable dwelltype_o "Others, specify"
label variable tenurhws "[2.17] What is the tenure status of the dwelling unit you are occupying?"
label variable tenurhws_o "Others, specify"
label variable house "[2.19] What is the main material used for the households dwelling unit?"
label variable house_o "Others, specify"
label variable rooms "[2.20] How many rooms in your household are used for sleeping?"
label variable cook "[2.21] Where do you usually cook?"
label variable cook_o "Others, specify"
label variable fuel "[2.22] What type of fuel does your household mainly use for cooking?"
label variable fuel_o "Others, specify"
label variable electric "[2.23] Do you have electricity in your house?"
label variable electric_o "Others, specify"
label variable water "[2.24] What is the main source of water  for household use (not for drinking)?"
label variable water_o "Others, specify"
label variable toilet "[2.26] What kind of toilet facility does the household usually use?"
label variable toilet_o "Others, specify"
label variable vcd "VCD/DVD Player/ DVD Player"
label variable tv "Television"
label variable ref "Refrigerator"
label variable wmachine "Washing machine / dryer "
label variable computer "Computer / Laptop / Game device "
label variable stove "Electric or gas cooking Stove / Range /Microwave oven "
label variable radio "Radio / radio cassette/ CD player  "
label variable phone "Landline Telephone "
label variable cellphone "Cellular phone"
label variable efan "Electric Fan"
label variable ac "Air conditioner/ Air cooler "
label variable sewing "Sewing Machine "
label variable cow "Carabao/ Cattle / Cow "
label variable pig "Swine / Pig / Ram "
label variable goat "Goat / Sheep"
label variable poultry_own "Chicken / duck / poultry "
label variable bike "Bicycle / Trisikad / Pedicab "
label variable motorcycle "Motorcycle  "
label variable car "Car/Jeep/van/truck "
label variable boat "Motorized boat / banca"
label variable tractor "Tractor"
label variable table "Table"
label variable chair "Chair"
label variable crf_2_demography_and_v_3 "Complete?"
label variable personnel12 "REDCap ID of Data Entry Personnel"
label variable timestamp12 "Date of Data Entry"
label variable clinic_date_diet "[12.1] Date of clinic visit"
label variable citrus "[12.2] Citrus fruits, e.g. orange, lemon, lime, sweet lime, kalamansi"
label variable berries "[12.3] Berries, e.g. strawberries, blackberries, jamun, litchi, wild fruit"
label variable bananas "[12.4] Bananas, i.e. fresh bananas, not fried which go under fried foods"
label variable apples "[12.5] Apples, pears, grapes"
label variable pineapples "[12.6] Pineapples "
label variable mango "[12.7] Mangoes, papaya, sapota, guava"
label variable melon "[12.8] Melons, any type including watermelons"
label variable dry_fruit "[12.10] Dried fruits, e.g. raisins, dates"
label variable fruit_oth "[12.9] Other fresh fruitsNote to data collector: Use the following format when specifying the name of the fruit. Right None if no other fruit was consumed.[name of fruit, frequency code], [name of fruit, frequency code]    Frequency Code Description   2 < 1 serving/week (small portions or rarely)   3 1 serving/week   4 2-3 servings / week   5 4-5 servings / week   6 6 or more servings / week    "
label variable tomato "[12.11] Tomatoes (including tomato sauce but not ketchup or tomato juice)"
label variable pepper "[12.12] Peppers "
label variable orange_veg "[12.13] Yellow-orange vegetables, e.g. carrots, orange sweet potato, pumpkin, yellow squashes"
label variable green_leafy "[12.14] Cooked or raw green leafy vegetables, e.g. spinach, chard, kale, malunggay, alugbati, chibwabwa, kalembula, katapa, mchicha"
label variable cruciferous "[12.15] Cruciferous vegetables, e.g. cauliflower, brocoli"
label variable gourd "[12.16] Cucumbers, gourd, zucchini (not the orange-yellow ones which are separate above for their vitamin A content"
label variable veg_oth "[12.17] Other vegetables but not including tubers, rice or other staplesNote to data collector: Use the following format when specifying the name of the vegetable. Right None if no other vegetable was consumed.[name of vegetable, frequency code], [name of vegetable, frequency code]    Frequency Code Description   2 < 1 serving/week (small portions or rarely)   3 1 serving/week   4 2-3 servings / week   5 4-5 servings / week   6 6 or more servings / week    "
label variable legumes "[12.18] Any dried beans or peas, e.g. lentils, chickpeas, white beans, soya nuggets, dal vadi"
label variable nuts_seeds "[12.19] Nuts, e.g. peanuts, almonds, walnuts, cashew nuts, seeds"
label variable red_meat "[12.20] Red meat, e.g. beef, goat, pork, lamb, bush meat; include boiled, roasted or in stews etc but not deep-fried since that is a later question"
label variable poultry "[12.21] Chicken or other poultry; include boiled, roasted or in stews etc but not deep-fried since that is a later question "
label variable processed_meat "[12.22] Processed meat, e.g. sausages, ham, salami, bacon, hotdogs, canned meats, canned/bottled tuna/sardines, smoked or dried fish"
label variable organ_meat "[12.23] Organ meats, e.g. kidney, liver, intestines, lungs, offals"
label variable fish "[12.24] Fish - any white or pinkish fish; include boiled, roasted or in stews etc but not deep-fried since that is a later question  "
label variable seafood "[12.25] Seafood, e.g. shellfish, shrimps, squid, oysters"
label variable eggs "[12.26] Eggs - whole eggs cooked in any way"
label variable milk "[12.27] Milk or buttermilk on their own "
label variable milk_tea "[12.28] Milk in tea or coffee"
label variable yogurt "[12.29] Yogurt, unsweetened"
label variable yogurt_sweet "[12.30] Yogurt, sweetened"
label variable yogurt_drink "[12.31] Sweetened yogurt drinks, e.g. Yakult, lassi "
label variable cheese "[12.32] Cheese, any type (eg home- made paneer)"
label variable icecream "[12.33] Ice cream (made with cream or milk)"
label variable dairy_oth "[12.34] Other dairy  "
label variable fruit_juice "[12.35] Fresh fruit juice - sweetened or unsweetened"
label variable soda "[12.36] Sodas or other sugar-sweetened beverages such as Indian sherbet"
label variable alcohol "[12.37] Alcohol - wine, beer, local beers, spirits  For people who indicate they drink alcohol at least 1 day/week, complete also Q 12.47. "
label variable fries "[12.38] Fries, chips (i.e. French fries), fried bananas"
label variable fried_meat "[12.39] Deep-fried red meat, chicken or fish; include both fried in batter and without batter but only deep-fried in large amounts of oil, not shallow fried in little oil"
label variable crisps "[12.40] Crisps, potato chips"
label variable crackers "[12.41] Crackers, savoury biscuits"
label variable samosas "[12.42] Samosas"
label variable pizza_burger "[12.43] Pizza, burgers  "
label variable savoury_oth "[12.44] Other savoury snacks (Pakora, bread pakora, namakpara, mathri, rusk, fan etc.) instant noodles"
label variable cake "[12.45] Cakes or pastries such as turnovers"
label variable cookies "[12.46] Cookies, sweet biscuits"
label variable pudding "[12.47] Puddings, e.g. milk puddings, fruit puddings, local ice creams made mainly with sugar, "
label variable candy "[12.48] Chocolate or candy, Indian sweets: Moti choor Laddoo, besan laddoo, Burfi, Jalebi, kaju Katli, gulab jamun, rasgulla, gujiya etc., sweetened fruits"
label variable street_food "[12.49] About how often each week do you eat snacks bought from street vendors or small takeway shops?"
label variable fast_food "[12.50] About how often each week do you eat food bought from fast food restaurants, e.g. MacDonalds, KFC or similar?"
label variable alcohol_amt "[12.51] For people who said they drink alcohol at least once a week (Q 12.33), how many days a week do they drink more than 2 standard drinks a day for women or 3 standard drinks a day for men? A standard drink is a glass/bottle/can or beer, a class of wine, or a shot of spirits."
label variable crf_12_diet_complete "Complete?"
label variable personnel6 "REDCap ID of Data Entry Personnel"
label variable timestamp6 "Date of Data Entry"
label variable clinic_date_anthro "[6.1] Date of clinic visit"
label variable systolic1 "What is the result of systolic blood pressure in mmHg?"
label variable systolic2 "What is the result of systolic blood pressure in mmHg?"
label variable systolic3 "What is the result of systolic blood pressure in mmHg?"
label variable diastolic1 "What is the result of diastolic blood pressure in mmHg?"
label variable diastolic2 "What is the result of diastolic blood pressure in mmHg?"
label variable diastolic3 "What is the result of diastolic blood pressure in mmHg?"
label variable weight1 "[6.2] Weight (kg to nearest 0.1 kg)"
label variable weight2 "[6.2] Weight (kg to nearest 0.1 kg)"
label variable weight3 "[6.2] Weight (kg to nearest 0.1 kg)"
label variable weight_unit "Unit of Measurement"
label variable height1 "[6.3] Standing height (cm to nearest 0.1 cm)"
label variable height2 "[6.3] Standing height (cm to nearest 0.1 cm)"
label variable height3 "[6.3] Standing height (cm to nearest 0.1 cm)"
label variable stand_unit "Unit of Measurement"
label variable sit_ht1 "[6.4] Sitting height (cm to nearest 0.1 cm) Measure height of seated person from floor; the box height is recorded in the next question and will be subtracted during analysis "
label variable sit_ht2 "[6.4] Sitting height (cm to nearest 0.1 cm) Measure height of seated person from floor; the box height is recorded in the next question and will be subtracted during analysis "
label variable sit_ht3 "[6.4] Sitting height (cm to nearest 0.1 cm) Measure height of seated person from floor; the box height is recorded in the next question and will be subtracted during analysis "
label variable sit_unit "Unit of Measurement"
label variable sit_box "[6.5] Height of the box used in the sitting height measurement (Measure to the nearest 0.1 cm)"
label variable sit_box_unit "Unit of Measurement"
label variable tibia1 "[6.6] Length of tibia (cm to nearest 0.1 cm)"
label variable tibia2 "[6.6] Length of tibia (cm to nearest 0.1 cm)"
label variable tibia3 "[6.6] Length of tibia (cm to nearest 0.1 cm)"
label variable tibia_unit "Unit of Measurement"
label variable grip_dominanthand "What is the participants dominant hand?"
label variable grip_measured_r1 "What is the gripstrength of right hand?"
label variable grip_measured_r2 "What is the gripstrength of right hand?"
label variable grip_measured_r3 "What is the gripstrength of right hand?"
label variable grip_unit_r "Unit of Measurement"
label variable grip_measured_l1 "What is gripstrength of the left hand? "
label variable grip_measured_l2 "What is gripstrength of the left hand? "
label variable grip_measured_l3 "What is gripstrength of the left hand? "
label variable grip_unit_l "Unit of Measurement"
label variable muac1 "[6.7] Mid-upper arm circumference (cm to nearest 0.1 cm) "
label variable muac2 "[6.7] Mid-upper arm circumference (cm to nearest 0.1 cm) "
label variable muac3 "[6.7] Mid-upper arm circumference (cm to nearest 0.1 cm) "
label variable muac_unit "Unit of Measurement"
label variable waist1 "[6.8] Waist circumference (cm to nearest 0.1 cm)"
label variable waist2 "[6.8] Waist circumference (cm to nearest 0.1 cm)"
label variable waist3 "[6.8] Waist circumference (cm to nearest 0.1 cm)"
label variable waist_unit "Unit of Measurement"
label variable hip1 "[6.9] Hip circumference (cm to nearest 0.1 cm)"
label variable hip2 "[6.9] Hip circumference (cm to nearest 0.1 cm)"
label variable hip3 "[6.9] Hip circumference (cm to nearest 0.1 cm)"
label variable hip_unit "Unit of Measurement"
label variable triceps1 "[6.10] Triceps skinfold (mm to nearest mm)"
label variable triceps2 "[6.10] Triceps skinfold (mm to nearest mm)"
label variable triceps3 "[6.10] Triceps skinfold (mm to nearest mm)"
label variable triceps_unit "Unit of Measurement"
label variable subscap1 "[6.11] Subscapular skinfold (mm to nearest mm)"
label variable subscap2 "[6.11] Subscapular skinfold (mm to nearest mm)"
label variable subscap3 "[6.11] Subscapular skinfold (mm to nearest mm)"
label variable subscap_unit "Unit of Measurement"
label variable anthro_prob "[6.12] Comment on any problems with anthropometry"
label variable menstruate "[6.13] Has she started menstruating yet?"
label variable menst_month "[6.14] If yes, how many months since she started? If unsure, an approximate answer is okay.  Use missing code (-98) if she doesnt want to say."
label variable tanner "[6.15] Tanner stage Mark 1, 2, 3, 4, or 5 if known"
label variable tanner_method "[6.16] Method used to determine Tanner stage"
label variable crf_6_anthropometry_complete "Complete?"
label variable personnel7 "REDCap ID of Data Entry Personnel"
label variable timestamp7 "Date of Data Entry"
label variable clinic_date_body "[7.1] Date of clinic visit"
label variable bia "[7.2] Was bioelectrical impedance done?"
label variable fm_kg "[7.3] BIA fat mass in kg to nearest 0.1 kg"
label variable ffm_kg "[7.4] BIA fat-free mass in kg to nearest 0.1 kg"
label variable fm_per "[7.5] BIA fat mass percent to 0.1 %"
label variable ffm_per "[7.6] BIA fat-free mass percent to 0.1%"
label variable impedance "[7.7] Total body impedance if the machine provides it; leave blank if not"
label variable bia_prob "[7.8] Were there any problems with the BIA?"
label variable bia_comment "[7.9] If there were problems, briefly describe"
label variable adp "[7.10] Was air displacement plethysmography (BodPod) done?   BodPod should be done for all adults but children who seem unwilling or who in the nurses view are unlikely to be able to keep still should not bother with it. "
label variable adpfm_kg "[7.11] ADP fat mass in kg to nearest 0.1 kg"
label variable adpffm_kg "[7.12] ADP fat-free mass in kg to nearest 0.1 kg"
label variable adpfm_per "[7.13] ADP fat mass percent to 0.1 %"
label variable adpffm_per "[7.14] ADP fat-free mass percent to 0.1%"
label variable adp_prob "[7.15] Were there any problems with the BodPod, e.g. child could not keep still enough?"
label variable adp_comment "[7.16] If there were problems, briefly describe"
label variable crf_7_body_compositi_v_4 "Complete?"
label variable personnel11 "REDCap ID of Data Entry Personnel"
label variable timestamp11 "Date of Data Entry"
label variable clinic_date_urine_feces "[11.1] Date of clinic visit"
label variable urine "[11.2] Did the participant provide a urine sample during the clinic visit?"
label variable urine_collect_dt "[11.1] Date of urine collection by participant"
label variable urine_time "At about what time was the urine sample collected? Use 24-hour clock"
label variable urine_ali_q "Urine Aliquot Q"
label variable urine_ali_r "Urine Aliquot R"
label variable feces "[11.10] Did the participant provide a fecal sample during the clinic visit? "
label variable flag_feces "Flag Feces Collection"
label variable feces_collect_dt "Date of fecal collection by participant"
label variable feces_time "[11.11] At about what time was the fecal sample collected? Use 24-hour clock"
label variable feces_ali_s "Feces Aliquot S"
label variable feces_ali_t "Feces Aliquot T"
label variable feces_ali_u "Feces Aliquot U"
label variable feces_temp "[11.12] Was the sample brought from home kept on ice or otherwise kept cool in transit? Note that if the ambient temperature is low, e.g. below 10oC, that counts as cool."
label variable feces_date "[11.13] Date arranged for fecal sample if none provided at the main clinic visit"
label variable feces_mode "On this date of next feces collection, will the participant bring it to the clinic or does it need to be picked up?"
label variable crf_11a_urine_and_fe_v_5 "Complete?"
label variable personnel111 "REDCap ID of Data Entry Personnel"
label variable timestamp111 "Date of Data Entry"
label variable u_collect "[11.14] Urine collected?"
label variable u_leucs "[11.3] Leucocytes"
label variable u_gluc "[11.4] Urine glucose"
label variable u_ketone "[11.5] Urine ketones"
label variable u_prot "[11.6] Urine protein"
label variable u_nitrite "[11.7] Urine nitrite"
label variable u_blood "[11.8] Urine blood"
label variable urine_problem "[11.9] Indicate any problem with urine collection or dipstick analysis, e.g. if woman was currently menstruating"
label variable feces_collect "[11.14] Feces collected?"
label variable fecal_elastase "[11.16] Fecal Elastase"
label variable feces_problem "[11.15] Indicate any problem with fecal collection "
label variable crf_11b_urine_and_fe_v_6 "Complete?"
label variable personnel41 "REDCap ID of Data Entry Personnel"
label variable timestamp41 "Date of Data Entry"
label variable ogttr_confirm "Does the participant need to repeat OGTT?"
label variable rogtt_unit "Unit of measurement"
label variable ogttr_time0 "[4.13] Time 0"
label variable ogttr_time0_1 "Sample ID of Time 0: Onsite EDTA"
label variable ogttr_sample_edta "[4.14] Fasting EDTA"
label variable ogttr_comments_time0 "[4.15] Explain any missing samples or problems in sample collection"
label variable rglu0 "Repeat OGTT result_Time0"
label variable rglu0_missing "Any problems?"
label variable rglu0_mis_specify "Others, specify"
label variable rhba1c "Repeat HbA1c result"
label variable ogttr_time30 "[4.13] Time 30"
label variable ogttr_time30_1 "Sample ID of Time 30: Onsite EDTA"
label variable ogttr_sample_edta30 "[4.14] 30 min EDTA"
label variable ogttr_comments_time30 "[4.15] Explain any missing samples or problems in sample collection"
label variable rglu30 "Repeat OGTT result_Time30"
label variable rglu30_missing "Any problems?"
label variable rglu30_mis_specify "Others, specify"
label variable ogttr_time120 "[4.13] Time 120"
label variable ogttr_time120_1 "Sample ID of Time 120: Onsite EDTA"
label variable ogttr_sample_edta120 "[4.14] 120 min EDTA"
label variable ogttr_comments_time120 "[4.15] Explain any missing samples or problems in sample collection"
label variable rglu120 "Repeat OGTT result_Time120"
label variable rglu120_missing "Any problems?"
label variable rglu120_mis_specify "Others, specify"
label variable mmol_rglu120 "Timepoint 120 Repeat OGTT glucose in mmol"
label variable high_glu120_2 "glucose 120 minutes > 11.1"
label variable dia_referral "[5.13] Does this person need to be referred to the site physician because their first and second OGTT indicate diabetes? Refer if the second test also has either: 1. HbA1c ≥ 6.5% 2. 120-minute glucose in OGTT > 11.1 mmol/L"
label variable glu_comment "[5.14] Comments on any problems"
label variable crf_4b_repeat_ogtt_complete "Complete?"
label variable personnel51 "REDCap ID of Data Entry Personnel"
label variable timestamp51 "Date of Data Entry"
label variable total_cho "Total Cholesterol"
label variable total_cho_prob "Any problems?"
label variable total_cho_prob_spec "Others, specify"
label variable ldl_cho "LDL Cholesterol"
label variable ldl_cho_prob "Any problems?"
label variable ldl_cho_prob_spec "Others, specify"
label variable hdl_cho "HDL Cholesterol"
label variable hdl_cho_prob "Any problems?"
label variable hdl_cho_prob_spec "Others, specify"
label variable trig "Triglycerides"
label variable trig_prob "Any problems?"
label variable trig_prob_spec "Others, specify"
label variable lipid_unit "Unit of Measurement"
label variable hgb "Hemoglobin [g/dl]"
label variable hgb_prob "Any problems?"
label variable hgb_prob_spec "Others, specify"
label variable rbc "Red Blood Cells (million/mm3) "
label variable rbc_prob "Any problems?"
label variable rbc_prob_spec "Others, specify"
label variable wbc "White Blood Cells (thousand/mm3)"
label variable wbc_prob "Any problems?"
label variable wbc_prob_spec "Others, specify"
label variable platelet "Platelets (thousand/mm3)"
label variable platelet_prob "Any problems?"
label variable platelet_prob_spec "Others, specify"
label variable lipase "Lipase"
label variable lipase_prob "Any problems?"
label variable lipase_prob_spec "Others, specify"
label variable crp "CRP"
label variable crp_prob "Any problems?"
label variable crp_prob_spec "Others, specify"
label variable crf_5_more_blood_tes_v_7 "Complete?"
label variable personnel14 "REDCap ID of Data Entry Personnel"
label variable timestamp14 "Date of Data Entry"
label variable ct_scan "Was a CT scan performed?"
label variable ct_date "Date of Examination"
label variable ct_time "Time of Examination"
label variable ct_pan_size_qual "[14.14] Qualitative indicator of pancreas size"
label variable ct_pan_head_trans "[14.15] Pancreas head size measured in transverse dimension **Score -106 if cant be measured due to image quality"
label variable ct_pan_head_ap "[14.16] Pancreas head size measured in anterior/posterior dimension **Score -106 if cant be measured due to image quality"
label variable ct_pan_body_trans "[14.17] Pancreas body size measures in anterior/posterior dimension; maximum diameter **Score -106 if cant be measured due to image quality"
label variable ct_pan_tail_trans "[14.18] Pancreas tail size measure in anterior/posterior dimension **Score -106 if cant be measured due to image quality"
label variable ct_pan_body_tail "[14.21] Length of Pancreas body and tail size measured in anterior/posterior dimension **Score -106 if cant be measured due to image quality"
label variable ct_pan_cc_body "[14.22] Diameter of Pancreas body measured in Cranial-Caudal **Score -106 if cant be measured due to image quality"
label variable ct_pan_cc_head "[14.23] Diameter of Pancreas head measured in Cranial-Caudal **Score -106 if cant be measured due to image quality"
label variable ct_pan_shape "[14.19] Pancreas shape"
label variable ct_pan_shape_problem "[14.110] For abnormal shape, specify the problem"
label variable ct_pan_shape_prob_spec "Other shape abnormality, specify"
label variable ct_pan_contour "[14.111] Pancreas contour"
label variable ct_pan_contour_problem "[14.112] For abnormal contour, specify the problem"
label variable ct_pan_contour_prob_spec "Other contour problem, specify"
label variable ct_pan_parenchyma "[14.113] Pancreatic Parenchyma"
label variable ct_pan_paren_inflam "[14.114] Pancreas shows signs of inflammation of edema"
label variable ct_pan_paren_fibrosis "[14.115] Pancreas shows signs of fibrosis"
label variable ct_pan_paren_steatosis "[14.116] Pancreas shows signs of steatosis"
label variable ct_pan_duct "[14.117] Pancreas Duct"
label variable ct_pan_duct_stones "[14.118] Stones detected in the duct"
label variable ct_pan_duct_mass "[14.119] Mass detected in the duct"
label variable ct_pan_calci "[14.120] Calcifications"
label variable ct_pan_calci_place "[14.121] If calcification is present, indicate where it is"
label variable ct_pan_oth_abnormal "[14.122] Any other abnormalities detected?"
label variable ct_pan_oth_abn_spec "Specify other abnormalities detected"
label variable ct_image_qual "[14.123] Was the CT scan optimal for obtaining the required information?"
label variable ct_problem "[14.124] Indicate why the CT scan not optimal"
label variable ct_problem_why "If non-optimal specify why"
label variable name_ct "Name of Radiologist"
label variable sig_ct "Signature"
label variable sig_ct_upload "Upload radiologist signature"
label variable file_ct "Upload DICOM file"
label variable file_ct2 "Upload DICOM file"
label variable file_ct3 "Upload DICOM file"
label variable file_ct4 "Upload DICOM file"
label variable file_ct5 "Upload DICOM file"
label variable file_ct6 "Upload DICOM file"
label variable file_ct7 "Upload DICOM file"
label variable file_ct8 "Upload DICOM file"
label variable file_ct9 "Upload DICOM file"
label variable file_ct10 "Upload DICOM file"
label variable crf_14_computed_tomo_v_8 "Complete?"
label variable personnel15 "REDCap ID of Data Entry Personnel"
label variable timestamp15 "Date of Data Entry"
label variable ivgtt_time_ne10 "Time -10 minutes"
label variable ivgtt_time_ne1 "Time -1 minutes"
label variable ivgtt_time_2 "Time 2 minutes"
label variable ivgtt_time_4 "Time 4 minutes"
label variable ivgtt_time_6 "Time 6 minutes"
label variable ivgtt_time_8 "Time 8 minutes"
label variable ivgtt_time_10 "Time 10 minutes"
label variable ivgtt_ne10 "IVGTT Result -10 minutes"
label variable ivgtt_ne1 "IVGTT Result -1 minutes"
label variable ivgtt_2 "IVGTT Result 2 minutes"
label variable ivgtt_4 "IVGTT Result 4 minutes"
label variable ivgtt_6 "IVGTT Result 6 minutes"
label variable ivgtt_8 "IVGTT Result 8 minutes"
label variable ivgtt_10 "IVGTT Result 10 minutes"
label variable ivtime_ne10_l "Sample ID of Time -10: Aliquot L (EDTA)"
label variable ivtime_ne10_m "Sample ID of Time -10: Aliquot M (EDTA)"
label variable ivtime_ne10_n "Sample ID of Time -10: Aliquot N (EDTA)"
label variable ivtime_ne10_p "Sample ID of Time -10: Aliquot P (EDTA)"
label variable ivtime_ne1_l "Sample ID of Time -1: Aliquot L (EDTA)"
label variable ivtime_ne1_m "Sample ID of Time -1: Aliquot M (EDTA)"
label variable ivtime_ne1_n "Sample ID of Time -1: Aliquot N (EDTA)"
label variable ivtime_ne1_p "Sample ID of Time -1: Aliquot P (EDTA)"
label variable ivtime_2_l "Sample ID of Time 2: Aliquot L (EDTA)"
label variable ivtime_2_m "Sample ID of Time 2: Aliquot M (EDTA)"
label variable ivtime_2_n "Sample ID of Time 2: Aliquot N (EDTA)"
label variable ivtime_2_p "Sample ID of Time 2: Aliquot P (EDTA)"
label variable ivtime_4_l "Sample ID of Time 4: Aliquot L (EDTA)"
label variable ivtime_4_m "Sample ID of Time 4: Aliquot M (EDTA)"
label variable ivtime_4_n "Sample ID of Time 4: Aliquot N (EDTA)"
label variable ivtime_4_p "Sample ID of Time 4: Aliquot P (EDTA)"
label variable ivtime_6_l "Sample ID of Time 6: Aliquot L (EDTA)"
label variable ivtime_6_m "Sample ID of Time 6: Aliquot M (EDTA)"
label variable ivtime_6_n "Sample ID of Time 6: Aliquot N (EDTA)"
label variable ivtime_6_p "Sample ID of Time 6: Aliquot P (EDTA)"
label variable ivtime_8_l "Sample ID of Time 8: Aliquot L (EDTA)"
label variable ivtime_8_m "Sample ID of Time 8: Aliquot M (EDTA)"
label variable ivtime_8_n "Sample ID of Time 8: Aliquot N (EDTA)"
label variable ivtime_8_p "Sample ID of Time 8: Aliquot P (EDTA)"
label variable ivtime_10_l "Sample ID of Time 10: Aliquot L (EDTA)"
label variable ivtime_10_m "Sample ID of Time 10: Aliquot M (EDTA)"
label variable ivtime_10_n "Sample ID of Time 10: Aliquot N (EDTA)"
label variable ivtime_10_p "Sample ID of Time 10: Aliquot P (EDTA)"
label variable ivgtt_complete "Complete?"

label variable record_id "Database ID"
label variable redcap_data_access_group "Redcap data access group"
label variable personnel13 "REDCap ID of Data Entry Personnel for CRF13"
label variable timestamp13 "CRF13's Last Update Date"

label variable sampa_id "SAMPA ID"
label variable orgid "Cohort ID"

label variable age "Age"
label variable dob "Date of Birth"

label  variable uss_sample "Are they in the Ultrasound subsample?"

label define uss_sample 1 "Yes" 0 "No" 
label values uss_sample uss_sample


label variable cohort "Cohort"
label define cohort 1 "DIVIDS" 2 "SAM" 3 "CICADA" 4 "NUSTART" 5 "STATT" 6 "CLHNS"
label values cohort cohort

label variable sex "Sex"
label define sex 1 "Male" 2 "Female" 
label values sex sex

label variable radio_exam "Was a radiological examination performed?"
label define radio_exam 0 " No" 1 "Yes" -99 "Refused" -100 "Pending" -102 "Absconded" -103 "Equipment NA"
label values radio_exam radio_exam

label variable date_exam_uss "Date of Examination"
label variable time_exam_uss "Time of Examination"

label variable pan_size_head "OLD VARIABLE: Pancreatic Size in CM (Head)"
label variable pan_size_body "OLD VARIABLE: Pancreatic Size in CM (Body)"
label variable pan_size_tail "OLD VARIABLE: Pancreatic Size in CM (Tail)"

label variable pan_size_normal "OLD VARIABLE: Pancreatic Size"
label define pan_size_normal 1 "Normal" 2 "Abnormal"
label values pan_size_normal pan_size_normal

label variable pan_size_ab_why "OLD VARIABLE: If abnormal specify"

label variable pan_size_qual "Qualitative indicator of pancreas size"
label define pan_size_qual 1 "Normal" 2 "Small" 3 "Enlarged" 4 "Can't see well enough to tell"
label values pan_size_qual pan_size_qual

label variable pan_head_trans "Pancreas head size measured in transverse dimension"
label variable pan_head_ap "Pancreas head size measured in anterior/posterior dimension"
label variable pan_body_trans "Pancreas body size measures in anterior/posterior dimension; maximum diameter"
label variable pan_tail_trans "Pancreas tail size measure in anterior/posterior dimension"

label variable pan_shape "Pancreas shape"
label define pan_shape 1 "Normal" 2 "Abnormal" 3 "Can't see well enough to tell" 
label values pan_shape pan_shape

label variable pan_shape_problem "For abnormal shape, specify the problem"
label define pan_shape_problem 1 "Imbalance in size of head compared to tail" 2 "Other shape abnormality, specify"
label values pan_shape_problem pan_shape_problem

label variable pan_shape_prob_specify "Other shape abnormality, specify"

label variable pan_contour "Pancreas contour"
label define pan_contour 1 "Normal/Smooth" 2 "Abnormal" 3 "Can't see well enough to tell" 
label values pan_contour pan_contour

label variable pan_contour_problem "For abnormal contour, specify the problem"
label define pan_contour_problem 1 "Irregular border" 2 "Lobulated" 3 "Other contour problem, specify"
label values pan_contour_problem pan_contour_problem

label variable pan_contour_prob_specify "Other contour problem, specify"

label variable pan_parenchyma "Pancreatic Parenchyma"
label define pan_parenchyma 1 "Normal" 2 "Abnormal" 3 "Can't see well enough to tell" 
label values pan_parenchyma pan_parenchyma

label variable parenchyma_ab_why "OLD VARIABLE: If abnormal specify"
label variable pan_paren_inflam "Pancreas shows signs of inflammation of edema"
label define pan_paren_inflam 0 " No" 1 "Yes"
label values pan_paren_inflam pan_paren_inflam

label variable pan_paren_fibrosis "Pancreas shows signs of fibrosis"
label define pan_paren_fibrosis 0 " No" 1 "Yes"
label values pan_paren_fibrosis pan_paren_fibrosis

label variable pan_paren_steatosis "Pancreas shows signs of steatosis"
label define pan_paren_steatosis 0 " No" 1 "Yes"
label values pan_paren_steatosis pan_paren_steatosis

label variable pan_duct_normal "OLD VARIABLE: Pancreatic Duct Size"
label define pan_duct_normal 1 "Normal" 2 "Abnormal"  
label values pan_duct_normal pan_duct_normal

label variable pan_duct_ab "OLD VARIABLE: If abnormal specify"

label variable pan_duct "Pancreas Duct"
label define pan_duct 1 "Normal" 2 "Abnormal" 3 "Can't see well enough to tell" 
label values pan_duct pan_duct

label variable pan_duct_stones "Stones detected in the duct"
label define pan_duct_stones 0 " No" 1 "Yes"
label values pan_duct_stones pan_duct_stones

label variable pan_duct_mass "Mass detected in the duct"
label define pan_duct_mass 0 " No" 1 "Yes"
label values pan_duct_mass pan_duct_mass

label variable pan_peri_normal "OLD VARIABLE: Peri-pancreatic Vessels"
label define pan_peri_normal 1 "Normal" 2 "Abnormal"  
label values pan_peri_normal pan_peri_normal

label variable pan_peri_ab "OLD VARIABLE: If abnormal specify"

label variable pan_calci "Calcifications"
label define pan_calci 0 "Absent" 1 "Present" 3 "Can't see well enough to tell"
label values pan_calci pan_calci

label variable pan_calci_yes "OLD VARIABLE: Calcifications if yes specify"

label variable pan_calci_place "If calcification is present, indicate where it is"
label define pan_calci_place 1 " Parenchymal" 2 "Peripancreatic"  
label values pan_calci_place pan_calci_place

label variable pan_cyst "OLD VARIABLE: Cyst(s)"
label define pan_cyst 0 " No" 1 "Yes"
label values pan_cyst pan_cyst

label variable pan_cyst_yes "If yes specify"

label variable pan_collect "OLD VARIABLE: Collection(s)"
label define pan_collect 0 " No" 1 "Yes"
label values pan_collect pan_collect

label variable pan_collect_yes "OLD VARIABLE: If yes specify"

label variable pan_fluid "OLD VARIABLE: Free Fluid"
label define pan_fluid 0 " No" 1 "Yes"
label values pan_fluid pan_fluid

label variable pan_fluid_yes "OLD VARIABLE: If yes specify"

label variable pan_masses "OLD VARIABLE: Masses"
label define pan_masses 0 "No" 1 "Yes"
label values pan_masses pan_masses

label variable pan_masses_yes "OLD VARIABLE: If yes specify"

label variable pan_others "OLD VARIABLE: Other findings, specify"
label variable pan_con "OLD VARIABLE: Conclusion"

label variable pan_oth_abnormal "Any other abnormalities detected?"
label define pan_oth_abnormal 0 "No" 1 "Yes, specify"
label values pan_oth_abnormal pan_oth_abnormal

label variable pan_oth_abn_specify "Specify other abnormalities detected"

label variable image_qual_uss "Was the ultrasound scan optimal for obtaining the required information?"
label define image_qual_uss 1 "Optimal" 2 "Non-optimal"
label values image_qual_uss image_qual_uss

label variable image_not_optimal "Indicate why the ultrasound scan not optimal"
label define image_not_optimal 1 "Bowel gas" 2 "Obese participant" 3 "Participant uncooperative" 4 "Others, specify"
label values image_not_optimal image_not_optimal

label variable image_non_why "If non-optimal specify why"

label variable uss_problem "OLD VARIABLE: Were there problems obtaining good ultrasound data?"
label define uss_problem 0 "No" 1 "Yes"
label values uss_problem uss_problem

label variable uss_problem_specify "OLD VARIABLE: If yes, specify"

label variable name_radio "Name of Radiologist"
label variable sig_radio "Signature"
label variable sig_uss_upload "Upload radiologist signature"
label variable file_uss "Upload DICOM fi le"
label variable file_uss2 "Upload DICOM fi le"
label variable file_uss3 "Upload DICOM fi le"
label variable file_uss4 "Upload DICOM fi le"
label variable file_uss5 "Upload DICOM fi le"
label variable file_uss6 "Upload DICOM fi le"
label variable file_uss7 "Upload DICOM fi le"
label variable file_uss8 "Upload DICOM fi le"
label variable file_uss9 "Upload DICOM fi le"
label variable file_uss10 "Upload DICOM fi le"
label variable crf_13_abdomen_uss_complete "Crf 13 Abdomen Uss status"



order record_id redcap_data_access_group personnel timestamp languages cohort incorrect_cohort sampa_id orgid first middle last sex dob age confirm___1 confirm____97 confirm____98 confirm____99 confirm____100 confirm____101 confirm____102 confirm____103 confirm____104 confirm____105 confirm____106 confirm____107 confirm____108 gr_date1 tr_contact1 tr_method1 tr_reas_noc_phone1 tr_reas_other1 gr_date2 tr_contact2 tr_method2 tr_reas_noc_phone2 tr_reas_other2 gr_date3 tr_contact3 tr_method3 tr_reas_noc_phone3 tr_reas_other3 agree disagree_why cohort_tracing_complete personnel1 timestamp1 control cont_age cont_site cont_mald cont_hiv_test cont_art cont_art_yrs explain___1 rec_diab rec_diab_drug___0 rec_diab_drug___1 rec_diab_drug___2 rec_diab_drug___3 rec_diab_drug___4 rec_diab_drug____97 rec_diab_drug____98 rec_diab_drug____99 rec_diab_drug____100 rec_diab_drug____101 rec_diab_drug____102 rec_diab_drug____103 rec_diab_drug____104 rec_diab_drug____105 rec_diab_drug____106 rec_diab_drug____107 rec_diab_drug____108 insulin_dep flag_insulin consent_basic assent preg_test preg_result flag_preg indepth_sample indepth_exp flag_group mri_sample mri ct_sample ct xray_sample xray ivgtt_sample ivgtt uss_sample uss file_consent crf_1_eligibility_co_v_0 personnel13 timestamp13 radio_exam date_exam_uss time_exam_uss pan_size_head pan_size_body pan_size_tail pan_size_normal pan_size_ab_why pan_size_qual pan_head_trans pan_head_ap pan_body_trans pan_tail_trans pan_shape pan_shape_problem pan_shape_prob_specify pan_contour pan_contour_problem pan_contour_prob_specify pan_parenchyma parenchyma_ab_why pan_paren_inflam pan_paren_fibrosis pan_paren_steatosis pan_duct_normal pan_duct_ab pan_duct pan_duct_stones pan_duct_mass pan_peri_normal pan_peri_ab pan_calci pan_calci_yes pan_calci_place pan_cyst pan_cyst_yes pan_collect pan_collect_yes pan_fluid pan_fluid_yes pan_masses pan_masses_yes pan_others pan_con pan_oth_abnormal pan_oth_abn_specify image_qual_uss image_not_optimal image_non_why uss_problem uss_problem_specify name_radio sig_radio sig_uss_upload file_uss file_uss2 file_uss3 file_uss4 file_uss5 file_uss6 file_uss7 file_uss8 file_uss9 file_uss10 crf_13_abdomen_uss_complete personnel4 timestamp4 clinic_date_ogtt sample_gp standard_ogtt fasting ogtt_unit ogtt_time0 time0_w time0_x time0_y time0_z time0_a time0_b time0_c time0_e time0_f time0_g time0_h time0_j time0_k ogtt_sample_serum ogtt_sample_edta0 ogtt_sample_apro0 ogtt_sample_edta0_cold ogtt_comment_time0 hba1c glu0 mmol_glu0 out_glu0 glu0_missing glu0_mis_specify cpeptide0 insulin0 ogtt_time15 time15_z time15_a time15_b time15_c ogtt_sample_edta15 ogtt_comment_time15 glu15 mmol_glu15 out_glu15 glu15_missing glu15_mis_specify cpeptide15 insulin15 ogtt_time30 time30_z time30_a time30_b time30_c time30_e time30_f time30_g time30_h time30_j time30_k ogtt_sample_edta30 ogtt_sample_apro30 ogtt_sample_edta30_cold ogtt_comment_time30 glu30 mmol_glu30 out_glu30 glu30_missing glu30_mis_specify cpeptide30 insulin30 ogtt_time45 time45_z time45_a time45_b time45_c ogtt_sample_edta45 ogtt_comment_time45 glu45 mmol_glu45 out_glu45 glu45_missing glu45_mis_specify cpeptide45 insulin45 ogtt_time60 time60_z time60_a time60_b time60_c time60_e time60_f time60_g time60_h time60_j time60_k ogtt_sample_edta60 ogtt_sample_apro60 ogtt_sample_edta60_cold ogtt_comment_time60 glu60 mmol_glu60 out_glu60 glu60_missing glu60_mis_specify cpeptide60 insulin60 ogtt_time90 time90_z time90_a time90_b time90_c time90_e time90_f time90_g time90_h time90_j time90_k ogtt_sample_edta90 ogtt_sample_apro90 ogtt_sample_edta90_cold ogtt_comment_time90 glu90 mmol_glu90 out_glu90 glu90_missing glu90_mis_specify cpeptide90 insulin90 ogtt_time120 time120_z time120_a time120_b time120_c time120_e time120_f time120_g time120_h time120_j time120_k ogtt_sample_edta120 ogtt_sample_apro120 ogtt_sample_edta120_cold ogtt_comment_time120 glu120 mmol_glu120 out_glu120 glu120_missing glu120_mis_specify cpeptide120 insulin120 high_hba1c_1 high_glu120_1 repeat_test_needed repeat_date crf_4a_blood_samplin_v_1 personnel3 timestamp3 clinic_date_history pregnant preg_result1 suspect_hiv hiv art art_yrs art_type art_type_others diab diab_other diag_drug___0 diag_drug___1 diag_drug___2 diag_drug___3 diag_drug___4 diag_drug____97 diag_drug____98 diag_drug____99 diag_drug____100 diag_drug____101 diag_drug____102 diag_drug____103 diag_drug____104 diag_drug____105 diag_drug____106 diag_drug____107 diag_drug____108 diag_drug_others diag_yn diag_1 diag1_spec diag_2 diag2_spec diag_3 diag3_spec diag_4 diag4_spec lung_dis1 contissue_dis1 contissue_dis1_spec peptic_ulcer1 liver_dis1 kidney_dis1 cancer1 lung_dis2 contissue_dis2 contissue_dis2_spec peptic_ulcer2 liver_dis2 kidney_dis2 cancer2 lung_dis3 contissue_dis3 contissue_dis3_spec peptic_ulcer3 liver_dis3 kidney_dis3 cancer3 lung_dis4 contissue_dis4 contissue_dis4_spec peptic_ulcer4 liver_dis4 kidney_dis4 cancer4 hosp_freq hosp_diag hosp_diag_others med med_type___1 med_type___2 med_type___3 med_type___4 med_type___5 med_type____97 med_type____98 med_type____99 med_type____100 med_type____101 med_type____102 med_type____103 med_type____104 med_type____105 med_type____106 med_type____107 med_type____108 med_type_others thirst polyuria fatigue polydipsia blurred_vision numbness other_symptoms___1 other_symptoms___2 other_symptoms___3 other_symptoms___4 other_symptoms___5 other_symptoms___6 other_symptoms___7 other_symptoms___8 other_symptoms___9 other_symptoms___10 other_symptoms___11 other_symptoms___12 other_symptoms___13 other_symptoms___14 other_symptoms___15 other_symptoms___16 other_symptoms___17 other_symptoms___18 other_symptoms____97 other_symptoms____98 other_symptoms____99 other_symptoms____100 other_symptoms____101 other_symptoms____102 other_symptoms____103 other_symptoms____104 other_symptoms____105 other_symptoms____106 other_symptoms____107 other_symptoms____108 symptoms_others med_exam___1 med_exam___2 med_exam___3 med_exam___4 med_exam___5 med_exam___6 med_exam___7 med_exam___8 med_exam____97 med_exam____98 med_exam____99 med_exam____100 med_exam____101 med_exam____102 med_exam____103 med_exam____104 med_exam____105 med_exam____106 med_exam____107 med_exam____108 clin_summary exam_by sig_exam sig_exam_upload crf_3_clinical_histo_v_2 personnel10 timestamp10 clinic_date_referral refer_reason radiol_refer radiol_refer_others elastase_level fecal_fat elastase_refer refer refer_possible_diag___1 refer_possible_diag___2 refer_possible_diag___3 refer_possible_diag___4 refer_possible_diag___7 refer_possible_diag___8 refer_possible_diag___9 refer_possible_diag___10 refer_possible_diag___5 refer_possible_diag___6 refer_possible_diag____97 refer_possible_diag____98 refer_possible_diag____99 refer_possible_diag____100 refer_possible_diag____101 refer_possible_diag____102 refer_possible_diag____103 refer_possible_diag____104 refer_possible_diag____105 refer_possible_diag____106 refer_possible_diag____107 refer_possible_diag____108 refer_posdiag_o refer_mri refer_uss refer_diag___1 refer_diag___2 refer_diag___3 refer_diag___4 refer_diag___7 refer_diag___8 refer_diag___9 refer_diag___10 refer_diag___5 refer_diag___6 refer_diag____97 refer_diag____98 refer_diag____99 refer_diag____100 refer_diag____101 refer_diag____102 refer_diag____103 refer_diag____104 refer_diag____105 refer_diag____106 refer_diag____107 refer_diag____108 refer_diag_others refer_place1 refer_place2 refer_place3 refer_place4 refer_place7 refer_place8 refer_place9 refer_place10 refer_place5 refer_place6 crf_10_referral_complete personnel2 timestamp2 clinic_date_demo marital education edu_father edu_mother edu_child employ employ_father employ_mother num_reside dwelltype dwelltype_o tenurhws tenurhws_o house house_o rooms cook cook_o fuel fuel_o electric electric_o water water_o toilet toilet_o vcd tv ref wmachine computer stove radio phone cellphone efan ac sewing cow pig goat poultry_own bike motorcycle car boat tractor table chair crf_2_demography_and_v_3 personnel12 timestamp12 clinic_date_diet citrus berries bananas apples pineapples mango melon dry_fruit fruit_oth tomato pepper orange_veg green_leafy cruciferous gourd veg_oth legumes nuts_seeds red_meat poultry processed_meat organ_meat fish seafood eggs milk milk_tea yogurt yogurt_sweet yogurt_drink cheese icecream dairy_oth fruit_juice soda alcohol fries fried_meat crisps crackers samosas pizza_burger savoury_oth cake cookies pudding candy street_food fast_food alcohol_amt crf_12_diet_complete personnel6 timestamp6 clinic_date_anthro systolic1 systolic2 systolic3 diastolic1 diastolic2 diastolic3 weight1 weight2 weight3 weight_unit height1 height2 height3 stand_unit sit_ht1 sit_ht2 sit_ht3 sit_unit sit_box sit_box_unit tibia1 tibia2 tibia3 tibia_unit grip_dominanthand grip_measured_r1 grip_measured_r2 grip_measured_r3 grip_unit_r grip_measured_l1 grip_measured_l2 grip_measured_l3 grip_unit_l muac1 muac2 muac3 muac_unit waist1 waist2 waist3 waist_unit hip1 hip2 hip3 hip_unit triceps1 triceps2 triceps3 triceps_unit subscap1 subscap2 subscap3 subscap_unit anthro_prob menstruate menst_month tanner tanner_method crf_6_anthropometry_complete personnel7 timestamp7 clinic_date_body bia fm_kg ffm_kg fm_per ffm_per impedance bia_prob bia_comment adp adpfm_kg adpffm_kg adpfm_per adpffm_per adp_prob adp_comment crf_7_body_compositi_v_4 personnel11 timestamp11 clinic_date_urine_feces urine urine_collect_dt urine_time urine_ali_q urine_ali_r feces flag_feces feces_collect_dt feces_time feces_ali_s feces_ali_t feces_ali_u feces_temp feces_date feces_mode crf_11a_urine_and_fe_v_5 personnel111 timestamp111 u_collect u_leucs u_gluc u_ketone u_prot u_nitrite u_blood urine_problem feces_collect fecal_elastase feces_problem crf_11b_urine_and_fe_v_6 personnel41 timestamp41 ogttr_confirm rogtt_unit ogttr_time0 ogttr_time0_1 ogttr_sample_edta ogttr_comments_time0 rglu0 rglu0_missing rglu0_mis_specify rhba1c ogttr_time30 ogttr_time30_1 ogttr_sample_edta30 ogttr_comments_time30 rglu30 rglu30_missing rglu30_mis_specify ogttr_time120 ogttr_time120_1 ogttr_sample_edta120 ogttr_comments_time120 rglu120 rglu120_missing rglu120_mis_specify mmol_rglu120 high_glu120_2 dia_referral glu_comment crf_4b_repeat_ogtt_complete personnel51 timestamp51 total_cho total_cho_prob total_cho_prob_spec ldl_cho ldl_cho_prob ldl_cho_prob_spec hdl_cho hdl_cho_prob hdl_cho_prob_spec trig trig_prob trig_prob_spec lipid_unit hgb hgb_prob hgb_prob_spec rbc rbc_prob rbc_prob_spec wbc wbc_prob wbc_prob_spec platelet platelet_prob platelet_prob_spec lipase lipase_prob lipase_prob_spec crp crp_prob crp_prob_spec crf_5_more_blood_tes_v_7 personnel14 timestamp14 ct_scan ct_date ct_time ct_pan_size_qual ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head ct_pan_shape ct_pan_shape_problem ct_pan_shape_prob_spec ct_pan_contour ct_pan_contour_problem ct_pan_contour_prob_spec ct_pan_parenchyma ct_pan_paren_inflam ct_pan_paren_fibrosis ct_pan_paren_steatosis ct_pan_duct ct_pan_duct_stones ct_pan_duct_mass ct_pan_calci ct_pan_calci_place ct_pan_oth_abnormal ct_pan_oth_abn_spec ct_image_qual ct_problem ct_problem_why name_ct sig_ct sig_ct_upload file_ct file_ct2 file_ct3 file_ct4 file_ct5 file_ct6 file_ct7 file_ct8 file_ct9 file_ct10 crf_14_computed_tomo_v_8 personnel15 timestamp15 ivgtt_time_ne10 ivgtt_time_ne1 ivgtt_time_2 ivgtt_time_4 ivgtt_time_6 ivgtt_time_8 ivgtt_time_10 ivgtt_ne10 ivgtt_ne1 ivgtt_2 ivgtt_4 ivgtt_6 ivgtt_8 ivgtt_10 ivtime_ne10_l ivtime_ne10_m ivtime_ne10_n ivtime_ne10_p ivtime_ne1_l ivtime_ne1_m ivtime_ne1_n ivtime_ne1_p ivtime_2_l ivtime_2_m ivtime_2_n ivtime_2_p ivtime_4_l ivtime_4_m ivtime_4_n ivtime_4_p ivtime_6_l ivtime_6_m ivtime_6_n ivtime_6_p ivtime_8_l ivtime_8_m ivtime_8_n ivtime_8_p ivtime_10_l ivtime_10_m ivtime_10_n ivtime_10_p ivgtt_complete 
set more off
describe

exit


//Imaging cleaning 
//Utz and CT cleaning
keep if redcap_data_access_group=="5statt" | redcap_data_access_group=="6clhns" 
keep record_id redcap_data_access_group personnel timestamp languages cohort incorrect_cohort sampa_id orgid mri ct xray uss personnel13 timestamp13 radio_exam date_exam_uss time_exam_uss pan_size_head pan_size_body pan_size_tail pan_size_normal pan_size_ab_why pan_size_qual pan_head_trans pan_head_ap pan_body_trans pan_tail_trans pan_shape pan_shape_problem pan_shape_prob_specify pan_contour pan_contour_problem pan_contour_prob_specify pan_parenchyma parenchyma_ab_why pan_paren_inflam pan_paren_fibrosis pan_paren_steatosis pan_duct_normal pan_duct_ab pan_duct pan_duct_stones pan_duct_mass pan_peri_normal pan_peri_ab pan_calci pan_calci_yes pan_calci_place pan_cyst pan_cyst_yes pan_collect pan_collect_yes pan_fluid pan_fluid_yes pan_masses pan_masses_yes pan_others pan_con pan_oth_abnormal pan_oth_abn_specify image_qual_uss image_not_optimal image_non_why uss_problem uss_problem_specify name_radio sig_radio sig_uss_upload file_uss file_uss2 file_uss3 file_uss4 file_uss5 file_uss6 file_uss7 file_uss8 file_uss9 file_uss10 personnel14 timestamp14  ct_scan ct_date ct_time ct_pan_size_qual ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head ct_pan_shape ct_pan_shape_problem ct_pan_shape_prob_spec ct_pan_contour ct_pan_contour_problem ct_pan_contour_prob_spec ct_pan_parenchyma ct_pan_paren_inflam ct_pan_paren_fibrosis ct_pan_paren_steatosis ct_pan_duct ct_pan_duct_stones ct_pan_duct_mass ct_pan_calci ct_pan_calci_place ct_pan_oth_abnormal ct_pan_oth_abn_spec ct_image_qual ct_problem ct_problem_why name_ct sig_ct sig_ct_upload file_ct file_ct2 file_ct3 file_ct4 file_ct5 file_ct6 file_ct7 file_ct8 file_ct9 file_ct10 


clear 
use "/Users/sharoncox/Cox working group Dropbox/TB Nutrition working group/SAMPA/DATA monitoring/Data/SAMPA/All_crf13_Abdomen_Uss.dta"
merge 1:1 SAMPA


//////////////////////////
//// Ultrasound
//////////////////////////	

//Consent
//Without consent but with measurements -- 
br if uss == . & date_exam_uss != . 
//br if ct == . & uss == . & (date_exam_uss != . | ct_date!= . )
export delimited using "/Users/sharoncox/Desktop/SAMPA/01_cleaning/01_ultrasound/SAMPA_utz_noconsentwithmeasurements.csv" if uss == . & date_exam_uss != ., replace
/*
sampa_id	orgid

*/

//With UTS done but no date_exam_uss
br if date_exam_uss == . & pan_head_trans != . 
export delimited using "/Users/sharoncox/Desktop/SAMPA/01_cleaning/01_ultrasound/SAMPA_utz_noussdatewithmeasurements.csv" if date_exam_uss == . & pan_head_trans != . , replace

//With consent but without measurements -- 
//Utz
br if uss ==1 & date_exam_uss == . 
tab radio_exam if uss != . & date_exam_uss == . 
//31 who consent but no results 
//
//Ct
br if ct ==1 & ct_date == . 
tab radio_exam if ct != . & ct_date == . 

//View those with dates indicated
br if date_exam_uss!=. |  ct_date!=. 
br if date_exam_uss!=. & radio_exam==1
//550


//Utz - anticipated 550
count if !missing(date_exam_uss) 
local vars "date_exam_uss time_exam_uss pan_size_qual pan_head_trans pan_head_ap pan_body_trans pan_tail_trans pan_shape pan_shape_problem pan_contour pan_contour_problem pan_parenchyma pan_paren_inflam pan_paren_fibrosis pan_paren_steatosis pan_duct pan_duct_stones pan_duct_mass pan_calci pan_calci_place" 
foreach var of local vars {
	summ `var'
	count if !missing(`var') 
}	


//Copy old variable values 
replace pan_duct=pan_duct_normal if pan_duct==.

//<550
local vars "date_exam_uss time_exam_uss pan_size_qual pan_head_trans pan_head_ap pan_body_trans pan_tail_trans pan_shape pan_shape_problem pan_contour pan_contour_problem pan_parenchyma pan_paren_inflam pan_paren_fibrosis pan_paren_steatosis pan_duct pan_duct_stones pan_duct_mass pan_calci pan_calci_place" 

foreach var of local vars {
	qui distinct date_exam_uss
	local max `r(N)'
    qui count if !missing(`var')
    if r(N) < `max' {
        disp "`var'"
    }
}

/*time_exam_uss - ignore
pan_size_qual
pan_head_ap
pan_shape
pan_shape_problem
pan_contour
pan_contour_problem
pan_paren_inflam
pan_paren_fibrosis
pan_paren_steatosis
pan_duct_stones
pan_duct_mass
pan_calci_place

*/




//Pancreatic size
	//Outliers
local vars "pan_head_trans pan_head_ap pan_body_trans pan_tail_trans " 
foreach var of local vars {
	disp "`varlabel': `var'" 
	replace `var'=. if `var'<0
	sum `var' if !missing(`var') & !missing(date_exam_uss) & radio_exam==1
}


	//Missing
local vars "pan_size_qual pan_head_ap " 

foreach var of local vars {
    local varname "`var'"
    local varlabel : variable label `varname'

    disp "`varlabel': `var'" 
    list personnel sampa_id orgid if missing(`var') & !missing(date_exam_uss) & radio_exam==1
}

//Pancreatic shape
//pan_shape_problem- no abnormal
//pan_contour_problem- no abnormal
local vars "pan_shape pan_contour " 

foreach var of local vars {
    local varname "`var'"
    local varlabel : variable label `varname'

    disp "`varlabel': `var'" 
    list personnel sampa_id orgid if missing(`var') & !missing(date_exam_uss) & radio_exam==1
}


br if missing(pan_size_qual) & !missing(date_exam_uss) & radio_exam==1 

//With missing if abnormal	
list personnel sampa_id orgid if pan_shape==2 & missing(pan_shape_prob_specify) & !missing(date_exam_uss) & radio_exam==1	
list personnel sampa_id orgid if pan_contour==2 & missing(pan_contour_problem) & !missing(date_exam_uss) & radio_exam==1	
list personnel sampa_id orgid if pan_parenchyma==2 & (missing(pan_paren_inflam) | missing(pan_paren_fibrosis) | missing(pan_paren_steatosis))  & !missing(date_exam_uss) & radio_exam==1	
list personnel sampa_id orgid if pan_duct==2 & (missing(pan_duct_stones) | missing(pan_duct_mass))  & !missing(date_exam_uss) & radio_exam==1	
list personnel sampa_id orgid if pan_calci==1 & missing(pan_calci_place)  & !missing(date_exam_uss) & radio_exam==1	
list personnel sampa_id orgid if pan_oth_abnormal==1 & missing(pan_oth_abn_specify)  & !missing(date_exam_uss) & radio_exam==1	


//////////////////////////
//// CT scan
//////////////////////////	


//With consent but without measurements -- 
//Ct
br if ct ==1 & ct_date == . 
br radio_exam if ct != . & ct_date == . 
br radio_exam if ct != . & ct_date == . 

//With consent but with measurements
br if ct ==. & ct_date != . 


//View those with dates indicated
br if ct_date!=. & ct_scan==1
//200

//CT - anticipated 200
count if !missing(ct_date) 
local vars "ct_pan_size_qual ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head ct_pan_shape ct_pan_shape_problem ct_pan_contour ct_pan_contour_problem ct_pan_parenchyma ct_pan_paren_inflam ct_pan_paren_fibrosis ct_pan_paren_steatosis ct_pan_duct ct_pan_duct_stones ct_pan_duct_mass ct_pan_calci ct_pan_calci_place ct_pan_oth_abnormal ct_image_qual ct_problem" 
foreach var of local vars {
	summ `var'
	count if !missing(`var') 
}	



//Check which variables have less than the maximum images
local vars "ct_pan_size_qual ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head ct_pan_shape ct_pan_shape_problem ct_pan_contour ct_pan_contour_problem ct_pan_parenchyma ct_pan_paren_inflam ct_pan_paren_fibrosis ct_pan_paren_steatosis ct_pan_duct ct_pan_duct_stones ct_pan_duct_mass ct_pan_calci ct_pan_calci_place ct_pan_oth_abnormal ct_image_qual ct_problem" 

foreach var of local vars {
	qui distinct ct_date
	local max `r(N)'
    qui count if !missing(`var')
    if r(N) < `max' {
        disp "`var'"
    }
}

/*ct_pan_size_qual
ct_pan_body_tail
ct_pan_cc_body
ct_pan_cc_head
ct_pan_shape_problem
ct_pan_contour
ct_pan_contour_problem
ct_pan_paren_inflam
ct_pan_paren_fibrosis
ct_pan_paren_steatosis
ct_pan_duct_stones
ct_pan_duct_mass
ct_pan_calci_place
ct_image_qual
ct_problem

*/




//Pancreatic size
	//Outliers
local vars "ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head" 
foreach var of local vars {
	disp "`varlabel': `var'" 
	replace `var'=. if `var'<0
	sum `var' if !missing(`var') & !missing(ct_date) & ct_scan==1
}


	//Missing
local vars "ct_pan_size_qual ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head" 

foreach var of local vars {
    local varname "`var'"
    local varlabel : variable label `varname'

    disp "`varlabel': `var'" 
    list personnel sampa_id orgid if missing(`var') & !missing(ct_date) & ct_scan==1
}

//Pancreatic shape
//pan_shape_problem- no abnormal
//pan_contour_problem- no abnormal
local vars "ct_pan_contour ct_pan_parenchyma" 

foreach var of local vars {
    local varname "`var'"
    local varlabel : variable label `varname'

    disp "`varlabel': `var'" 
    list personnel sampa_id orgid if missing(`var') & !missing(ct_date) & ct_scan==1
}


br if missing(pan_size_qual) & !missing(date_exam_uss) & radio_exam==1 

//With missing if abnormal	
list personnel sampa_id orgid if ct_pan_shape==2 & missing(ct_pan_shape_problem) & !missing(ct_date) & ct_scan==1	
list personnel sampa_id orgid if ct_pan_contour==2 & missing(ct_pan_contour_problem) & !missing(ct_date) & ct_scan==1	
list personnel sampa_id orgid if ct_pan_parenchyma==2 & (missing(ct_pan_paren_inflam) | missing(ct_pan_paren_fibrosis) | missing(ct_pan_paren_steatosis)) & !missing(ct_date) & ct_scan==1	
list personnel sampa_id orgid if ct_pan_duct==2 & (missing(ct_pan_duct_stones) | missing(ct_pan_duct_mass)) & !missing(ct_date) & ct_scan==1	
list personnel sampa_id orgid if ct_pan_calci==1 & missing(ct_pan_calci_place) & !missing(ct_date) & ct_scan==1	
list personnel sampa_id orgid if ct_pan_oth_abnormal==1 & missing(ct_pan_oth_abn_spec) & !missing(ct_date) & ct_scan==1	
