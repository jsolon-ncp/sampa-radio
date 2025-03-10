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

*CLEAR
clear all
set more off

* GLOBALS (or locals)
* global sampadata "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Management/04-data-delivered-v2/ALL/STATA"

	global dropboxsampa "~/Cox working group Dropbox/TB Nutrition working group/Sampa"
	global samparadio "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Analysis/Radiology"
	global sampadata "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Monitoring/data/sampa"

	global ghsamparadio = "~/Documents/GitHub/sampa-radio" // Juan's github

* WORKING DIRECTORY 

cd "$ghsamparadio" 

do 04-do/js/cr_read.do 					// Read from Dropbox the Combined Dataset

cd "$ghsamparadio"

do ./04-do/js/cr_flag_elastase.do 		// Flags the elastase samples that should not be analyzed based on ELISA standards ; n = 90

cd "$ghsamparadio"
do ./04-do/js/cr_sample_binary.do		// Generates or recodes ultrasound ct scan and elisa assays as binary with or without samples
										// Include here the same for presence or absence of functional enzyme assays 
										// Revise once amylase and trypsinogen 

cd "$ghsamparadio"
do ./04-do/js/cr_categorical_outcomes.do

										// Recodes fecal_elastase to with or without EPI and levels of EPI
										// Include here any recoding of other functional enzymes once that data is in and cut-offs are known

cd "$ghsamparadio"
do ./04-do/js/cr_categorical_dependent.do

										// Include here any derived variables for imaging that are categorical

cd "$ghsamparadio"
do ./04-do/js/cr_continuous_dependent.do 		// Derived variables for imaging that are continuous ; include transformations / weights


an_samples_mn.do 						//  What is the proportion of samples per MN and cohort

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
