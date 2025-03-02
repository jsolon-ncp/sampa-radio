/*  01_gr_imaging_ctvsus.do 
Juan Solon
2025 Feb 

Purpose : Create scatter plots comparing US and CT

Logic:
The union of ct_scan==1 & radio_exam==1 represent those with both CT and USS images.
Plot changes with x for each dimensions

The USS dimensions are pan_head_trans pan_head_ap pan_body_trans pan_tail_trans
The CT dimensiosn are ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head


output  : ct_organs
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

cd $ghstata
* WORKING DIRECTORY

cd "$ghsamparadio"
*cd "$dropboxsampa"
*cd "$sampadata"

* LOG

capture log close _all
capture cmdlog close
capture log using "./log/jslog.txt", replace text

* LOCAL DO FILE
local dofilename "01_gr_imaging_ctvsus.do"

* LOCAL Output
local output "gr1_ctus"

* local variables to plots
local scatter1 "pan_head_trans ct_pan_head_trans"
local scatter2 "pan_head_ap ct_pan_head_ap"
local scatter3 "pan_body_trans ct_pan_body_trans"
local scatter4 "pan_tail_trans ct_pan_tail_trans"

** TEMPS

tempfile 1 2 3 4 5 6 

* USE

local dataset "All_combined_sampa_data.dta"

*. Use dataset /* revise as use*/
cd "$sampadata"
* use "../../Data Monitoring/data/sampa/All_combined_sampa_data.dta", clear
use "All_combined_sampa_data.dta", clear


cd "$ghsamparadio"

cd 05-figures

* relabel vars because they have the same label

**#  BLAND ALTMAN AGREEMENT PLOTS FOR FOUR PANCREATIC DIMENSIONS : USS VS CT 
* local variables to plots
	tempfile 1 2 3 4
	local ba1 "pan_head_trans ct_pan_head_trans"
	local ba2 "pan_head_ap ct_pan_head_ap"
	local ba3 "pan_body_trans ct_pan_body_trans"
	local ba4 "pan_tail_trans ct_pan_tail_trans"
	local title1 "Head, Transverse"
	local title2 "Head, Antero-posterior"
	local title3 "Body, Transverse"
	local title4 "Tail, Transverse"

		blandaltman `ba1', plot(percentmean) saving(`1'.gph, replace) xtitle("") ytitle("") title(`title1')
		blandaltman `ba2', plot(percentmean) saving(`2'.gph, replace) xtitle("") ytitle("") title(`title2')
		blandaltman `ba3', plot(percentmean) saving(`3'.gph, replace) xtitle("") ytitle("") title(`title3')
		blandaltman `ba4', plot(percentmean) saving(`4'.gph, replace) xtitle("") ytitle("") title(`title4')

	* Combine Graphs
		local l1title "Percent Mean Difference (Ultrasound-CTScan)"
		local b1title "Mean"
		local title "Agreement Between Ultrasound and CT Scan Measurements"
		local subtitle "Bland-Altman Plots"

	graph combine `1'.gph `2'.gph `3'.gph `4'.gph, ///
			title(`title', span) ///
			subtitle(`subtitle') ///
			ycommon xcommon ///
			l1title("`l1title'", pos(9) orientation(vertical)) ///
				b1title("`b1title'", pos(6)) 
	
	* Save and Export
	gr save baplot_us_ct_combined, replace
	gr export baplot_us_ct_combined.png, as(png) replace

**#  Scatter plot of four pancreatic dimensions versus by BMI

**#  Scatter plot vs bmi
* local variables to plots
	tempfile 1 2 3 4
	local scatter1 "pan_head_trans ct_pan_head_trans bmi"
	local scatter2 "pan_head_ap ct_pan_head_ap"
	local lfitci1 "pan_head_trans bmi"
	local lfitci2 "ct_pan_head_trans bmi"
	
	local title "Pancreatic Head and BMI"
	local subtitle "Ultrasound and BMI"
	
	local ciplot "rarea"
	local fintensity ("inten50")

	scatter `scatter1', msym(oh oh) msize(small) ///
		 || lfitci `lfitci1', ciplot(`ciplot') ///
		 || lfitci `lfitci2',  ciplot(`ciplot') fintensity(`fintensity')  ///
		 legend(label(1 "Ultrasound")) legend(label(2 "CT Scan")) ///
		 legend(label(4 "Ultrasound Fitted values")) ///
		 legend(label(5 "CT Scan Fitted values")) ///
		 title(`title', span) ///
		 subtitle(`subtitle', span) 
		
				  

	
scatter `scatter1', msym(oh oh) msize(small) ///
		legend(on) legend(label(1 "Ultrasound")) legend(label(2 "CT Scan")) ///
		 || lfitci `lfitci1', legend(label(4 "Ultrasound Fitted values")) ///
		 || lfitci `lfitci2', legend(label(5 "CT Scan Fitted values"))
				  



local a "pan_head_trans bmi "
local b "ct_pan_head_trans bmi"
local title "Head, Transverse"
local ytitle "y"
local xtitle "x"

 scatter `a' ||  scatter `b', msym(oh oh) msize(small) ///
				legend(on) legend(label(1 "Ultrasound")) legend(label(2 "CT Scan"))  ///
				title("`title'") ///
				ytitle("`ytitle'") ///
				xtitle("`xtitle'")
				
				twoway lfitci ct_pan_head_trans bmi

local y "pan_head_trans ct_pan_head_trans bmi"
local x "bmi"
scatter `y', legend(on) legend(label(1 "Ultrasound")) legend(label(2 "CT Scan"))


local sctter
scatter pan_head_trans ct_pan_head_trans bmi || lfitci pan_head_trans bmi || lfitci ct_pan_head_trans bmi
 
scatter `scatter1', msym(oh) msize(small) legend(label(1 "Male") label(2 "Female"))

local scatter2 "pan_head_ap ct_pan_head_ap"
local scatter3 "pan_body_trans ct_pan_body_trans"
local scatter4 "pan_tail_trans ct_pan_tail_trans"
		

**#  Scatter plot vs elastase_level

xtitle("Mean") ytitle("Percent Mean Difference")


* graph
local title "Transverse Pancreatic Head"
local xtitle "CT Scan (cm)"
local ytitle "Ultrasound (cm)"
scatter `scatter1', title(`title') xtitle(`xtitle') ytitle(`ytitle')


d  pan_head_trans pan_head_ap pan_body_trans pan_tail_trans
d  ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head

