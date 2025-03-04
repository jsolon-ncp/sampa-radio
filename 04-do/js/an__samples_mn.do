/*
Sampa
an__samples_mn.do 
Juan Solon 
March 2025
bivariate anaysis - of all lab assays by mn 

assay_fecal_elastase
assay_amylase
assay_lipase
assay_trypsinogen
ever_mal
*/


table () (cohort ever_mal), stat(fvpercent 1.assay_f) 

collect export 03-tables/bivariate_assays.html, as(html) replace

* CREATE A COUNT VARIABLE - modify accordingly - this should count the analysis dataset for the table ; used in frequency stats

gen N=1

* CREATE LOCAL MACROS FOR VARIABLES IN TABLE - USE COMPLETE VARIABLE NAME)
	local scol "cohort"
	local col "ever_mal"
	local contn "fecal_elastase" /*continous variables; mean (sd) will be reported*/
	local contmed ""  /*continous variables; median (p25-p75)  will be reported*/
	*local contgm "zinc"  /*continous variables geometric mean (sd) will be reported*/
	local cat "1.assay_fecal_elastase" /* categorical with multiple levels n(%) */
	*local ind "sex" 

* CREATE LOCAL MACROS FOR STANDARD TABLE HEADER 
	local colhead1 "Cohort"

	local colhead2 `"0 "NPM" 1 "PM""'
		
* IDENTIFY ROW VARIABLE HEADERS TO HIDE (SHOWING ONLY LEVELS - EG MALE FEMALE AND NO "SEX")		

local hiderows "sex"

* STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  STOP !  
* THERE IS NOTHING TO MODIFY BEYOND THIS LINE UNLESS CHANGING CODE. 

* GENERATE TABLE STATS 

	table (var)(`scol' `col') , ///
		stat(count N) ///
		stat(mean `contn') ///
		stat(sd `contn') ///
		stat(fvfrequency `ind' `cat') ///
		stat(percent `ind'  `cat', across(`col')) ///
			nototals ///
			nformat(%5.0f percent) ///
			nformat(%5.1f mean p25 p50 p75) ///
			nformat(%5.2f sd) ///
			command(regress assay_fecal_elastase ever_mal)

collect layout (var#statcmd#result[_r_b _r_p]#colname) (cohort#ever_mal)

   Rows: var#statcmd#result#colname
   Columns: cohort#ever_mal


collect export 03-tables/bivariate_assays.html, as(html) replace

**# Who has fecal elastase assays?


regress assay_fecal_elastase ever_mal
