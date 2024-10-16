/* template_1.do

Notes
1. Needs at least Stata version 17 
2. Uses the table and the collect commands.
3. Uses putdocx.
4. Input : Wide dataset
5. Output : Table 1 in .docx  with:
- continuous variable summary mean SD 
- categorical variable frequencies and percentages across groups
- Supercolumn and columns (eg cohort and nutritional status)
- Rows as variables being reported across columns
6.  Coding notes
-  Percentages must compare columns and requires using "i." before the categorical variable in the code and "across()"
- every summary statistic is placed as a separate line for ease of revision.
- Indent the stats and Indent the formats for clarity
- the IQR, and confidence intervals have to be combined into one column see statalist suggestion (see sources)
7. Exclusions
- statistical tests
- median
- footnotes
- p values CIs of stat test significance testing

Sources

*Stata Blog by Chuck Huber the Classit Table 1 for Stata 17
https://blog.stata.com/2021/06/24/customizable-tables-in-stata-17-part-3-the-classic-table-1/

* Statalist - code for formatting iqr using collect.
https://www.statalist.org/forums/forum/general-stata-discussion/general/1690975-formatted-iqr-using-collect

*/

*. Create dataset and a new binary variable x


sysuse bpwide, clear
set seed 314159265 
bysort patient : gen x = runiformint(0, 1) if _n == 1 
by patient: replace x = x[1]



** Multiway table of continuous and categorical variables.  This creates a collection and names it c1.  Not essential.
collect clear
collect create c1, replace


* Generate summaries and frequencies with supercolumn (agegrp) and column (x)
table (var)(agegrp x) , ///
	statistic(mean bp_before bp_after) ///
	statistic(sd bp_before bp_after) ///
	statistic(fvfrequency sex) ///
	statistic(percent i.sex, across(x)) ///
		nototals ///
		nformat(%5.0f percent) ///
		nformat(%5.1f mean) ///
		nformat(%5.2f  sd) 

* recodes mean and sd in the collection to columns 1 and 2
collect recode result mean = column1
collect recode result sd = column2


* recodes fvfrequency and percent in the collection to columns 1 and 2
collect recode result fvfrequency = column1
collect recode result percent = column2

collect label list result, all

