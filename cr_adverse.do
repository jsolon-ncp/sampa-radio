*Stata version 17
*Adverse Events*

clear
set more off

capture log close _all
capture cmdlog close

capture log using "/Users/juansolon/Documents/GitHub/sampa-mwanza/jslog.txt", replace text
capture cmdlog using "/Users/juansolon/Documents/GitHub/sampa-mwanza/jscmd.txt", replace

* Set up directory global macros
global github = "~/Documents/GitHub"
global gshared = "~/Google Drive/Shared drives/"
global gmydrive = "~/Google Drive/My Drive/"
global sampamwanza = "$github/sampa-mwanza/"
global dropbox = "~/Cox working group Dropbox/"

cd "$dropbox"
use "SAMPA/DATA monitoring/Data/SAMPA/All_Crf4a_Blood_Sampling_And_Processing.dta", clear
merge 1:1 sampa_id using "SAMPA/DATA monitoring/Data/SAMPA/All_Crf4b_Repeat_Ogtt.dta" 
cd $sampamwanza

* code missings
replace hba1c=. if hba1c<0
replace mmol_glu120 =. if mmol_glu120<0
* code hba1c_cat glu120_cat
egen hba1c_cat = cut(hba1c), at(0 6.5 99) icodes
egen glu120_cat = cut(mmol_glu120), at(0 11.1 99) icodes

save adverse.dta, replace
