 
/* 
check.do
Juan
march 3 2025
Check of numbers for table 1, venn, consort
 Of these, 110 participants (4.7%, including x PM and y NPM) were excluded from the present analysis as they did not undergo radiological scans nor contribute stool samples.
 
 */

version 18.5

** Install this 

net install upsetplot.pkg

*CLEAR
clear all
set more off

* GLOBALS
global dropboxsampa "~/Cox working group Dropbox/TB Nutrition working group/Sampa"
global samparadio "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Analysis/Radiology"
* global sampadata "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Management/04-data-delivered-v2/ALL/STATA"
global sampadata "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Monitoring/data/sampa"
global ghsamparadio = "~/Documents/GitHub/sampa-radio"

* LOCAL FOR DO FILE
local dofilename "gr_upsetplot.do"

cd $ghstata
* WORKING DIRECTORY

cd "$ghsamparadio"
*cd "$dropboxsampa"
*cd "$sampadata"

* LOG

capture log close _all
capture cmdlog close
capture log using "./log/jslog.txt", replace text

** TEMPS

tempfile 1 2 3 4 5 6 

* USE

local dataset "All_combined_sampa_data.dta"

*. Use dataset /* revise as use*/
cd "$sampadata"
* use "../../Data Monitoring/data/sampa/All_combined_sampa_data.dta", clear
use "All_combined_sampa_data.dta", clear

cd "$ghsamparadio"

**# Generate recruitment and sample variables
gen recruited = 1
	la var recruited "Recruited"

gen assay_fe = 1 if fecal_elastase !=. & fecal_elastase >0
	replace assay_fe = 0 if fecal_elastase==. 
	la var assay_fe "Fecal Elastase"

gen assay_lip = 1 if lipase !=. & lipase >0
	replace assay_lip = 0 if lipase ==.
	la var assay_lip "Lipase"

gen assay_tryp = 0
replace assay_tryp = 1 if assay_tryp ==.
la var assay_tryp "Trypsinogen"

clonevar radio2 = radio_exam
	replace radio2 = 0 if radio_exam==.
	la var radio2 "Ultrasound"

clonevar ct2 = ct_scan
	replace ct2 = 0 if ct_scan==.
	la var ct2 "CT Scan"

egen epi_binary = cut(fecal_elastase), at(0,200,601) icodes
	la var epi_binary "EPI"
	recode epi_binary 0 = 1 1 = 0
	

	label define epi_binary 0 "Without EPI" 1 "With EPI"
	label values epi_binary epi_binary
	

egen epi_ordinal = cut(fecal_elastase), at(0,100,200, 601) icodes
	la var epi_ordinal "EPI Levels"
	recode epi_ordinal 0 = 3 1 = 2 2 = 1 

	label define epi_ordinal 1 "Without EPI" 2 "Mild-Moderate EPI" 3 "Severe EPI"
	label values epi_ordinal epi_ordinal

** Table of samples **
table  assay_fe radio2 ct2

collect export ./03-tables/samples.html ,as(html) replace
collect export ./03-tables/samples.docx ,as(docx) replace
html2docx ./03-tables/samples.html,  saving(samples_h.docx) replace
collect export ./03-tables/samples.html ,as(html), replace
 
 ** Upset Plot
 
 
tempfile 1 2 	
cd ./02-data-temp 

save `1'
upsetplot  recruited assay_fe assay_lip assay_tryp radio2 ct2 , ///
													varlabels ///
													title ("Functional Assays and Imaging Subsets") ///
													savedata(`2', replace)
cd ../05-figures
gr export upsetplot1.png, as(png) replace

cd ../02-data-temp

local toptitle "t1title(Assays and Imaging)"
use `2', clear
. graph hbar (asis) _setfreq, over(_set, sort(1)) blabel(bar) ysc(off) `toptitle'

cd ../05-figures
gr export sample_images_freq.png, as(png) replace

use `1', clear
