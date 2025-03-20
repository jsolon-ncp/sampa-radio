/* figures.do 
Sampa

Recreates graphs in version 12 of paper into 1 theme

Install these schemes

net install schemepack, from("https://raw.githubusercontent.com/asjadnaqvi/stata-schemepack/main/installation/") replace

Install user packages
net install blandaltman.pkg
net install upsetplot.pkg

*/

capture log close
log using ./log/figures.log 

putdocx begin

putdocx paragraph, style(Title)
putdocx text ("Figures")


* Figure  1 CT Diagram 
putdocx paragraph, style(Heading1)
putdocx text ("Figure 1")
putdocx image --- ct
fig_ct_upperab_slice_meas



* Figure 2 Venn Diagram 

putdocx image --- venn


* Figure 3 Consort

putdocx image --- consort


* Figure 4 Faecal Elastase distribution by cohort and MN Status



* Figure 5 USS and CT Correlations

* Supplement Figure Bland Altman Agreement for Intra-Reader

* Supplement Figure  Bland Altman Agreement for Inter-Reader

* Supplement Figure 1

* Supplement Figure 1
