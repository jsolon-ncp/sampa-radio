//Post-dicom QA cleaning sumamry table


//Generate new variables that would be a summary percentages
//Create new variables that would create a discrepancy percentage 
//Summary of errors
//Conver 106 to missing 
clear
// Import
import delimited record_id image_id image_id_complete r1_personnel r1_timestamp r1_date r1_pan_head_trans r1_pan_head_ap r1_pan_body_trans r1_pan_tail_trans r1_pan_body_tail r1_pan_cc_body r1_pan_cc_head r1_remarks radiologist_a_complete r2_personnel r2_timestamp r2_date r2_pan_head_trans r2_pan_head_ap r2_pan_body_trans r2_pan_tail_trans r2_pan_body_tail r2_pan_cc_body r2_pan_cc_head r2_remarks radiologist_b_complete r3_personnel r3_timestamp r3_date r3_pan_head_trans r3_pan_head_ap r3_pan_body_trans r3_pan_tail_trans r3_pan_body_tail r3_pan_cc_body r3_pan_cc_head r3_remarks radiologist_c_complete using "/Users/sharoncox/Downloads/ImagesQualityAssuran_DATA_NOHDRS_2023-10-13_0434.csv", varnames(nonames)

//Organize labels etc


label data "ImagesQualityAssuran_DATA_NOHDRS_2023-10-13_0434.csv"

label define image_id_complete_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define radiologist_a_complete_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define radiologist_b_complete_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define radiologist_c_complete_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 

label values image_id_complete image_id_complete_
label values radiologist_a_complete radiologist_a_complete_
label values radiologist_b_complete radiologist_b_complete_
label values radiologist_c_complete radiologist_c_complete_



tostring r1_date, replace
gen _date_ = date(r1_date,"YMD")
drop r1_date
rename _date_ r1_date
format r1_date %dM_d,_CY

tostring r2_date, replace
gen _date_ = date(r2_date,"YMD")
drop r2_date
rename _date_ r2_date
format r2_date %dM_d,_CY

tostring r3_date, replace
gen _date_ = date(r3_date,"YMD")
drop r3_date
rename _date_ r3_date
format r3_date %dM_d,_CY

label variable record_id "Database ID"
label variable image_id "Image ID"
label variable image_id_complete "Complete?"
label variable r1_personnel "REDCap ID of Data Entry Personnel"
label variable r1_timestamp "Date of Data Entry"
label variable r1_date "Date of Examination"
label variable r1_pan_head_trans "Pancreas head size measured in transverse dimension"
label variable r1_pan_head_ap "Pancreas head size measured in anterior/posterior dimension"
label variable r1_pan_body_trans "Pancreas body size measures in anterior/posterior dimension; maximum diameter"
label variable r1_pan_tail_trans "Pancreas tail size measure in anterior/posterior dimension"
label variable r1_pan_body_tail "Length of Pancreas body and tail size measured in anterior/posterior dimension"
label variable r1_pan_cc_body "Diameter of Pancreas body measured in Cranial-Caudal"
label variable r1_pan_cc_head "Diameter of Pancreas head measured in Cranial-Caudal"
label variable r1_remarks "Remarks"
label variable radiologist_a_complete "Complete?"
label variable r2_personnel "REDCap ID of Data Entry Personnel"
label variable r2_timestamp "Date of Data Entry"
label variable r2_date "Date of Examination"
label variable r2_pan_head_trans "Pancreas head size measured in transverse dimension"
label variable r2_pan_head_ap "Pancreas head size measured in anterior/posterior dimension"
label variable r2_pan_body_trans "Pancreas body size measures in anterior/posterior dimension; maximum diameter"
label variable r2_pan_tail_trans "Pancreas tail size measure in anterior/posterior dimension"
label variable r2_pan_body_tail "Length of Pancreas body and tail size measured in anterior/posterior dimension"
label variable r2_pan_cc_body "Diameter of Pancreas body measured in Cranial-Caudal"
label variable r2_pan_cc_head "Diameter of Pancreas head measured in Cranial-Caudal"
label variable r2_remarks "Remarks"
label variable radiologist_b_complete "Complete?"
label variable r3_personnel "REDCap ID of Data Entry Personnel"
label variable r3_timestamp "Date of Data Entry"
label variable r3_date "Date of Examination"
label variable r3_pan_head_trans "Pancreas head size measured in transverse dimension"
label variable r3_pan_head_ap "Pancreas head size measured in anterior/posterior dimension"
label variable r3_pan_body_trans "Pancreas body size measures in anterior/posterior dimension; maximum diameter"
label variable r3_pan_tail_trans "Pancreas tail size measure in anterior/posterior dimension"
label variable r3_pan_body_tail "Length of Pancreas body and tail size measured in anterior/posterior dimension"
label variable r3_pan_cc_body "Diameter of Pancreas body measured in Cranial-Caudal"
label variable r3_pan_cc_head "Diameter of Pancreas head measured in Cranial-Caudal"
label variable r3_remarks "Remarks"
label variable radiologist_c_complete "Complete?"

