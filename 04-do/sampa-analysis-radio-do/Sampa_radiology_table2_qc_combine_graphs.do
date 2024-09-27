
clear

set more off
// Set up the working directory
// Determine if the person running the do-file is in the Dropbox Working Group
// or using an individual one
cap confirm file "~/Cox working group Dropbox/"
if _rc == 0 global dropbox = "~/Cox working group Dropbox/SAMPA/Data analysis"
else global dropbox = "~/Dropbox/Data analysis"



cd "$dropbox/Radiology"



//Table 1


graph combine "figures/table2/gph/bland_difference_all_readbody_tail_r3_readbody_tail_r3_intra.gph" ///
              "figures/table2/gph/bland_difference_5_readbody_tail_ct_readbody_tail_r3.gph", ///
              graphregion(color(white))
			  			  			  





///
graph combine "figures/table2/gph/bland_difference_5_readbody_tail_ct_readbody_tail_r2.gph" ///
              "figures/table2/gph/bland_difference_5_readbody_tail_ct_readbody_tail_r3.gph", ///
              graphregion(color(white))
			  			  			  
graph export "./figures/table2/bland_combine_diff_5_readbody_tail_ct_readbody_tail.svg", replace

graph combine "figures/table2/gph/bland_difference_6_readbody_tail_ct_readbody_tail_r2.gph" ///
              "figures/table2/gph/bland_difference_6_readbody_tail_ct_readbody_tail_r3.gph", ///
              graphregion(color(white))
			  			  			  
graph export "./figures/table2/bland_combine_diff_6_readbody_tail_ct_readbody_tail.svg", replace


graph combine "figures/table2/gph/bland_difference_3_readbody_tail_ct_readbody_tail_r2.gph" ///
              "figures/table2/gph/bland_difference_3_readbody_tail_ct_readbody_tail_r3.gph", ///
              graphregion(color(white))
			  			  			  
graph export "./figures/table2/bland_combine_diff_3_readbody_tail_ct_readbody_tail.svg", replace

graph combine "figures/table2/gph/bland_difference_4_readbody_tail_ct_readbody_tail_r2.gph" ///
              "figures/table2/gph/bland_difference_4_readbody_tail_ct_readbody_tail_r3.gph", ///
              graphregion(color(white))
			  			  			  
graph export "./figures/table2/bland_combine_diff_4_readbody_tail_ct_readbody_tail.svg", replace





//Table 2

///
graph combine "figures/table2/gph/bland_difference_5_readbody_tail_ct_readbody_tail_r2.gph" ///
              "figures/table2/gph/bland_difference_5_readbody_tail_ct_readbody_tail_r3.gph", ///
              graphregion(color(white))
			  			  			  
graph export "./figures/table2/bland_combine_diff_5_readbody_tail_ct_readbody_tail.svg", replace

graph combine "figures/table2/gph/bland_difference_6_readbody_tail_ct_readbody_tail_r2.gph" ///
              "figures/table2/gph/bland_difference_6_readbody_tail_ct_readbody_tail_r3.gph", ///
              graphregion(color(white))
			  			  			  
graph export "./figures/table2/bland_combine_diff_6_readbody_tail_ct_readbody_tail.svg", replace


graph combine "figures/table2/gph/bland_difference_3_readbody_tail_ct_readbody_tail_r2.gph" ///
              "figures/table2/gph/bland_difference_3_readbody_tail_ct_readbody_tail_r3.gph", ///
              graphregion(color(white))
			  			  			  
graph export "./figures/table2/bland_combine_diff_3_readbody_tail_ct_readbody_tail.svg", replace

graph combine "figures/table2/gph/bland_difference_4_readbody_tail_ct_readbody_tail_r2.gph" ///
              "figures/table2/gph/bland_difference_4_readbody_tail_ct_readbody_tail_r3.gph", ///
              graphregion(color(white))
			  			  			  
graph export "./figures/table2/bland_combine_diff_4_readbody_tail_ct_readbody_tail.svg", replace


///

graph combine "figures/table2/gph/bland_difference_5_readcc_head_ct_readcc_head_r2.gph" ///
              "figures/table2/gph/bland_difference_5_readcc_head_ct_readcc_head_r3.gph", ///
              graphregion(color(white))
			  			  			  
graph export "./figures/table2/bland_combine_diff_5_readcc_head_ct_readcc_head.svg", replace

graph combine "figures/table2/gph/bland_difference_6_readcc_head_ct_readcc_head_r2.gph" ///
              "figures/table2/gph/bland_difference_6_readcc_head_ct_readcc_head_r3.gph", ///
              graphregion(color(white))
			  			  			  
graph export "./figures/table2/bland_combine_diff_6_readcc_head_ct_readcc_head.svg", replace


graph combine "figures/table2/gph/bland_difference_3_readcc_head_ct_readcc_head_r2.gph" ///
              "figures/table2/gph/bland_difference_3_readcc_head_ct_readcc_head_r3.gph", ///
              graphregion(color(white))
			  			  			  
graph export "./figures/table2/bland_combine_diff_3_readcc_head_ct_readcc_head.svg", replace

graph combine "figures/table2/gph/bland_difference_4_readcc_head_ct_readcc_head_r2.gph" ///
              "figures/table2/gph/bland_difference_4_readcc_head_ct_readcc_head_r3.gph", ///
              graphregion(color(white))
			  			  			  
graph export "./figures/table2/bland_combine_diff_4_readcc_head_ct_readcc_head.svg", replace


graph combine "figures/table2/gph/bland_difference_3_readbody_tail_ct_readbody_tail_r2.gph" ///
              "figures/table2/gph/bland_difference_4_readbody_tail_ct_readbody_tail_r2.gph" ///
			  "figures/table2/gph/bland_difference_5_readbody_tail_ct_readbody_tail_r2.gph" ///
              "figures/table2/gph/bland_difference_6_readbody_tail_ct_readbody_tail_r2.gph", ///
              graphregion(color(white))
			  			  			  
graph export "./figures/table2/bland_combine_diff_radio2_readbody_tail_ct_readbody_tail.svg", replace



graph combine "figures/table2/gph/bland_difference_3_readbody_tail_ct_readbody_tail_r3.gph" ///
              "figures/table2/gph/bland_difference_4_readbody_tail_ct_readbody_tail_r3.gph" ///
			  "figures/table2/gph/bland_difference_5_readbody_tail_ct_readbody_tail_r3.gph" ///
              "figures/table2/gph/bland_difference_6_readbody_tail_ct_readbody_tail_r3.gph", ///
              graphregion(color(white))
			  			  			  
graph export "./figures/table2/bland_combine_diff_radio3_readbody_tail_ct_readbody_tail.svg", replace











bland_difference_6_readcc_head_ct_readcc_head_r2



graph combine "figures/table2/gph/bland_percentmean_5_readcc_head_ct_readcc_head_r2.gph" ///
              "figures/table2/gph/bland_percentmean_5_readcc_head_ct_readcc_head_r3.gph" ///
			  "figures/table2/gph/bland_percentmean_6_readcc_head_ct_readcc_head_r2.gph" ///
			  "figures/table2/gph/bland_percentmean_6_readcc_head_ct_readcc_head_r3.gph", ///
              graphregion(color(white))
			  
			  			  
graph export "./figures/table2/bland_combine_diff_PHIL_readhead_ap_ct_readhead_ap.svg", replace








