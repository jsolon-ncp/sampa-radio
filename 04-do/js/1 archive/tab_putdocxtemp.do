

putdocx begin /* Start of Word Input*/
	putdocx paragraph, style(Heading1)
		putdocx text ("Table 1. Participant Charateristics")
	putdocx paragraph, style(Heading1)
		putdocx text ("Data Subset: Imaging and Elastase") 
	putdocx paragraph
		putdocx text ("Hypertension is a major cause of morbidity and mortality in ") 
		putdocx text ("the United States. This report will explore the predictors ")
		putdocx text ("of hypertension using the NHANES dataset.")
	collect style putdocx, layout(autofitcontents) ///  use layout(autofitcontents) to retain original width of table */
	title("Table 1: Charateristics by Cohort and Nutritional STatus")
	putdocx collect /*exports our table to the document*/
	putdocx save impe_tab1.docx, replace
