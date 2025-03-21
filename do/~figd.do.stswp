/* figd.do 
Sampa
2025 March 21
*** FIGURE E USS CT Correlation


A, pancreatic head transverse diameter (Spearman's ρ=0.22; P<0.001); B, pancreatic head antero-posterior (AP) diameter (Spearman's ρ=0.25; P<0.001); C, pancreatic body transverse diameter (Spearman's ρ=0.31; P<0.001); D, pancreatic tail transverse diameter (Spearman's ρ=0.10; P=0.10). All measurements are shown in cm.  Where correlations are statistically significant (panels A-C) a linear regression line is shown with 95% confidence limits. In panel A one CT measurement of 5.9cm is not shown for clarity.


https://github.com/asjadnaqvi/stata-schemepack/blob/main/README.md
*/

/* Scheme stsj v1 */
set scheme stsj

* Head AP
spearman pan_head_ap ct_pan_head_ap if ct_pan_head_ap <= 4
local rho = string(r(rho), "%4.2f")
local p = string(r(p), "%4.3f")

twoway (scatter pan_head_ap ct_pan_head_ap if ct_pan_head_ap <= 4, msize(tiny)) ///
       (lfitci pan_head_ap ct_pan_head_ap if ct_pan_head_ap <= 4), ///
       ytitle("") xtitle("") title("Head, AP") ///
       ylabel(0(1)4) xlabel(0(1)4) yscale(range(0 4)) ///
       text(2.5 0.5 "ρ = `rho'" "p = `p'", size(vsmall) just(left)) ///
       legend(off) name(g1, replace)

* Head Transverse
spearman pan_head_trans ct_pan_head_trans if ct_pan_head_trans <= 4
local rho = string(r(rho), "%4.2f")
local p = string(r(p), "%4.3f")

twoway (scatter pan_head_trans ct_pan_head_trans if ct_pan_head_trans <= 4, msize(tiny)) ///
       (lfitci pan_head_trans ct_pan_head_trans if ct_pan_head_trans <= 4), ///
       ytitle("") xtitle("") title("Head, Transverse") ///
       ylabel(0(1)4) xlabel(0(1)4) yscale(range(0 4)) ///
       text(2.5 0.5 "ρ = `rho'" "p = `p'", size(vsmall) just(left)) ///
       legend(off) name(g2, replace)

* Body Transverse
spearman pan_body_trans ct_pan_body_trans if ct_pan_body_trans <= 4
local rho = string(r(rho), "%4.2f")
local p = string(r(p), "%4.3f")

twoway (scatter pan_body_trans ct_pan_body_trans if ct_pan_body_trans <= 4, msize(tiny)) ///
       (lfitci pan_body_trans ct_pan_body_trans if ct_pan_body_trans <= 4), ///
       ytitle("") xtitle("") title("Body, Transverse") ///
       ylabel(0(1)4) xlabel(0(1)4) yscale(range(0 4)) ///
       text(2.5 0.5 "ρ = `rho'" "p = `p'", size(vsmall) just(left)) ///
       legend(off) name(g3, replace)

* Tail Transverse
spearman pan_tail_trans ct_pan_tail_trans if ct_pan_tail_trans <= 4
local rho = string(r(rho), "%4.2f")
local p = string(r(p), "%4.3f")

twoway (scatter pan_tail_trans ct_pan_tail_trans if ct_pan_tail_trans <= 4, msize(tiny)) ///
       (lfitci pan_tail_trans ct_pan_tail_trans if ct_pan_tail_trans <= 4), ///
       ytitle("") xtitle("") title("Tail, Transverse") ///
       ylabel(0(1)4) xlabel(0(1)4) yscale(range(0 4)) ///
       text(2.5 0.5 "ρ = `rho'" "p = `p'", size(vsmall) just(left)) ///
       legend(off) name(g4, replace)

gr combine g1 g2 g3 g4, ///
    rows(2) cols(2) ///
    ycommon xcommon ///
    l1title("Ultrasound (cm)") ///
    b1title("CT Scan (cm)")

gr save "./figures/fige", replace
gr export "./figures/fige.png", as(png) width(2400) replace



