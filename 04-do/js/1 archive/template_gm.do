
** Global macros
global datapath = "your datapath"
global savetables = "your path to save tables"

** Use dataset /*path to your analysis dataset*/
local dataset "nhanes2l"

*. Use dataset /* revise as use*/

* cd "$datapath"
webuse `dataset', clear

* cd "$savetables"

* CREATE A COUNT VARIABLE - modify accordingly - this should count the analysis dataset for the table ; used in frequency stats

gen N=1


** RELABEL CONTINUOUS VARIABLES FOR TABLE /* Revise as you would want to appear in table*/

label variable age "Age in years;  Mean(SD)"
label variable bmi "BMI ; Mean(SD)"
label variable hgb "Haemoglobin (g/dL)  ; Median(p25 - p75)"
label variable zinc "Serum Zinc (mcg/dL)  ; Geometric Mean (CI)"

* CREATE LOCAL MACROS FOR VARIABLES IN TABLE - USE COMPLETE VARIABLE NAME)
	local scol "region"
	local col "diabetes"
	local contn "age bmi"
	local contmed "hgb"
	local contgm "zinc"
	local cat "hlthstat"
	local ind "sex"

* CREATE LOCAL MACROS FOR STANDARD TABLE HEADER 
	local colhead1 "Modified Supercolumn name"

	local colhead2 `"0 "grpa" 1 "grpb""'
	
	\\
