/*
an_cont_assays.do 

*/

local filter "if flag_fecal_elastase !=1"
table () (ever_mal) `filter', ///
stat(frequency) /// 
stat(mean fecal_elastase) ///
stat(p50 fecal_elastase)

* All FE-1
local filter "if flag_fecal_elastase !=1"
tobit fecal_elastase ever_mal cohort age sex child_adult fec_cohort `filter', ul(600)

* FE-1 of EPI
local filter "if flag_fecal_elastase !=1"
tobit fecal_elastase ever_mal cohort age sex child_adult fec_cohort `filter', ul(200)

