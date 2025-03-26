/*  table_ct_organs.do 
Juan Solon
2025 Feb 

Purpose : Clean text data for other findings in ultrasound

Logic:
the variable pan_oth_abnormal is categorical and indicates whether there are other abnormalities
the variable pan_oth_abn_specify has the text details

This code generates specific findings per organ based on regexm 
Clinical input is made as to what the relevant categories are (further input here from team)
The organs are the liver, gallbladder, spleen, kidney 
There is initially  a variable called other_findings for those temporaraily classified (eg worms - to GI, etc)
and general_findings for other issues re ID, etc

output  : ct_organs
*/
version 18.5

* LOCAL DO FILE
local dofilename "09_table_ct_organs.do"

* LOCAL Output
local output "ct_organs"

* Working Directory

*cd "$ghsamparadio"

/* Make do file folder of paper the pwd
cd "$samparadio"
cd "do/"
cd "do-drafts-paper1.5"
*/

**# REFERENCE VARIABLES
/*  These are the USS Variables
pan_shape pan_shape_problem pan_shape_prob_specify pan_contour pan_contour_problem pan_contour_prob_specify pan_parenchyma pan_paren_inflam pan_paren_fibrosis pan_paren_steatosis pan_duct pan_duct_stones pan_duct_mass pan_calci pan_calci_place pan_cyst_yes pan_oth_abnormal pan_oth_abn_specify
*/

/* These are the CT Variables
ct_scan ct_date ct_time ct_pan_size_qual ct_pan_head_trans ct_pan_head_ap ct_pan_body_trans ct_pan_tail_trans ct_pan_body_tail ct_pan_cc_body ct_pan_cc_head 
ct_pan_shape ct_pan_shape_problem ct_pan_shape_prob_spec 
ct_pan_contour ct_pan_contour_problem ct_pan_contour_prob_spec 
ct_pan_parenchyma ct_pan_paren_inflam ct_pan_paren_fibrosis ct_pan_paren_steatosis 
ct_pan_duct ct_pan_duct_stones ct_pan_duct_mass ct_pan_calci ct_pan_calci_place 
ct_pan_oth_abnormal ct_pan_oth_abn_spec 
ct_image_qual ct_problem ct_problem_why name_ct sig_ct sig_ct_upload file_ct file_ct2 file_ct3 file_ct4 file_ct5 file_ct6 file_ct7 file_ct8 file_ct9 file_ct10 ct_pan_vol
*/

/* Some code to inspect outside Stata
**# Export ct vars if other organ abnormalities is true
* add quotes to the string so we can export the full string regardless of commas *
* gen  ct_pan_oth_abn_spec_q = `"""' +  ct_pan_oth_abn_spec + `"""'
* br ct_pan_oth_abn_spec
* export delimited cohort sampa_id ct_pan_oth_abnormal ct_pan_oth_abn_spec_q using 02-data-temp/ct_pan_oth_abn_spec.csv if ct_pan_oth_abnormal ==1, delim(",") replace
*/

**# CREATE NEW VARIABLES BASED ON OTHER FINDINGS VARIABLE 

