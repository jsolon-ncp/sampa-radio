/* 	DETERMINATION OF BLOOD PRESSURE PERCENTILES IN NORMAL-WEIGHT CHILDREN - using STATA

	This STATA do-file was made by Prof Jan Sørensen, Royal College of Surgeons in Ireland, Dublin, Ireland 
	and MD Signe Bruun, Hans Christian Andersen Children's Hospital, Odense University Hospital, Odense, Denmark
	based on the SAS "%childhoodbppct" macro made by Prof Bernard Rosner, Harvard T.H. Chan School of Public
	Health, Boston, USA. The do-file was created using STATA 15.0. The do-file will import user data and add two
	variables to indicate the percentile of each individual's systolic and diastolic blood pressure.
	In case of any questions or comments, please contact signe.bruun@rsyd.dk.
	
	PRERARATIONS - IMPORTANT
	1. Download the files "ht_zscore.txt", "ht_zscore_inf.txt" and "quantreg_coef.txt" and save in same folder

	2. Save your own data in the same folder, and make sure you have at least the following variables
			a. id
			b. sex (1 is male and 2 is female)
			c. age (in years)
			d. agemon (in months)
			e. height (in cm)
			f. sysbp (systolic blood pressure in mmHg)
			g. diabp (diastolic blood pressure in mmHg)
          
	3. Set working directory to the folder, where you saved the abovementioned files
	
	4. Run the do-file STEPWISE, please note where to import your own data             */

*************************************************************************************************************

import delimited ht_zscore.txt, delimiter(space) clear
import delimited ht_zscore_inf.txt, delimiter(space) clear 
import delimited quantreg_coef.txt, delimiter(space) clear 

* The following creates the knots matrix for boys
clear
input x1 x2 x3 x4 x5
107.8 140.0 154.5 166.4 179.1  //t - relates to hight
5.06 10.79 13.22 14.51 17.30  //ta - for age
-15 8.9 50.375 112.685 250.04  //tb - age and height interaction
end
mkmat x1-x5 ,mat(t_1)
matrix list t_1 ,f(%7.2f)

* The following creates the knots matrix for girls
clear
input x1 x2 x3 x4 x5
106.7 140.7 154.0 160.5 168.9   //t
5.0 10.7 13.16 14.51 17.33  //ta
6.701 16.438 46.80 84.46 203.608  //tb
end
mkmat x1-x5 ,mat(t_2)
matrix list t_2 ,f(%7.2f)

/*	The following estimates the Z-scores of childrens' height based on 
	norm data on l m s by month of age, used for the detection of "outliers".
	The l m s norm data is stored in two files, one for infants (aged 0-36 months)
	and one for older children (aged 24-240 months). These two files are combined and 
	entered into a gender specific matrix 	*/

import delimited ht_zscore_inf.txt, delimiter(space) clear
save temp,replace

import delimited ht_zscore.txt, delimiter(space) clear
append using temp
sort sex agemon
drop if agemon==agemon[_n-1]
replace agemon=round(agemon,1)
 
foreach s of numlist 1 2 {
  mkmat agemon l m s if sex==`s' ,mat(lms_`s')
  }
matrix list lms_1
matrix list lms_2

* The following creates matrices with regression parametres
import delimited quantreg_coef.txt, delimiter(space) clear 
format quantile %7.2f
sort quantile

foreach t in "dia" "sys" {
  local s=0
  foreach sex in "M" "F" {
    local s=`s'+1
    mkmat quantile intercept-w4s if type=="`t'"&sex=="`sex'",mat(p`t'_`s')
  }
}

/*
 	THIS IS WHERE YOU IMPORT YOUR OWN DATA    
	
		if .dta-format - use the command "use" (say NO to save changes)
		if any other format - use the command "import" (say NO to save changes)               */

gen l=lms_1[agemon+2,2] if sex==1 
gen m=lms_1[agemon+2,3] if sex==1 
gen s=lms_1[agemon+2,4] if sex==1 
replace l=lms_2[agemon+2,2] if sex==2 
replace m=lms_2[agemon+2,3] if sex==2 
replace s=lms_2[agemon+2,4] if sex==2 

gen zscore_ht=(((height/m)^l)-1)/(l*s)
gen probzht=normal(zscore_ht)
gen htlc =m*(-3.09*l*s+1)^(1/l)
gen htuc =m*(3.09*l*s+1)^(1/l)

gen outlier=(height<htlc|height>htuc)

gen x=height
gen y=age
gen w=(age-10)*(height-150) if sex==1
replace w=(age-10)*(height-147) if sex==2