order record_id image_id image_id_complete r1_personnel r1_timestamp r1_date r1_pan_head_trans r1_pan_head_ap r1_pan_body_trans r1_pan_tail_trans r1_pan_body_tail r1_pan_cc_body r1_pan_cc_head r1_remarks radiologist_a_complete r2_personnel r2_timestamp r2_date r2_pan_head_trans r2_pan_head_ap r2_pan_body_trans r2_pan_tail_trans r2_pan_body_tail r2_pan_cc_body r2_pan_cc_head r2_remarks radiologist_b_complete r3_personnel r3_timestamp r3_date r3_pan_head_trans r3_pan_head_ap r3_pan_body_trans r3_pan_tail_trans r3_pan_body_tail r3_pan_cc_body r3_pan_cc_head r3_remarks radiologist_c_complete 
set more off
describe

//Fix any 106
foreach var of varlist r1_pan_* r2_pan_* r3_pan_* {
    replace `var' = -106 if `var' == 106
}

//Replace any -106 as missing
foreach var of varlist r1_pan_* r2_pan_* r3_pan_* {
    replace `var' = . if `var' == -106
}

//summarize raw vaklues per radiologists
foreach var of varlist r2_pan_* {
    summ `var' 
}
foreach var of varlist r3_pan_* {
    summ `var' 
}


exit
br

//Box plot
// pan_head_trans "Pancreas head size measured in transverse dimension"
graph box r1_pan_head_trans r2_pan_head_trans r3_pan_head_trans
// check r3

// pan_head_ap "Pancreas head size measured in anterior/posterior dimension"
graph box r1_pan_head_ap r2_pan_head_ap r3_pan_head_ap
// check r3

// pan_body_trans "Pancreas body size measures in anterior/posterior dimension; maximum diameter"
graph box r1_pan_body_trans r2_pan_body_trans r3_pan_body_trans
// check r3

// pan_tail_trans "Pancreas tail size measure in anterior/posterior dimension"
graph box r1_pan_tail_trans r2_pan_tail_trans r3_pan_tail_trans
// check r3

// pan_body_tail "Length of Pancreas body and tail size measured in anterior/posterior dimension"
graph box r1_pan_body_tail r2_pan_body_tail r3_pan_body_tail
// check r3

// pan_cc_body "Diameter of Pancreas body measured in Cranial-Caudal"
graph box r1_pan_cc_body r2_pan_cc_body r3_pan_cc_body
// check r3

// pan_cc_head "Diameter of Pancreas head measured in Cranial-Caudal"
graph box r1_pan_cc_head r2_pan_cc_head r3_pan_cc_head
// check r3
// Check r2 outlier 
/*REDCap ID of Data Entry Personnel	Date of Data Entry	Date of Examination	Pancreas head size measured in transverse dimension **Score -106 if ... measured due to image quality	Pancreas head size measured in anterior/posterior dimension **Score ... measured due to image quality	Pancreas body size measures in anterior/posterior dimension; maximu ... measured due to image quality	Pancreas tail size measure in anterior/posterior dimension **Score ... measured due to image quality	Length of Pancreas body and tail size measured in anterior/posterio ... measured due to image quality	Diameter of Pancreas body measured in Cranial-Caudal **Score -106 i ... measured due to image quality	Diameter of Pancreas head measured in Cranial-Caudal **Score -106 i ... measured due to image quality	Remarks	Complete?	Database ID
r2_personnel	r2_timestamp	r2_date	r2_pan_head_trans	r2_pan_head_ap	r2_pan_body_trans	r2_pan_tail_trans	r2_pan_body_tail	r2_pan_cc_body	r2_pan_cc_head	r2_remarks	radiologist_b_complete	record_id
jronquillo	2023/08/30 9:11	30-10-2022	2.85	3.61	1.89	1.3	10.89	2.42	51.06		Complete (2)	47  id: 50844
*/

//
//
//
//
//
//
//

sum 
//Checking R1
br if r3_personnel!=""

//Checking R2
br if r3_personnel!=""

//Checking R3
br if r3_personnel!=""



