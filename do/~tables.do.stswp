/*
tables.do 
Sampa
U+00Bx - 2,3,9(for 1)
U+207x - 0,1,4,5,6....
*/

************************************************************* COLLECTIONS *************************************************************
cohort1
equipment - ./tables/table_equipment.docx

uss_meas
ct_meas
adj_radio

uss_findings
uss_incidental
ct_findings
ct_incidental

agree_inter_reader
agree_intra_reader
agree_uss_ct

*************************************************TABLES Number Headings Text ************************************************

local filename "./tables/doctables" // path and file name of file to be saved
local title "Tables"  // Header for the File

*** Table 1 Participants

local tab1 "./tables/cohort1"
local tab1_title "Figure 1 CT upper abdomen scan slices showing dimensions measured."
local tab1_text "a) axial anterior-posterior and transverse head diameters, b) coronal cranio-caudal head diameter, c) coronal cranio-caudal body diameters, d) axial anterior-posterior body and tail diameters, body, and d) length of body and tail."


*** Table 2 Participants

local tab2 "./tables/cohort1"
local tab2_title "Figure 1 CT upper abdomen scan slices showing dimensions measured."
local tab2_text "a) axial anterior-posterior and transverse head diameters, b) coronal cranio-caudal head diameter, c) coronal cranio-caudal body diameters, d) axial anterior-posterior body and tail diameters, body, and d) length of body and tail."

*** Table 2 Participants

*** Table 2 Participants

*** Table 2 Participants

*** Table 2 Participants

*** Table 2 Participants

*** Table 2 Participants

*** Table 2 Participants

*** Table 2 Participants



//# ******************** CODE  ********************
local filename "./tables/doctables" // path and file name of file to be saved
local title "Tables"  // Header for the File


* U+00Bx - 2,3,9(for 1)
* U+207x - 0,1,4,5,6....
local sup1 = ustrunescape("\u00B9")  // superscript 1
local sup2 = ustrunescape("\u00B2")  // superscript 2



putdocx clear
putdocx begin, font(Arial, 11) pagenum(decimal) footer(npage)
putdocx paragraph, style(Title)
putdocx text ("`title'")

* Example of superscript text using Unicode escape sequences
putdocx paragraph
putdocx text ("This is normal text with a superscript number`sup1'")
putdocx text (" and another superscript`sup2'")


putdocx save `filename', replace

* Figure  1 CT Diagram 
putdocx begin, font(Arial,11)
putdocx paragraph, style(Heading1)
putdocx image `fig1'
putdocx paragraph
putdocx text ("`fig1head'")
putdocx text ("`fig1text'"), font(Arial,11)

putdocx save `filename', append



