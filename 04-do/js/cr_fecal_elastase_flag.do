/*
cr_fecal_elastase_flag.do
March 3 2025
There is one ELISA plate with fecal_elastase results where the standards show that these should not be analyzed
This will create a variable that identifies the sampa_id for those observations and this can be merged with the data in dropbox.

Input Data from Zambia : Plate 1 results.xlsx
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
local dofilename "cr_fecal_elastase_flag.do"

* WORKING DIRECTORY

cd "$ghsamparadio"

* LOG

capture log close _all
capture cmdlog close
capture log using "./log/jslog.txt", replace text

local dataset "All_combined_sampa_data.dta"

*. Use dataset /* revise as use*/
cd "$sampadata"
* use "../../Data Monitoring/data/sampa/All_combined_sampa_data.dta", clear
use "All_combined_sampa_data.dta", clear

cd "$ghsamparadio"

tempfile 1 2 3

frame rename default sampa
sort sampa_id

save `1'

***  IMPORT ZAMBIA ELISA DATA (PLATE DROPPED)

frame create plate
frame change plate

cd 02-data-temp

import excel using "Plate 1 results.xlsx" ,cellrange(A2) first   

cd ../

gen flag_fecal_elastase = 1

rename SampaID sampa_id

keep sampa_id flag_fecal_elastase

sort sampa_id

save `2'

frame change sampa


merge 1:1 sampa_id using `2', keep(match master)