foreach x in x2a x2b x2c x3a x4a y2a y2b y2c y3a y4a w2a w2b w2c w3a w4a x2 x3 x4 y2 y3 y4 w2 w3 w4 {
  gen `x'=.
}

foreach s of numlist 1 2 {
  replace x2a=max(x-t_`s'[1,1],0) if sex==`s'
  replace x2b=max(x-t_`s'[1,4],0) if sex==`s'
  replace x2c=max(x-t_`s'[1,5],0) if sex==`s'
  replace x3a=max(x-t_`s'[1,2],0) if sex==`s'
  replace x4a=max(x-t_`s'[1,3],0) if sex==`s'

  replace y2a=max(y-t_`s'[2,1],0) if sex==`s'
  replace y2b=max(y-t_`s'[2,4],0) if sex==`s'
  replace y2c=max(y-t_`s'[2,5],0) if sex==`s'
  replace y3a=max(y-t_`s'[2,2],0) if sex==`s'
  replace y4a=max(y-t_`s'[2,3],0) if sex==`s'

  replace w2a=max(w-t_`s'[3,1],0) if sex==`s'
  replace w2b=max(w-t_`s'[3,4],0) if sex==`s'
  replace w2c=max(w-t_`s'[3,5],0) if sex==`s' 
  replace w3a=max(w-t_`s'[3,2],0) if sex==`s'
  replace w4a=max(w-t_`s'[3,3],0) if sex==`s'

  replace x2=x2a^3-x2b^3*(t_`s'[1,5]-t_`s'[1,1])/(t_`s'[1,5]-t_`s'[1,4])+x2c^3*(t_`s'[1,4]-t_`s'[1,1])/(t_`s'[1,5]-t_`s'[1,4]) if sex==`s'
  replace x3=x3a^3-x2b^3*(t_`s'[1,5]-t_`s'[1,2])/(t_`s'[1,5]-t_`s'[1,4])+x2c^3*(t_`s'[1,4]-t_`s'[1,2])/(t_`s'[1,5]-t_`s'[1,4]) if sex==`s'
  replace x4=x4a^3-x2b^3*(t_`s'[1,5]-t_`s'[1,3])/(t_`s'[1,5]-t_`s'[1,4])+x2c^3*(t_`s'[1,4]-t_`s'[1,3])/(t_`s'[1,5]-t_`s'[1,4]) if sex==`s'

  replace y2=y2a^3-y2b^3*(t_`s'[2,5]-t_`s'[2,1])/(t_`s'[2,5]-t_`s'[2,4])+y2c^3*(t_`s'[2,4]-t_`s'[2,1])/(t_`s'[2,5]-t_`s'[2,4]) if sex==`s'
  replace y3=y3a^3-y2b^3*(t_`s'[2,5]-t_`s'[2,2])/(t_`s'[2,5]-t_`s'[2,4])+y2c^3*(t_`s'[2,4]-t_`s'[2,2])/(t_`s'[2,5]-t_`s'[2,4]) if sex==`s'
  replace y4=y4a^3-y2b^3*(t_`s'[2,5]-t_`s'[2,3])/(t_`s'[2,5]-t_`s'[2,4])+y2c^3*(t_`s'[2,4]-t_`s'[2,3])/(t_`s'[2,5]-t_`s'[2,4]) if sex==`s'

  replace w2=w2a^3-w2b^3*(t_`s'[3,5]-t_`s'[3,1])/(t_`s'[3,5]-t_`s'[3,4])+w2c^3*(t_`s'[3,4]-t_`s'[3,1])/(t_`s'[3,5]-t_`s'[3,4]) if sex==`s'
  replace w3=w3a^3-w2b^3*(t_`s'[3,5]-t_`s'[3,2])/(t_`s'[3,5]-t_`s'[3,4])+w2c^3*(t_`s'[3,4]-t_`s'[3,2])/(t_`s'[3,5]-t_`s'[3,4]) if sex==`s'
  replace w4=w4a^3-w2b^3*(t_`s'[3,5]-t_`s'[3,3])/(t_`s'[3,5]-t_`s'[3,4])+w2c^3*(t_`s'[3,4]-t_`s'[3,3])/(t_`s'[3,5]-t_`s'[3,4]) if sex==`s'
}
    
gen	x2s=x2/100
gen x3s=x3/100
gen x4s=x4/100
 
gen y2s=y2/100
gen y3s=y3/100
gen y4s=y4/100
	
gen w2s=w2/100^2
gen w3s=w3/100^2
gen w4s=w4/100^2

foreach s of numlist 1/2 {
  foreach p of numlist 1/99 {
  if `s'==1 capture {
    gen fxsys_`p'=.
	gen fxdia_`p'=.
  }

  #delimit ;
  replace fxsys_`p'= psys_`s'[`p',2]
     + psys_`s'[`p',3]*y+psys_`s'[`p',4]*y2s+psys_`s'[`p',5]*y3s+psys_`s'[`p',6]*y4s 
     + psys_`s'[`p',7]*x+psys_`s'[`p',8]*x2s+psys_`s'[`p',9]*x3s+psys_`s'[`p',10]*x4s 
     + psys_`s'[`p',11]*w+psys_`s'[`p',12]*w2s+psys_`s'[`p',13]*w3s+psys_`s'[`p',14]*w4s
	 if sex==`s' ;

  replace fxdia_`p'= pdia_`s'[`p',2]
     + pdia_`s'[`p',3]*y+pdia_`s'[`p',4]*y2s+pdia_`s'[`p',5]*y3s+pdia_`s'[`p',6]*y4s 
     + pdia_`s'[`p',7]*x+pdia_`s'[`p',8]*x2s+pdia_`s'[`p',9]*x3s+pdia_`s'[`p',10]*x4s 
     + pdia_`s'[`p',11]*w+pdia_`s'[`p',12]*w2s+pdia_`s'[`p',13]*w3s+pdia_`s'[`p',14]*w4s
	 if sex==`s' ;
  #delimit cr	 
  }
}  

order fxsys* fxdia* ,after(w4s)
foreach p of numlist 1/99 {
  gen difsys_`p'=abs(sysbp-fxsys_`p')
  gen difdia_`p'=abs(diabp-fxdia_`p')
  }

order difsys* difdia* , after(fxdia_99)
egen psys=rowmin(difsys_1-difsys_99)
egen pdia=rowmin(difdia_1-difdia_99)

gen sys_per= .
gen dia_per= .

foreach p of numlist 1/99 {
  replace sys_per=`p' if psys==difsys_`p'
  replace dia_per=`p' if pdia==difdia_`p'
  }

replace sys_per= . if sysbp== .  
replace sys_per = . if outlier == 1
replace dia_per= . if diabp== .
replace dia_per = . if outlier == 1

* keep the relevant variables - add more as needed or wanted
keep id sex age height sysbp diabp sys_per dia_per outlier 

* name resulting dataset as wanted ("results" is chosen here)
save results, replace