/* Create organ involvement using regexm(lower(var),keywords)  */
capture gen ct_lung = regexm(lower(ct_pan_oth_abn_spec), "lung|pulmonary|lower nodular|linear densities|pleural|tuberculosis|tb|fibrocavitary|fibrosis|consolidation|infiltrate|pleural effusion|bronchiectasis|cavitation")
capture gen ct_liver = regexm(lower(ct_pan_oth_abn_spec), "liver|fatty infiltration|hepatic|hepatomegaly|cirrhosis|steatosis|hepatic lesion")
capture gen ct_gallbladder = regexm(lower(ct_pan_oth_abn_spec), "gallbladder|gallstone|cholelithiasis|biliary sludge|cholecystitis|gall stone| cholecystolithiasis|cholecystolithiases")
capture gen ct_spleen = regexm(lower(ct_pan_oth_abn_spec), "spleen|splenomegaly|splenic lesion|hypodense lesion|spenomegally")
capture gen ct_pancreas = regexm(lower(ct_pan_oth_abn_spec), "pancreas|pseudocyst|pancreatitis|pancreatic lesion|atrophy|pancreatic")
capture gen ct_kidney = regexm(lower(ct_pan_oth_abn_spec), "kidney|nephrolithiasis|renal|hydronephrosis|cortical thinning|renal cyst|nephrocalcinosis|calyces|calyceal|nephrolithiases|ureteroectacia")
capture gen ct_uterus_ovary = regexm(lower(ct_pan_oth_abn_spec), "uterus|ovary|fibroid|ovarian cyst|bulky uterus|endometrial thickening|adnexal mass|paraplegic")
capture gen ct_bone_spine = regexm(lower(ct_pan_oth_abn_spec), "bone|spine|spondyloarthropathy|lytic lesion|compression deformity|degenerative changes|osteophyte|vertebral|spondylosis|osseous")
capture gen ct_vascular = regexm(lower(ct_pan_oth_abn_spec), "vascular|atherosclerosis|atherosclerotic|aortic|iliac artery|aneurysm|thrombosis")
capture gen ct_heart = regexm(lower(ct_pan_oth_abn_spec), "heart|pericardial effusion|cardiomegaly")
capture gen ct_stomach_intestine = regexm(lower(ct_pan_oth_abn_spec), "stomach|gastric|diverticulosis|bowel wall thickening|colonic lesion|intestinal obstruction")
capture gen ct_adrenal = regexm(lower(ct_pan_oth_abn_spec), "adrenal|adrenal lesion|adrenal hyperplasia|adrenal adenoma")
capture gen ct_mass= regexm(lower(ct_pan_oth_abn_spec), "mass|ascitis|carcinomatosis|carcinoma|lymph nodes")

* Creates number of organs involved

