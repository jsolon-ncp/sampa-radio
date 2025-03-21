/* gr_upsetplot.do 
Juan Solon
2025 Feb 

Purpose : Show subsets of samples similar to a venn diagram, but not ....

Output files : 
fig_upset_1.png
fig_upset_2.png

*/


**# Generate recruitment and sample variables
local pwd "~/Documents/GitHub/sampa-radio"
cd `pwd'
tempfile 1 2 	
cd ./data-temp 

save `1'
local filter `if flag_fecal_elastase!=1'

local N = "`_N'"
upsetplot  recruited assay_fe radio2 ct2 if flag_fecal_elastase !=1 , ///
													varlabels ///
													title ("Functional Assays and Imaging Subsets ("`N'")")
													
													
													///
													savedata(`2', replace)
cd ../figures
gr export upsetplot1.png, as(png) replace

cd ../data-temp

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
