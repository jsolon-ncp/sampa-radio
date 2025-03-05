/* gr_violin.do

Violin plots requires these packages

scc install violinplot
ssc install dstat
ssc install moremata
ssc install palettes
ssc install colrspace

*/

set scheme s2mono

local filter "if flag_fecal_elastase!=1"
violinplot fecal_elastase `filter', by(cohort)

gr export violin_elastase.png, as(png)
