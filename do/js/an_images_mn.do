/*
an_images_mn.do 					
Sampa
J Solon
What is the proportion of samples with CT and USS per MN and cohort

The variables from redcap fail to categorize as 0  and 1
we use recoded variables
radio2
ct2 
for this purpose
*/

collect clear
table (cohort), statistic(frequency) ///
				statistic(fvfrequency 1.radio2 1.ct2) ///
				statistic(fvpercent 1.radio2 1.ct2) ///
				nformat(%5.0f fvpercent) 				

collect style cell result[fvpercent], sformat("(%s%%)")
			
collect title "Ultrasound and CT Scan by Cohort"
collect style title, font(,bold)

collect preview


table (ever_mal), statistic(frequency) ///
				statistic(fvfrequency 1.radio2 1.ct2) ///
				statistic(fvpercent 1.radio2 1.ct2) ///
				nformat(%5.0f fvpercent) 				

collect style cell result[fvpercent], sformat("(%s%%)")
			
collect title "Ultrasound and CT Scan by Malnutrition Status"
collect style title, font(,bold)

**# Images and Assays

local filter "if flag_fecal_elastase !=1" // these are dropped ELISA results

table (assay_fecal_elastase) `filter',statistic(frequency) ///
statistic(fvfrequency 1.radio2 1.ct2)

local filter "if flag_fecal_elastase !=1" // these are dropped ELISA results
table (assay_fecal_elastase radio2 ct2) `filter'

