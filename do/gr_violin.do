/* gr_violin.do

Violin plots requires these packages

scc install violinplot
ssc install dstat
ssc install moremata
ssc install palettes
ssc install colrspace

*/

set scheme s2mono

tempfile 1 2 

local filter "if flag_fecal_elastase!=1"
violinplot fecal_elastase `filter', ///
by(fec_cohort) ///
split(ever_mal) ///
vertical 

gr save `1'.gph,  replace

violinplot fecal_elastase `filter', ///
by(ever_mal) ///
vertical 

gr save `2'.gph, replace

gr combine `1'.gph `2'.gph, title("Distribution of Fecal Elastase", span)

gr export ../../05-figures/violin_elastase.png, as(png) replace



/*
tempfile 1 2 

set scheme s2color
local filter "if flag_fecal_elastase!=1"
violinplot fecal_elastase `filter', pdf(ll(0)) noline fill(fcolor(%50) lcolor(%100)) over(exposuretime) overlay

local filter "if flag_fecal_elastase!=1"
violinplot fecal_elastase `filter', ///
by(cohort) ///
vertical 
