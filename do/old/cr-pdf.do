collect style putpdf, ///
         title("Table 1: Descriptive Statistics of Participants with Ultrasound by Cohort") ///
		 note ("Fix labels for frequency, percenage mean age sd age")

putpdf begin
putpdf paragraph
putpdf text ("Fix labels for frequency, percenage mean age sd age")
putpdf collect
putpdf save samparadio1-b.pdf  

collect export samparadio1.pdf, as(pdf) replace
