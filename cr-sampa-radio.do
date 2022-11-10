clear
set more off

capture log close _all
capture cmdlog close

capture log using "/Users/juansolon/Documents/GitHub/nsip/NSIP_FF/06-Stata/jslog.txt", replace text
capture cmdlog using "/Users/juansolon/Documents/GitHub/nsip/NSIP_FF/06-Stata/jscmd.txt", replace

* Set up directory global macros
global github = "~/Documents/GitHub"
global gshared = "~/Google Drive/Shared drives/"
global gmydrive = "~/Google Drive/My Drive/"
global sampamwanza = "$github/sampa-mwanza/"
global dropbox = "~/Cox working group Dropbox/"

cd "$dropbox"
use "SAMPA/DATA monitoring/Data/SAMPA/All_crf13_Abdomen_Uss.dta", clear


* Labels
label define cohort 1 "DIVIDS" 2 "SAM" 3" CICADA" 4 "NUSTART" 5 "ST-ATT" 6 "CLHNS"
label values cohort cohort
label var radio "Abdominal Ultrasound Performed"


* Missings
missings report


* sum 

sum cohort sampa_id orgid sex dob age agree uss_sample personnel13 timestamp13 radio_exam date_exam_uss time_exam_uss


* table

table (agree) cohort, nototals

table (radio) (cohort), ///
	statistic(frequency) statistic(percent)totals(radio) ///
	statistic(mean age) ///
	statistic(sd age) ///
	nformat(%9.0fc frequency) ///
	nformat(%6.2f  mean sd) ///
	sformat("%s%%" percent) ///   
	sformat("(%s)" sd) ///
	style(table-1)
	
	
table cohort, stat(mean age) stat(sd age) stat(count agree) stat(count radio) stat(percent agree radio) stat (prop agree radio)

table agree (cohort), statistic(count cohort) 
table radio (cohort), statistic(count cohort) 
collect recode result count = frequency
collect label levels var agree radio cohort "N", modify
collect layout (agree radio) (cohort#result)

webuse nhanes2, clear
table (var) (hlthstat), statistic(count hlthstat) nototals


table female hlthstat, statistic(frequency) statistic(percent, across(hlthstat)) nototals append
table region hlthstat, statistic(frequency) statistic(percent, across(hlthstat)) nototals append
collect recode result count = frequency
collect label levels var hlthstat "N", modify
collect layout (var female region) (hlthstat#result)
noi collect preview


 nformat(#9.0g)
* 1, DIVIDS | 2, SAM Lusaka | 3, CICADA | 4, NUSTART Lusaka | 5, St-ATT | 6, CLHNS


/*
 use "/Users/juansolon/Cox working group Dropbox/SAMPA/DATA monitoring/Data/SAMPA
> /All_CRF14_Computed_tomography_CT_scans.dta"
