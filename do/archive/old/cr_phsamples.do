** filename : cr_sampa+crf_13_14_recode.do
** version 17
** J Solon
** This creates categories of other findings based on free text using regular expressions
** revised with dropbox path.


clear
clear frames
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
global dropboxsampa = "~/Cox working group Dropbox/SAMPA"
 Recode_Open_Ends.xlsx 

/* some classifications for both us and ct
hepatomegaly
splenomegaly
cholelithiasis
steatosis
mass
uterine/ovarian
atherosclerosis
nephrolithiasis
pancreatic
other kidney
*/

**CRF13**   

*CRF 13 has ultrasound findings *

cd ~
cd "Cox working group Dropbox/SAMPA/DATA monitoring"

* Create a frame for CRF 13
frame create crf13_recode
import excel using Recode_Open_Ends.xlsx, sheet(CRF13) first
* import delimited using crf13_recode.csv, clear varn(1) delim(",")

drop mass /*this conflicts later, so drop this*/

* recoding with regex
* Hepatomegaly code - captures hepatomegaly , liver enlarged or enlarged liver)

gen hepatomegaly = ustrregexm(lower(specify), "(hepatomegaly)|(\bliver\b)(.*)(\benlarged\b)|(\benlarged\b)(.*)(\bliver\b)") 

* Splenomegaly - capture splenomegaly , spleen enlarged, enlarged spleen

gen splenomegaly = ustrregexm(lower(specify), "(splenomegaly)|(\bspleen\b)(.*)(\benlarged\b)|(\benlarged\b)(.*)(\bspleen\b)")
* this does not capture "bulky spleen"

gen cholelithiasis = ustrregexm(lower(specify), "(cholelithiasis)|(gallstone)|(gallbladder lithias[e/i]s)")

gen steatosis = ustrregexm(lower(specify), "(fatty liver)|(steatosis)|(fatty infiltration)")

gen mass = ustrregexm(lower(specify), "(mass)|(tumor)")

gen gynecologic = ustrregexm(lower(specify), "(\bmulti.fibroid\b uterus)|(ovar*.)")

gen atherosclerosis = ustrregexm(lower(specify), "(\bathero*.\b)|(\barterio*.\b)")

gen nephrolithiasis = ustrregexm(lower(specify), "(\bnephrolith*.\b) | (\bkidney\b)(.*)(\bcalculus\b) | (\bcalculus\b)(.*)(\bkidney\b)")

gen pancreatic = ustrregexm(lower(specify), "(\bpancr*.\b)")

* Create frame for crf14_recode

frame create crf14_recode
import excel using Recode_Open_Ends.xlsx, sheet(CRF14) first
*import delimited using crf14_recode.csv, clear varn(1) delim(",")

drop mass gynecologic pancreatic nep* athero*  /*this conflicts later, so drop this*/

* recoding with regex
* Hepatomegaly code - captures hepatomegaly , liver enlarged or enlarged liver)

gen hepatomegaly = ustrregexm(lower(specify), "(hepatomegaly)|(\bliver\b)(.*)(\benlarged\b)|(\benlarged\b)(.*)(\bliver\b)") 

* Splenomegaly - capture splenomegaly , spleen enlarged, enlarged spleen

gen splenomegaly = ustrregexm(lower(specify), "(splenomegaly)|(\bspleen\b)(.*)(\benlarged\b)|(\benlarged\b)(.*)(\bspleen\b)")
* this does not capture "bulky spleen"

gen cholelithiasis = ustrregexm(lower(specify), "(cholelithiasis)|(gallstone)|(gallbladder lithias[e/i]s)")

gen steatosis = ustrregexm(lower(specify), "(fatty liver)|(steatosis)|(fatty infiltration)")

gen mass = ustrregexm(lower(specify), "(mass)|(tumor)")

gen gynecologic = ustrregexm(lower(specify), "(\bmulti.fibroid\b uterus)|(ovar*.)")

gen atherosclerosis = ustrregexm(lower(specify), "(\bathero*.\b)|(\barterio*.\b)")

gen nephrolithiasis = ustrregexm(lower(specify), "(\bnephrolith*.\b) | (\bkidney\b)(.*)(\bcalculus\b) | (\bcalculus\b)(.*)(\bkidney\b)")

gen pancreatic = ustrregexm(lower(specify), "(\bpancr*.\b)")

* merge frames into one radio frames

frame create crf13_14

/**** to be continued 
