/* figures.do 
Sampa

Recreates graphs in version 12 of paper into 1 theme

Install these schemes in case we change
Default scheme is stcolor for Stata graphs

net install schemepack, from("https://raw.githubusercontent.com/asjadnaqvi/stata-schemepack/main/installation/") replace

See this for color schemes : https://github.com/asjadnaqvi/stata-schemepack/blob/main/README.md


Install user packages
net install blandaltman.pkg
net install upsetplot.pkg

Figure 1 CT upper abdomen scan slices showing dimensions measured.
Figure 2. Diagram showing overlap between participants with faecal elastase, ultrasound and CT scans.
Figure 3. Faecal elastase distribution by cohort and malnutrition status.
Figure 4. USS and CT measurements correlations


*/

capture log close
log using ./log/figures.log , replace

putdocx clear

//# ******************** FIGURES ********************

local filename "./figures/docfigures" // path and file name of file to be saved
local title "Figures"  // Header for the File

*** FIGURE A CT IMAGE

local fig1 "./figures/ct_meas.png"
local fig1head "Figure 1 CT upper abdomen scan slices showing dimensions measured."

local fig1text "a) axial anterior-posterior and transverse head diameters, b) coronal cranio-caudal head diameter, c) coronal cranio-caudal body diameters, d) axial anterior-posterior body and tail diameters, body, and d) length of body and tail."

*** FIGURE B VENN

local fig2 "./figures/venn_diagram_5.png"
local fig2head "Figure 2 Diagram showing overlap between participants with faecal elastase, ultrasound and CT scans."

local fig2text "Not shown are lipase, amylase and trypsinogen assays in participants.  Lipase measured only in DIVIDS."

*** FIGURE C Enzymes


** two enzymes 
local fig3a1 "./figures/figc_a_1.png"
local fig3a1head "Figure 3A Elastase and Amylase levels by malnutrition status."

local fig3a1text "NPM, not previously malnourished; PM, previously malnourished. Fecal elastase values were truncated at 600 µg/g. A fecal elastase value of <200 µg/g is regarded as evidence of exocrine pancreatic insufficiency. Median FE-1 375 ug/g in PM and 314 ug/g in NPM. Median amylase in PM 31.1 U/L in PM and 29.6 U/L in NPM.  Significant differences in enzyme levels by malnutrition status. Kruskal-wallis Chi squared and p values in graph."

** four enzymes 
local fig3a2 "./figures/figc_a_2.png"
local fig3a2head "Figure 3B Pancreatic Enzyme levels by malnutrition status."

local fig3a2text "NPM, not previously malnourished; PM, previously malnourished. Fecal elastase values were truncated at 600 µg/g and measured in all cohorts A fecal elastase value of <200 µg/g is regarded as evidence of exocrine pancreatic insufficiency. Median FE-1 375 ug/g in PM and 314 ug/g in NPM. Median amylase in PM 31.1 U/L in PM and 29.6 U/L in NPM measured in all but the cohort from India (DIVIDS).  Significant differences in FE-1 and amylase levels by past malnutrition exposure.  No significant differences in lipase levels (measured in DIVIDS) and trypsinogen levels(measured among those with CT Scans) by past malnutrition exposure. Kruskal-wallis Chi squared and p values in graph. "

* Scatter Plot four enzymes

local fig3b "./figures/figc_b.png"
local fig3bhead "Figure 3B Pancreatic Enzyme levels by Pancreas Size."

local fig3btext "Fecal elastase values were truncated at 600 µg/g. NPM, not previously malnourished; PM, previously malnourished. Spearman correlation coefficient and p values as shown."


/*
local fig3 "./figures/figc.png"
local fig3head "Figure 3 Faecal elastase distribution by cohort and malnutrition status."

local fig3text "Values were truncated at 600 µg/g. NPM, not previously malnourished; PM, previously malnourished. A value of <200 µg/g is regarded as evidence of exocrine pancreatic insufficiency.  Median levels are higher in Asian cohorts than African cohorts. "

*/
*** FIGURE D USS CT

local fig4 "./figures/figd.png"
local fig4head "Figure 4 Correlation of USS and CT measurements"

local fig4text "AP = Antero-posterior; All values above 4 cm removed for clarity. Spearman's correlation coefficient and p values shown. Correlation is significant for all dimensions except the transverse measurement of the tail which is the most difficult to visualize."


*** FIGURE E USS by PM or NPM by cohort

local fig5 "./figures/fige.png"
local fig5head "Ultrasound Measurement by PM or NPM in each cohort."

local fig5text "Pancreatic measurements by Ultrasound."



scatter fecal_elastase pan_head_ap



*** FIGURE F CONSORT

local fig5 "./figures/consort.png"
local fig5head "Supplementary Figure 1 Consort Diagram."

local fig5text "a) axial anterior-posterior and transverse head diameters, b) coronal cranio-caudal head diameter, c) coronal cranio-caudal body diameters, d) axial anterior-posterior body and tail diameters, body, and d) length of body and tail."

*** FIGURE F QC

local fig6 "./figures/qc_intra.png"
local fig6head "Figure 1 CT upper abdomen scan slices showing dimensions measured."

local fig6text "a) axial anterior-posterior and transverse head diameters, b) coronal cranio-caudal head diameter, c) coronal cranio-caudal body diameters, d) axial anterior-posterior body and tail diameters, body, and d) length of body and tail."

*** FIGURE G


//# ******************** CODE  ********************


putdocx begin, font(Arial, 11) pagenum(decimal) footer(npage)
putdocx paragraph, style(Title)
putdocx text ("`title'")
putdocx save `filename', replace

* Figure  1 CT Diagram 
putdocx begin, font(Arial,11)
putdocx paragraph, style(Heading1)
putdocx image `fig1'
putdocx paragraph
putdocx text ("`fig1head'")
putdocx text ("`fig1text'"), font(Arial,11)

putdocx save `filename', append


//# ******************** FIGURES ********************