local cat "ct_lung ct_liver ct_gallbladder ct_spleen ct_pancreas ct_kidney ct_uterus_ovary ct_bone_spine ct_vascular ct_heart ct_stomach_intestine ct_adrenal"
capture egen ct_organs = rowtotal(`cat')

/*QC of data (used during regex- keep )

* checks mass
local cat "ct_lung ct_liver ct_gallbladder ct_spleen ct_pancreas ct_kidney ct_uterus_ovary ct_bone_spine ct_vascular ct_heart ct_stomach_intestine ct_adrenal ct_mass"
br ct_pan_oth_abnormal ct_pan_oth_abn_spec ct_organs `cat' if ct_mass==1

* checks liver
local cat "ct_lung ct_liver ct_gallbladder ct_spleen ct_pancreas ct_kidney ct_uterus_ovary ct_bone_spine ct_vascular ct_heart ct_stomach_intestine ct_adrenal ct_mass"
br ct_pan_oth_abnormal ct_pan_oth_abn_spec ct_organs `cat' if ct_liver==1

* checks lung
local cat "ct_lung ct_liver ct_gallbladder ct_spleen ct_pancreas ct_kidney ct_uterus_ovary ct_bone_spine ct_vascular ct_heart ct_stomach_intestine ct_adrenal ct_mass"
br ct_pan_oth_abnormal ct_pan_oth_abn_spec ct_organs `cat' if ct_lung==1

* checks heart
local cat "ct_lung ct_liver ct_gallbladder ct_spleen ct_pancreas ct_kidney ct_uterus_ovary ct_bone_spine ct_vascular ct_heart ct_stomach_intestine ct_adrenal ct_mass"
br ct_pan_oth_abnormal ct_pan_oth_abn_spec ct_organs `cat' if ct_heart==1

* checks uterus
local cat "ct_lung ct_liver ct_gallbladder ct_spleen ct_pancreas ct_kidney ct_uterus_ovary ct_bone_spine ct_vascular ct_heart ct_stomach_intestine ct_adrenal ct_mass"
br ct_pan_oth_abnormal ct_pan_oth_abn_spec ct_organs `cat' if ct_uterus_ovary==1

* checks bone_spine
local cat "ct_lung ct_liver ct_gallbladder ct_spleen ct_pancreas ct_kidney ct_uterus_ovary ct_bone_spine ct_vascular ct_heart ct_stomach_intestine ct_adrenal ct_mass"
br ct_pan_oth_abnormal ct_pan_oth_abn_spec ct_organs `cat' if ct_bone_spine==1

* checks vascular
local cat "ct_lung ct_liver ct_gallbladder ct_spleen ct_pancreas ct_kidney ct_uterus_ovary ct_bone_spine ct_vascular ct_heart ct_stomach_intestine ct_adrenal ct_mass"
br ct_pan_oth_abnormal ct_pan_oth_abn_spec ct_organs `cat' if ct_vascular==1

* checks stomach
local cat "ct_lung ct_liver ct_gallbladder ct_spleen ct_pancreas ct_kidney ct_uterus_ovary ct_bone_spine ct_vascular ct_heart ct_stomach_intestine ct_adrenal ct_mass"
br ct_pan_oth_abnormal ct_pan_oth_abn_spec ct_organs `cat' if ct_stomach_intestine==1

* checks adrenal
local cat "ct_lung ct_liver ct_gallbladder ct_spleen ct_pancreas ct_kidney ct_uterus_ovary ct_bone_spine ct_vascular ct_heart ct_stomach_intestine ct_adrenal ct_mass"
br ct_pan_oth_abnormal ct_pan_oth_abn_spec ct_organs `cat' if ct_adrenal==1
*/


/* QC of pancreas in other findings */
/*
br sampa_id ct_pan_oth_abn_spec ct_pan_parenchyma ct_pan_paren_inflam ct_pan_paren_fibrosis ct_pan_paren_steatosis ///
ct_pan_duct ct_pan_duct_stones ct_pan_duct_mass ct_pan_calci ct_pan_calci_place  ct_pan_calci if ct_pancreas==1

50240 other findings calcification should be removed  as akready noted in categorical variable
50645 "unremarkable plain study of pancreas"
*/

/* Further cleaning of created vars*/

replace ct_pancreas =0 if sampa_id ==50240 // Calcification is already recorded and these are not other findings
replace ct_pancreas =0 if sampa_id == 50645 // the text says unremarkable findings of pancreas (flagged on regex because of pancreas)
**# CREATE TABLE USING DTABLE

count if ct2==1

local obs = r(N)

**#  TABLE CONFIGURATION 
local filter 	"if ct2==1"
local title "Supplement Table. Incidental Findings on CT Scan (N=`obs')"
local col "ever_mal"
local colhead2 `"0 "NPM" 1 "PM""'
local cat "1.ct_organs 1.ct_pancreas 1.ct_lung 1.ct_liver 1.ct_gallbladder 1.ct_spleen  1.ct_stomach_intestine 1.ct_kidney 1.ct_uterus_ovary 1.ct_bone_spine 1.ct_vascular 1.ct_heart  1.ct_adrenal 1.ct_mass"
local notes1 "Chi-square test between groups"
local notes2 "Numbers are Frequency(%). Participants may have multiple organ findings."
*local notes3 
*local notes4 "Remove in final : Created with "`dofilename'" on "`c(current_date)'" at "`c(current_time)'"  based on  "`c(filename)'"" 

**# TABLE CODE

dtable () `filter', by(`col', test nototals) ///
    factor(`cat', statistics(fvfrequency fvpercent) test(pearson)) ///
    title("`title'") ///
    note(`notes1') ///
	note(`notes2') 


**# Collection Dimensions and levels
/*
collect layout
collect dims 
 
 rows: var
 columns : ever_mal#result
 
 * The Text of the table is not aligned because dtable uses composite results
 collect query autolevels result
 collect query composite _dtable_stats

  _dtable_stats is composed offComposite: _dtable_stats
  Elements: frequency
            percent
            fvfrequency
            fvpercent
 */

**# TABLE LAYOUT

    collect style row stack, nobinder nospacer // * Stack levels of each variable , places/removes space between variables ; 

    collect style cell border_block, border(right, pattern(nil)) // Remove vertical line after variables
	
*** TABLE SPACES / WIDTH
collect style cell, margin(all, width(1.5)) // Define space b/w text and cell margins ;  default space in points is 1.5 between text and cell margin 

collect style column, width(asis) // Revise column width (equal or asis)
 
*** TABLE TEXT

* Table Styles
	collect style cell, font(Arial, size(11))
	collect style notes, font(Arial, size(11))

* Table title styles
	collect style title, font(Arial, size(11) bold)

* MODIFY TEXT

* Modify Header Text
    collect label levels ever_mal 0 "NPM" 1 "PM", modify
    collect style header ever_mal#result,title(hide)
	

* MODIFY row text

    collect label levels var _N "With CT Scans", modify

    collect label levels ct_pancreas 1 "Pancreas"
	collect label levels ct_lung 1 "Lungs", modify
    collect label levels ct_liver 1 "Liver", modify
    collect label levels ct_gallbladder 1 "Gall Bladder", modify
    collect label levels ct_spleen 1 "Spleen", modify
    collect label levels ct_kidney 1 "Kidney", modify
    collect label levels ct_uterus_ovary 1 "Uterus / Ovaries", modify
    collect label levels ct_bone_spine 1 "Bones", modify
    collect label levels ct_vascular 1 "Vascular", modify
    collect label levels ct_heart 1 "Heart", modify
    collect label levels ct_adrenal 1 "Adrenal", modify
    collect label levels ct_stomach_intestine 1 "GI tract", modify
    collect label levels ct_mass 1 "Masses", modify
	collect label levels ct_organs 1 "Any CT Finding", modify
  

****ROWS

 * LAYOUT to apply to  LEVELS OF A DIMENSION 
   
 *  collect style header var, level(label) // SHOW the label of ALL LEVELS of dimension var 
   
		* collect style header var, level(hide) // HIDES the labels of ALL LEVELS the levels of dimension var which includes the levels of the dimension and its levels
   
  
 * LAYOUT FOR EACH LEVEL implemented in a foreach loop that HIDES the title of the level but keeps labels of level
   * collect style header var[1.ct_lung], title(label) // hides the title or name of levels of the dimension leaving on the level's labels modified above
   
 * REMOVE level name in rows

	local varlevel "1.ct_lung 1.ct_liver 1.ct_gallbladder 1.ct_spleen 1.ct_pancreas 1.ct_kidney 1.ct_uterus_ovary 1.ct_bone_spine 1.ct_vascular 1.ct_heart 1.ct_stomach_intestine 1.ct_adrenal 1.ct_mass 1.ct_organs"
   
    foreach x in "`varlevel'" {
		collect style header var[`x'], title(hide)
	}

/* Check Table
    collect export organs.html, as(html) replace
    html2docx organs.html , saving(organs.docx) replace
*/
 
**# Create Composite Column so that counts and percentages are in separate columns
collect preview

collect composite define col1 = frequency fvfrequency
collect composite define col2 = fvpercent

* Clear autolevels
collect style autolevels result frequency percent fvfrequency fvpercent col4, clear

collect preview

**# Remove p values and replace with stars (from https://www.statalist.org/forums/forum/general-stata-discussion/general/1721778-dtable-formatting-problem #5)
* Note that this removes p values from the original dimension and moves it into new dimensoins

* the p-values are in composite _dtable_test: pearson 

collect query composite _dtable_test

* define stars rules using the p-value results

collect stars pearson .05 "*" .01 "**" .001 "***", dimension shownote

	* -collect stars- above added a new dimension, attaching -stars[value]-
	* to every existing item, and adding new items for the stars labels
	* tagged with -stars[label]-; but we don't need to see it's label or
	* levels in the header
	
collect style header stars, title(hide) level(hide)

* change the layout to show the stars instead of the p-values

collect layout (var) (ever_mal#result[col1 col2 pearson]#stars) // shows p values and stars


/* p value options
collect layout (var) (ever_mal#result[col1 col2 pearson]#stars[value]) // shows p values only

collect layout (var) (ever_mal#result[col1 col2 pearson]#stars[value]#stars[label]) // shows p values and stars

collect layout (var) (ever_mal#result[col1 col2 pearson]#stars[value]#stars[label]) // shows p values and stars
*/

**#  SAVE COLLECTION 

collect rename DTable ct_organs, replace
collect save ct_organs, replace

**# EXPORT

collect export ./tables/ct_organs.html, as(html) replace
html2docx ./tables/ct_organs.html , saving(organs.docx) replace
collect export ./tables/ct_organs_ms.docx, as(docx) replace
