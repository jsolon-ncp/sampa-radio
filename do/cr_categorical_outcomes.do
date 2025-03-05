/*
cr_categorical_outcomes.do 		
Sampa
Imaging Elastase Paper

Recodes fecal_elastase to with or without EPI and levels of EPI
Include here any recoding of other functional enzymes

Reusable with
	1.  Access to Dropbox
	2.  Define globals and paths
	3.  A working directory with 
	01-data
	02-data-temp
	03-tables
	04-do
	05-figures
	log 
*/

egen epi_binary = cut(fecal_elastase), at(0,200,601) icodes
	la var epi_binary "EPI"
	recode epi_binary 0 = 1 1 = 0
	

	label define epi_binary 0 "Without EPI" 1 "With EPI"
	label values epi_binary epi_binary
	

egen epi_ordinal = cut(fecal_elastase), at(0,100,200, 601) icodes
	la var epi_ordinal "EPI Levels"
	recode epi_ordinal 0 = 3 1 = 2 2 = 1 

	label define epi_ordinal 1 "Without EPI" 2 "Mild-Moderate EPI" 3 "Severe EPI"
	label values epi_ordinal epi_ordinal
