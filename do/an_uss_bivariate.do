/* an_uss_bivariate.do 
J Solon
Sampa
March19 
*/

capture log close
log using ./log/an_uss_bivariate.txt, text replace

* Pancreatic Measurements

table ()(ever_mal) if radio3 ==1 , statistic(frequency) ///
statistic(p50 pan_head_ap pan_head_trans pan_body_trans  pan_tail_trans) ///
statistic(iqr pan_head_ap pan_head_trans pan_body_trans  pan_tail_trans) ///
statistic(mean pan_head_ap pan_head_trans pan_body_trans  pan_tail_trans) ///
statistic(sd pan_head_ap pan_head_trans pan_body_trans  pan_tail_trans) 


dtable  pan_head_trans pan_head_ap  pan_body_trans  pan_tail_trans if radio3==1, ///
		by(ever_mal) ///
		continuous(pan_head_ap pan_head_trans pan_body_trans  pan_tail_trans, statistic(p50 iqr)) 
		
		
dtable  ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_vol if ct2==1, ///
		by(ever_mal, nototals) ///
		continuous(ct_pan_head_ap ct_pan_head_trans ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail, statistic(p50 iqr) test(kwallis)) 

		
foreach var of varlist pan_head_trans pan_head_ap  pan_body_trans  pan_tail_trans {
	regress `var' ever_mal i.cohort bmi_cat if child ==2
}

scatter pan_head_ap pan_head_trans
scatter pan_body_trans pan_tail_trans if radio3==1 & pan

 pan_head_trans

foreach var of varlist pan_head_trans pan_head_ap  pan_body_trans  pan_tail_trans {
	regress `var' if child ==2
}


foreach var of varlist pan_head_trans pan_head_ap  pan_body_trans  pan_tail_trans {
	kwallis `var' ,by(ever_mal)
}

foreach var of varlist ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_vol {
	kwallis `var'  ,by(ever_mal)
}


table (cohort)(ever_mal) if radio3 ==1 , statistic(frequency) ///
statistic(p50 pan_head_ap pan_head_trans pan_body_trans  pan_tail_trans) ///
statistic(iqr pan_head_ap pan_head_trans pan_body_trans  pan_tail_trans) ///
statistic(mean pan_head_ap pan_head_trans pan_body_trans  pan_tail_trans) ///
statistic(sd pan_head_ap pan_head_trans pan_body_trans  pan_tail_trans) 



table ()(ever_mal) , statistic(frequency) ///
statistic(p50 pan_head_ap pan_head_trans pan_body_trans  pan_tail_trans) ///
statistic(iqr pan_head_ap pan_head_trans pan_body_trans  pan_tail_trans) ///
statistic(mean pan_head_ap pan_head_trans pan_body_trans  pan_tail_trans) ///
statistic(sd pan_head_ap pan_head_trans pan_body_trans  pan_tail_trans) 


table (pan_head_ap pan_head_trans pan_body_trans  pan_tail_trans), statistic(frequency)

missings report pan_head_ap pan_head_trans pan_body_trans  pan_tail_trans



ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head
