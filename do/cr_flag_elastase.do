/*
cr_flag_elastase.do 			
Flags the elastase samples that should not be analyzed based on ELISA standards ; n = 90
J Solon
March 3 2025

Once this flag is made, this has to be added to the analysis dataset
*/


tempfile 1 2 3

sort sampa_id

save `1'

***  IMPORT ZAMBIA ELISA DATA (PLATE DROPPED)

frame create plate
frame change plate

cd data-temp

import excel using "Plate 1 results.xlsx" ,cellrange(A2) first   

cd ../

gen flag_fecal_elastase = 1

rename SampaID sampa_id

keep sampa_id flag_fecal_elastase

sort sampa_id

save `2'

frame change sampa

merge 1:1 sampa_id using `2', keep(match master)

drop _merge
