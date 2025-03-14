/*
an_cont_assays.do 

*/

table () (ever_mal) , ///
stat(frequency) /// 
stat(mean fecal_elastase) ///
stat(p25 fecal_elastase) ///
stat(p50 fecal_elastase) ///
stat(p75 fecal_elastase) ///
stat(iqr fecal_elastase)

table () (subcoh_child_adult) , ///
stat(frequency) /// 
stat(mean fecal_elastase) ///
stat(p25 fecal_elastase) ///
stat(p50 fecal_elastase) ///
stat(p75 fecal_elastase) ///
stat(iqr fecal_elastase)

table () (subcoh_geography) , ///
stat(frequency) /// 
stat(mean fecal_elastase) ///
stat(p25 fecal_elastase) ///
stat(p50 fecal_elastase) ///
stat(p75 fecal_elastase) ///
stat(iqr fecal_elastase)

* All FE-1

ranksum fecal_elastase,by(ever_mal)
kwallis fecal_elastase,by(ever_mal)

kwallis fecal_elastase,by(subcoh_child_adult)
kwallis fecal_elastase,by(subcoh_geography)

tobit fecal_elastase ever_mal cohort age sex child_adult fec_cohort `filter', ul(600)

* FE-1 of EPI

tobit fecal_elastase ever_mal cohort age sex child_adult fec_cohort `filter', ul(200)