* Table 1 Layout Super column - column 
collect layout (var) (agegrp#x#result[column1 column2])

* Header - hide stuff
collect style header result, level(hide) /* this removes column 1 and column2 header names*/
collect style header x, title(hide) /* this removes the column variable name or label by hiding it */

* Header - change text in headers
collect label dim agegrp "Patient Age Group", modify
collect label levels x 0 "NPM" 1 "PM", modify

* Rows - change text in rows
collect label levels var 0.sex "Male" 1.sex "Female", modify /* This changes the level of sex to male and female*/
collect label levels var bp_before "BP Before" bp_after "BP After", modify 

* format factor variables (categorical) column 1
collect style cell var[0.sex 1.sex]#result[column1], nformat(%5.0f) /*Formats factor number */ 

* format factor variables (categorical) column 2
collect style cell var[0.sex 1.sex]#result[column2], nformat(%5.0f) sformat("(%s%%)") /* Adds (%) to percent */

* format continuous variables column 1
collect style cell var[bp_before bp_after]#result[column1 column2], nformat(%5.1f) /* Formats continuous variable to one decimal*/

* format continuous variables column 2 
. collect style cell var[bp_before bp_after]#result[column2], sformat("(%s)") /* Adds parenthesis after SD*/


collect preview

* Customize Column Labels

* Modify supercolumn name - can be done without replacing variable labels with replace variable label "label"

collect label dim agegrp "Patient Age Group", modify

* Modify column name 

collect label levels x 0 "NPM" 1 "PM", modify

* Revise header style to hide levels of a dimension, in this case, the dimension of results (ie what you would see in collect levelsof )

collect style header result, level(hide)

* Revised rows style

collect style row stack, nobinder spacer

collect style cell border_block, border(right, pattern(nil))

collect preview

* Export to Word
* Check your present working directory as this file saves there.  Alternatively ,specify relative path

cd "$dropboxradio" /* change to your pwd or any desired folder */

putdocx begin /* Start of Word Input*/
	putdocx paragraph, style(Heading1)
		putdocx text ("Table 1. Participant Charateristics")
	putdocx paragraph, style(Heading1)
		putdocx text ("x") 
	putdocx paragraph
		putdocx text ("stuff ") 
		putdocx text ("stuff stuff ")
		putdocx text ("stuff stuff stuff .")
	collect style putdocx, layout(autofitcontents) ///  use layout(autofitcontents) to retain original width of table */
	title("Table 1: Charateristics by Cohort and Nutritional STatus")
	putdocx collect /*exports our table to the document*/
	putdocx save template_tab1.docx, replace


cd "$dropboxradio" /* change to your pwd or any desired folder */

/* Other summaries 

table (var) (sex), statistic(p50 age_adm_m) statistic(p25 age_adm_m) statistic(p75 age_adm_m) nototals
collect style cell result[p25 p50 p75], nformat("%4.1f")
collect composite define iqr = p25 p75 , delimiter(" - ") trim
collect style cell result[iqr], sformat("(%s)")
collect composite define mediqr = p50 iqr, trim

collect style header result, level(hide)
collect style row stack, nobinder spacer
collect style cell border_block, border(right, pattern(nil))
collect layout (var) (sex#result[mediqr])


media
/* Alternative start .dta xample - Ignore


use https://www.stata-press.com/data/r18/nhanes2l, clear

collect clear

 sort sex region
 
 collect: by sex region: summarize weight
 
 collect layout (sex) (region) (result[mean])
 
 collect layout (region[1] region[3] region[4]) (sex[2]) (result[mean])
 
 collect layout (sex#region) (result[mean])
 
 collect layout (sex#region) () (result[mean])
 
 collect layout (sex#region#result[mean])
 
 collect layout (sex#region) (result)
 
 collect style cell result, nformat(%6.2f)
 
  collect style cell result, nformat(%9.0g)
  
  collect preview
  
  collect layout (region) (sex) (result[N])
  
  collect layout (sex#result[mean N]) (region)
  
  collect layout (region#result[mean min max]) (sex)
  
  
  collect layout (region#result[mean min max]) (sex)
  
  
  * Regression
  
  collect clear
  collect : regress bpsystol age weight  
  collect : regress bpsystol age weight i.hlthstat
  
  collect label list cmdset, all
  
  collect style autolevels result _r_b _r_se
collect layout (colname#result) (cmdset)
  
  statistic(p50 bp_before bp_after)
  
  
  table (var) (sex), ///
    statistic(frequency) ///
    statistic(p50 age_adm_m) statistic(p25 age_adm_m) statistic(p75 age_adm_m) ///
    statistic(fvfrequency age_adm_cat) statistic(fvpercent age_adm_cat) ///
    nototals

// Give Frequency of categorical vars and median of continuous vars the same label:
collect recode result frequency=col1 fvfrequency=col1 p50=col1

// Give percent of categorical vars and 25th percentile of continuous vars the same label:
collect recode result fvpercent=col2 p25=col2

// Recode 75th percentile to a third column:  
collect recode result p75=col3 

// Format median: 
collect style cell result[col1]#var[age_adm_m], nformat("%4.1f")

// Add IQR formatting to p25 and p75 separately:
collect style cell result[col2]#var[age_adm_m], nformat("%4.1f") sformat("(%s -")
collect style cell result[col3]#var[age_adm_m], nformat("%4.1f") sformat("%s)")

// Put % after percent:
collect style cell result[col2]#var[age_adm_cat], nformat("%4.1f") sformat("%s%%")

// Create composite result:
collect composite define col4 = col2 col3

collect style header result, level(hide)
collect style row stack, nobinder spacer
collect style cell border_block, border(right, pattern(nil))
collect layout (var) (sex#result[col1 col4])


  