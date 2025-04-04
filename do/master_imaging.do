/* master_imaging.do
Juan Solon
March 3 2025
Purpose
This serves as the master do file for the Sampa Imaging Elastase Paper

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

**# Create Study Dataset for Analysis
version 18.5

local pwd "~/Documents/GitHub/sampa-radio"
cd `pwd'
local suffix: display %tdCCYY-NN-DD =daily("`c(current_date)'", "DMY")
*use "my_file.`suffix'.dta", clear
capture log close
log using ./log/master`suffix'.log,  replace

*CLEAR
clear all
set more off

display "`c(current_time)' `c(current_date)'"

* GLOBALS (or locals)
* global sampadata "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Management/04-data-delivered-v2/ALL/STATA"

	global dropboxsampa "~/Cox working group Dropbox/TB Nutrition working group/Sampa"
	global samparadio "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Analysis/Radiology"
	global sampadata "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Monitoring/data/sampa"

	global ghsamparadio = "~/Documents/GitHub/sampa-radio" // Juan's github

* WORKING DIRECTORY 

local pwd "~/Documents/GitHub/sampa-radio"
 cd `pwd'

do ./do/cr_read.do 					// Read from Dropbox the Combined Dataset


 cd `pwd'

do ./do/cr_flag_elastase.do 		// Flags the elastase samples that should not be analyzed based on ELISA standards ; n = 90

 cd `pwd'

*do ./do/cr_trypsin.do 				// Adds trypsinogen

 cd `pwd'
  
do ./do/cr_diabetes.do 
 
*do ./do/cr_amylase.do 				// Adds amylase

 cd `pwd'

 
do ./do/cr_sample_binary.do		// Generates or recodes ultrasound ct scan and elisa assays as binary with or without samples
										// Include here the same for presence or absence of functional enzyme assays 
										// Revise once amylase and trypsinogen 


 cd `pwd'
do ./do/cr_categorical_outcomes.do

										// Recodes fecal_elastase to with or without EPI and levels of EPI
										// Include here any recoding of other functional enzymes once that data is in and cut-offs are known

 cd `pwd'
do ./do/cr_categorical_independent.do

										// Include here any derived variables for imaging that are categorical

 cd `pwd'
do ./do/cr_continuous_independent.do 		// Derived variables for imaging that are continuous ; include transformations / weights

 cd `pwd'
do ./do/cr_labels.do					// Adds additional labels

 cd `pwd'
do ./do/cr_keep.do 

local obs = _N
notes drop _dta 
note: Subset Created for Imaging Paper on `c(current_date)' at `c(current_time)' by `c(username)'
note: Keeps only participants with Fecal Elastase or Visible Ultrasound Scans; N=`obs'
note: Data read from ~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Monitoring/data/sampa/All_combined_sampa_data.dta
note: Selected variables kept for this paper in cr_keep.do 
describe, simple
notes 

save ./data-temp/subset_imaging.dta, replace

/*
************  This is the analysis dataset 

do ./do/an_samples_images_counts.do 						//  What is the proportion of samples per MN and cohort

an_images_mn.do 						//. What is the proportion of samples with CT and USS per MN and cohort


an__bivariate_assays.do // bivariate anaysis - of all lab assays by mn 

an_cont_asays.do // tabulate mean p50 of levels per mn and cohort; tobit regression



*********************


tab_assays.do // tabulate levels of EPI by cohort; by mn

an_bivariate_dimensions.do // bivaraite analysis of all relevant  by mn

tab_dimensions.do // bivaraite analysis of all image sizes by mn

an_regression_assays.do // 

an_regression_dimensions.do //
 
tab_image_findings.do // 
