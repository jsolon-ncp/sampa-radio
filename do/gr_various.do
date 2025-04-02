egen age_cat = cut(age), group(5)

local filter "if assay_trypsinogen==1"
gr box ct_pan_vol  `filter', over(age_cat) ///
								medtype(marker) ///
								medmarker(msymbol(D) msize(small) mlstyle(none))
								
violinplot ct_pan_vol, over(age_cat) vertical

violinplot pan_head_ap pan_head_trans, over(age_cat) vertical

gr box pan_head_ap pan_head_trans, over(age_cat, gap(*6)) legend(pos(6))

scatter pan_head_trans height || lfitci pan_head_trans height

scatter ct_pan_head_trans height, msize(tiny) mcolor(red) msymbol(D) || ///
scatter pan_head_trans height, msize(tiny) mcolor(cyan) msymbol(oh)|| ///
 lfitci ct_pan_head_trans height, legend(pos(6)) || ///
  lfitci pan_head_trans height, legend(pos(6)) ||
  
  
  preserve
drop if ct2!=1  
scatter ct_pan_head_ap weight, msize(tiny) mcolor(red) msymbol(D) || ///
scatter pan_head_ap weight, msize(tiny) mcolor(cyan) msymbol(oh)|| ///
 lfitci ct_pan_head_ap weight, legend(pos(6)) || ///
  lfitci pan_head_ap weight, legend(pos(6)) 
  
  restore
  
preserve
drop if ct2!=1  
  scatter ct_pan_head_trans age, msize(tiny) mcolor(red) msymbol(D) || ///
scatter pan_head_trans age, msize(tiny) mcolor(cyan) msymbol(oh)|| ///
 lfitci ct_pan_head_trans age, legend(pos(6)) || ///
  lfitci pan_head_trans age, legend(pos(6)) 
  
  restore
 
correl ct_pan_head_ap age 
correl ct_pan_head_trans age 

spearman ct_pan_head_trans age 
spearman ct_pan_head_ap age 
 
  preserve
drop if ct2!=1  
  scatter ct_pan_body_trans age, msize(tiny) mcolor(red) msymbol(D) || ///
scatter pan_body_trans age, msize(tiny) mcolor(cyan) msymbol(oh)|| ///
 lfitci ct_pan_body_trans age, legend(pos(6)) || ///
  lfitci pan_body_trans age, legend(pos(6)) 
  
  restore
  
  
  preserve
drop if ct2!=1  
  scatter ct_pan_tail_trans age, msize(tiny) mcolor(red) msymbol(D) || ///
scatter pan_tail_trans age, msize(tiny) mcolor(cyan) msymbol(oh)|| ///
 lfitci ct_pan_tail_trans age, legend(pos(6)) || ///
  lfitci pan_tail_trans age, legend(pos(6)) 
  
  restore
  
  
 sysuse auto, clear 
set scheme s1color 
stripplot mpg, over(rep78) box(barw(0.1)) pctile(5) cumul cumprob height(0.5) boffset(-0.1) refline vertical yla(, ang(h))


sysuse auto, clear 
set scheme s1color 
stripplot ngml_trypsinogen, over(ever_mal) box(barw(0.1)) pctile(5) cumul cumprob height(0.5) boffset(-0.1) refline vertical yla(, ang(h))

* USS measurements correlate wiht age, bmi and height
spearman pan_head_ap age
spearman pan_head_ap bmi
spearman pan_head_ap height


spearman pan_head_trans age
spearman pan_head_trans bmi
spearman pan_head_trans height

spearman pan_body_trans age
spearman pan_body_trans bmi
spearman pan_body_trans height

spearman pan_tail_trans age
spearman pan_tail_trans bmi
spearman pan_tail_trans height

