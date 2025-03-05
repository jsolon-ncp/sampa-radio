* convert missings
foreach var of varlist pan_size_head pan_size_body pan_size_tail pan_head_trans pan_head_ap pan_body_trans pan_tail_trans {
	replace `var' =. if `var'<0
	}

* Table of USS measurements
table (cohort), ///
	statistic(mean pan_head_trans) ///
	statistic(sd pan_head_trans) ///
	statistic(median pan_head_trans) ///
	statistic(mean pan_head_ap) ///
	statistic(sd pan_head_ap) ///
	statistic(median pan_head_ap) ///
	statistic(mean pan_body_trans) ///
	statistic(sd pan_body_trans) ///
	statistic(median pan_body_trans) ///
	statistic(mean pan_tail_trans) ///
	statistic(sd pan_tail_trans) ///
	statistic(median pan_tail_trans) ///
	nformat(%6.2f  mean sd) ///
	sformat("(%s)" sd) ///
	style(table-1) 

collect dims
collect label list result

collect style putdocx, layout(autofitcontents) ///
         title("Table 2: Mean and SD of USS Measurements by cohort t") ///
		 note ("Fix labels")
		 
collect export samparadio2.docx, as(docx) replace
collect export samparadio2.pdf, as(pdf) replace

* note
stripplot pan_size_head, over(cohort) tufte(mcolor(eltgreen)) msize(tiny) cumul ytitle("")

missings report pan_size_head pan_size_tail pan_size_body ///
pan_head_trans pan_head_ap pan_body_trans ///
 if radio==1
dotplot pan_size_head, over(cohort)
dotplot pan_size_body, over(cohort)
dotplot pan_size_tail, over(cohort)

collect levelsof radio_exam
collect label list radio_exam
collect label list result
*collect export MyTable1.docx, as(docx) replace
	
table cohort, stat(mean age) stat(sd age) stat(count agree) stat(count radio) stat(percent agree radio) stat (prop agree radio)

table agree (cohort), statistic(count cohort) 
table radio (cohort), statistic(count cohort) 
collect recode result count = frequency
collect label levels var agree radio cohort "N", modify
collect layout (agree radio) (cohort#result)
