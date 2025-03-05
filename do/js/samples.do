

/* From prior cohort data flag the timepoint at which NPM had the lowest z score
calculate the proportion flag per month
thus
*/

. tab month flag

// to export and later use that proportion : collect , export, import , local 
. table month, statistic(fvpercent 1.flag)

. collect export monthprop.xls, as(xlsx) replace

// import in another frame
. frame create ageprop
. frame change ageprop

. import excel using monthprop.xls, cellrange(A3:B6). // 
.rename A month
. rename B proportion 

// store each proportion as macro to use later
local agecat1 = ageprop[1]
local agecat2 = ageprop[2]
local agecat3 = ageprop[3]
local agecat4 = ageprop[4]

* you know have the proportion per monthprop as a macro

// create a new frame for your npm from whom you will sample

frame create npm
frame change npm

use npmonly_sampleid, clear // these are the npm group of clhns in sampa 

// select a sample
set seed 123456

tempfile 1 2 3 4

// sample the poportion for agecat1 by sex -  Maybe, this keeps only the sample obs

sample `agecat1' , by(sex)

// label them 
gen sample = 1

save `1'

// go back to npmonly_sampleid

use npmonly_sampleid, clear

merge id using `1' 

// Sample for agecat2 by sex, only among those not previoiusly sampled

sample `agecat2' if sample != 1, by(sex)

/ label them 
gen sample = 2

save `2'

repeat

*** deal with samples selected for the month but without the data 

