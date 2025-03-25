/*
SAMPA
cr_continuous_independent.do
March 3 2025
J Solon

Creates continuous variables for Radiology

Creates pancreatic volumes based on the formula vy Li.

Reusable with
	1.  Access to Dropbox
	2.  Define globals and paths
	3.  A working directory with 
	01-data
	02-data-temp
	03-tables
	04-do
	05-figures
	log 
	
	
*/

* Pancreatic Volume (CT)

cap drop ct_pan_vol
	gen ct_pan_vol=((ct_pan_tail_trans+ct_pan_body_trans)/2)*ct_pan_body_tail*ct_pan_cc_body+((ct_pan_head_ap/2)^2)*3.14*ct_pan_cc_head
	cap label variable ct_pan_vol "Calculated Pancreatic Volume; Study"

	

foreach var of varlist ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head ct_pan_vol {
	gen adj_wt_`var' = `var'/weight
}


foreach var of varlist ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head ct_pan_vol {
	gen adj_sqrt_`var' = sqrt(`var')
}		
	
* Derived USS Variables	

foreach var of varlist pan_head_ap pan_head_trans pan_body_trans pan_tail_trans {
	gen adj_wt_`var' = `var'/weight
}


foreach var of varlist pan_head_ap pan_head_trans pan_body_trans pan_tail_trans {
	gen adj_sqrt_`var' = sqrt(`var')
}		
	

