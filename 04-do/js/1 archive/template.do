/* template.do

This template is based on 
https://blog.stata.com/2021/06/24/customizable-tables-in-stata-17-part-3-the-classic-table-1/

but modified to handle multiway tables 
This uses a system dataset bpwide ad adds a binary variable to serve as a column group
Agegrp in bpwide is used as the supercolumn.

alternatively, this may be used webuse nhanes2l, clear
*/

*. Create dataset new categorical variable x
sysuse bpwide, clear
set seed 314159265 
bysort patient : gen x = runiformint(0, 1) if _n == 1 
by patient: replace x = x[1]

** Multiway table of continuous and categorical variables
collect clear
collect create c1, replace

* Generate summaries and frequencies
table (var)(agegrp x) , ///
statistic(mean bp_before bp_after) ///
statistic(sd bp_before bp_after) ///
statistic(median bp_before bp_after) ///
statistic(iqr bp_before bp_after) ///
statistic(fvfrequency sex) ///
statistic(percent i.sex, across(x)) ///
nototals ///
nformat(%5.0f percent) ///
nformat(%5.1f mean) ///
nformat(%5.2f  sd) 

* recodes mean and sd in the collection to columns 1 and 2
collect recode result mean = column1
collect recode result sd = column2

* recodes median and iqr in the collection to columns 1 and 2
collect recode result median = column1
collect recode result iqr = column2

* recodes mean and sd in the collection to columns 1 and 2
collect recode result mean = column1
collect recode result sd = column2


* recodes fvfrequency and percent in the collection to columns 1 and 2
collect recode result fvfrequency = column1
collect recode result percent = column2

collect label list result, all

* Table 1 Layout Super column - column 
collect layout (var) (agegrp#x#result[column1 column2])

* format factor variables (categorical) column 1
collect style cell var[sex]#result[column1], nformat(%6.0fc)

* format factor variables (categorical) column 2
collect style cell var[sex]#result[column2], nformat(%6.1f) sformat("%s%%")

* format continuous variables column 1
collect style cell var[bp_before bp_after]#result[column1 column2], nformat(%6.1f)

* format continuous variables column 2
. collect style cell var[bp_before bp_after]#result[column2], sformat("(%s)")

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
	putdocx save impe_tab1.docx, replace


cd "$dropboxradio" /* change to your pwd or any desired folder */

/* Other summaries 

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
  
  
  