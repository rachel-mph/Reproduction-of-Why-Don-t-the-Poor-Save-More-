********************************************************************************
** 	TITLE	: HARP_reproduction_robust.do
**	PURPOSE	: This .do file provides additional robustness checks for 
**			  "Why don't the poor save more?"
**	AUTHOR	: Rachel Pizatella-Haswell
**	DATE	: 04/14/2023
********************************************************************************

*-------------*
* RRELIMS	  * 
*-------------*

#delimit;
set more off;
clear;
set mem 150m;

*-------------*
* heterogeneity for preventative health	  * 
*-------------*
*------------------------------------------------------------------------------*

#delimit;

use HARP_ROSCA_final, clear;
pause on;
gen bg_female_married=bg_female*bg_married;
gen bg_child = 1 if bg_children > 0;
replace bg_child = 0 if bg_children == 0; 

global individual_controls "bg_b1_age bg_female bg_female_married bg_provider bg_hyperbolic  bg_pat_now_impat_later bg_max_discount bg_n_roscas";

for var safe_box locked_box health_pot health_savings multitreat:
 gen X_child=bg_child*X \
 gen X_gender=bg_female*X \

 *Column 1;
xi: reg fol2_amtinvest_healthproducts 
 safe_box safe_box_child safe_box_gender
 locked_box locked_box_child locked_box_gender
 health_pot health_pot_child health_pot_gender
 health_savings health_savings_child health_savings_gender
 multitreat multitreat_child multitreat_gender
 rosbg_monthly_contrib i.strata, cluster(id_harp_rosca);

*/;

*------------------------------------------------------------------------------*

*-------------*
* heterogeneity for preventative health	  * 
*-------------*
*------------------------------------------------------------------------------*

#delimit;

use HARP_ROSCA_final, clear;
pause on;
gen bg_female_married=bg_female*bg_married;
gen bg_child = 1 if bg_children > 0;
replace bg_child = 0 if bg_children == 0; 

global individual_controls "bg_b1_age bg_female bg_female_married bg_provider bg_hyperbolic  bg_pat_now_impat_later bg_max_discount bg_n_roscas";

for var safe_box locked_box health_pot health_savings multitreat:
 gen X_child=bg_child*X \
 gen X_gender=bg_female*X \

 *Column 1;
xi: reg fol2_illness_untreated_3mo 
 safe_box safe_box_child safe_box_gender
 locked_box locked_box_child locked_box_gender
 health_pot health_pot_child health_pot_gender
 health_savings health_savings_child health_savings_gender
 multitreat multitreat_child multitreat_gender
 rosbg_monthly_contrib i.strata, cluster(id_harp_rosca);

*/;

*------------------------------------------------------------------------------*

