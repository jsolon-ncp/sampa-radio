/*
SAMPA
cr_read.do
March 3 2025
J Solon
Reads Combined Dataset from Dropbox

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

* LOG

capture log close _all
capture cmdlog close
capture log using "./log/jslog.txt", replace text

local dataset "All_combined_sampa_data.dta"

* CHANGE DIRECTORY TO DROPBOX

cd "$sampadata"

use "All_combined_sampa_data.dta", clear

frame rename default sampa
cd "$ghsamparadio"



