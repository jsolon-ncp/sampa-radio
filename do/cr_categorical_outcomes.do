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
	
	
egen tryp_low = cut(ngml_trypsinogen), at(0,10,300) icodes
	la var tryp_low "Low trypsinogen"
	recode tryp_low 0 = 1 1 = 0
	

	label define tryp_low 0 "Normal to High Trypsinogen" 1 "Low Trypsinogen"
	label values tryp_low tryp_low
	
egen tryp_high = cut(ngml_trypsinogen), at(0,57,300) icodes
	la var tryp_high "High trypsinogen"
	recode tryp_high 0 = 1 1 = 0
	
	label define tryp_high 0 "Low to Normal Trypsinogen" 1 "High Trypsinogen"
	label values tryp_high tryp_high
	
egen amyl_low = cut(ul_amylp), at(0,57,182) icodes
la var amyl_low "Low Serum Amylase"
recode amyl_low 0 = 1 1 = 0

	label define amyl_low 0 "Normal to High Amylase" 1 "Low Amylase"
	label values amyl_low amyl_low
