/* an_radio_qc_intra_icc.do
Uses cr_radio_qc_intra_icc.do to create a long dataset

*Global Macros
global dropboxsampa "~/Cox working group Dropbox/TB Nutrition working group/Sampa"
global samparadio "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Analysis/Radiology"
global sampadata "~/Cox working group Dropbox/TB Nutrition working group/Sampa/DATA Management/04-data-delivered-v2/ALL/STATA"
cd ~
cd "$dropboxsampa"
cd "$samparadio"
cd "$sampadata"

cd "$samparadio"
*/


* SET LOCALS - Modify as needed

cd "$samparadio"
cd "02 do"
cd "do-drafts-paper1.5"
do cr_radio_qc_intra_icc.do
cd "$samparadio"

tempfile 0
save `0'.dta, replace


local cat_vars "1 2 3 4 5 6 7 8" 

collect clear
*set trace on

collect create c_intra_icc
 
* CALCULATE ICC 
foreach var of local cat_vars {
	use  `0'.dta, clear
	levelsof reader, local(readerlv)
		foreach j of local readerlv {
			use  `0'.dta, clear
			keep if reader==`j' & cat==`var'
			collect : table (command) (result), ///
				append ///
				command(icc_n = r(N_target) icc = r(icc_i) lci=r(icc_i_lb) uci = r(icc_i_ub) pval = r(icc_i_p) : icc read sampa_id intra) 
				}
			}


//#  LAYOUT

collect dims
collect levelsof result
collect layout (cmdset) (result[icc_n icc lci uci pval])
collect preview


*Tag the reader
	collect addtags reader["Radiologist 2"], fortags(cmdset[1 3 5 7 9 11 13 15])
		collect addtags reader["Radiologist 3"], fortags(cmdset[2 4 6 8 10 12 14 16])
		
* Tag the pancreatic dimensions
	collect addtags pancreas[a], fortags(cmdset[1 2])
		collect addtags pancreas[b], fortags(cmdset[3 4])
			collect addtags pancreas[c], fortags(cmdset[5 6])
				collect addtags pancreas[d], fortags(cmdset[7 8])
					collect addtags pancreas[e], fortags(cmdset[9 10])
						collect addtags pancreas[f], fortags(cmdset[11 12])
							collect addtags pancreas[g], fortags(cmdset[13 14])
								collect addtags pancreas[h], fortags(cmdset[15 16])					

* Number Formats
	collect style cell result, nformat(%4.3f)

	collect style cell result[icc_n], nformat(%4.0f)

* Composite column for CI

	collect composite define ci = lci uci, delimiter(-) trim

* Layout
/* This creates a table with a supercolumn of radiologists and showing the columns for ICC and CI per row which is the measured dimension)*/

collect layout (pancreas[h a b c d e f g]) (reader#result[icc_n icc ci])

* Rows
collect style header pancreas, title(hide)

collect label levels pancreas 	a "Body-Tail length" b "Body, Transverse" c "Body, Cranio-caudal" d "Head, Cranio-caudal" ///
								e "Head, Anteroposterior" f "Head, Transverse" g "Tail, Transverse" h "Calculated Volume", modify

collect preview
							
* Columns
collect label levels result icc_n "No." , modify
collect label levels result icc "ICC" , modify
collect label levels result ci "95% CI" , modify


* Text
collect title "Supplementary Table 1. Intra-reader Variability"

collect notes "Created by `c(username)' on `c(current_date)' at `c(current_time)' based on `c(filename)'"

collect preview

cd "$samparadio"
cd "03-tables"



collect export tab_qc_intra.html, as(html) replace
	collect export tab_qc_intra.docx, as(docx) replace 
	collect export tab_qc_intra.xlsx, as(xlsx) replace
	collect export tab_qc_intra.pdf, as(pdf) replace

* Save the table as its own collection

collect save c_intra_icc, replace

collect clear
collect use c_intra_icc
collect export test.html, as(html) replace
	