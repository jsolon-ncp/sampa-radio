/* gr_upsetplot.do 
Juan Solon
2025 Feb 

Purpose : Show subsets of samples similar to a venn diagram, but not ....

Output files : 
fig_upset_1.png
fig_upset_2.png

*/
version 18.5

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


tempfile 1 2 	
cd ./02-data-temp 

save `1'
local filter `if flag_fecal_elastase!=1'
upsetplot  recruited assay_fe assay_lip radio2 ct2 if flag_fecal_elastase !=1 , ///
													varlabels ///
													title ("Functional Assays and Imaging Subsets (n=2297)")
													
													
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

upsetplot  recruited assay_fe assay_lip radio2 ct2 , ///
													varlabels ///
													title ("Functional Assays and Imaging Subsets") ///
													gsort(_freq ) select(9 10 12)
cd ..
local toptitle "t1title(Assays and Imaging)"
local paperopts matrixopts(mc(gs8 ..))
tempfile x 1 2

upsetplot  assay_fe assay_lip radio2 ct2 , varlabels ///
gsort(-_degree -_freq) `paperopts' baropts(`toptitle')  savedata(x, replace)

gr save `1'.gph, replace

. use x, clear
. graph hbar (asis) _setfreq, over(_set, sort(1)) blabel(bar) ysc(off) `toptitle'
gr save `2'.gph, replace

gr combine `1'.gph `2'.gph


													

upsetplot  recruited assay_fe radio2 ct2 , ///
											varlabels ///
											title ("elastase uss ct subsets") 

upsetplot  recruited assay_fe radio2 ct2 , ///
											varlabels ///
											title ("elastase uss ct subsets") ///
											select (7 8 4) gsort(_set)
											
											select(1 2 3)
											
upsetplot  recruited assay_fe radio2 ct2 , varlabels title ("elastase uss ct subsets")

gr save 
upsetplot  recruited radio2 ct2 , varlabels title("Imaging Subsets")



/*

PV = [(APtail+APbody)/2×Lbody&tail×CCbody]+[(APhead/2)2×3.14×CChead]




tab radio_exam radio2, mis
tab ct_scan ct2, mis
tab fe_elisa

table (fe_elisa radio2 ct2), totals(fe_elisa)

table (fe_elisa radio2 ct2), nototals

collect layout
collect dims
collet levelsof fe_elisa








gen ucf = 1 if radio_exam==1 & ct_scan==0  & fe_elisa==0
replace ucf = 2 if radio_exam==1 & ct_scan==1  & fe_elisa==0
replace ucf = 3 if radio_exam==1 & ct_scan==1  & fe_elisa==1

replace ucf = 4 if radio_exam==0 & ct_scan==1  & fe_elisa==0
replace ucf = 5 if radio_exam==1 & ct_scan==1  & fe_elisa==0
replace ucf = 6 if radio_exam==0 & ct_scan==1  & fe_elisa==1

replace ucf = 7 if radio_exam==0 & ct_scan==0  & fe_elisa==1
replace ucf = 8 if radio_exam==1 & ct_scan==0  & fe_elisa==1
replace ucf = 9 if radio_exam==0 & ct_scan==1  & fe_elisa==1



table , stat(fvfrequency "`participant'") ///
		stat(fvfrequency 1.radio_exam) ///
		stat(fvfrequency 1.ct_scan) ///
		stat(fvfrequency 1.feces_collect) ///
		stat(fvfrequency "`fe1'") ///
		stat(fvfrequency "`uss_ct'")  /// 314 in Venn
		
		


* keep cohort ct_sample ct_scan radio_exam uss_sample uss ever_mal

*d cohort ct_sample ct_scan radio_exam uss_sample uss ever_mal
/*
tab cohort
tab ct_sample, mis 
tab ct_scan, mis
tab uss_sample, mis
tab uss, mis
tab radio_exam

table (var), statistic(frequency cohort)
*/
