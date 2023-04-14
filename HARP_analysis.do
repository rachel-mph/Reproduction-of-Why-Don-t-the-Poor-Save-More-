*             Reproduction: DO-FILE TO GENERATE TABLES IN PAPER:
**********************************************************************************
*       "WHY DON'T THE POOR SAVE MORE? EVIDENCE FROM HEALTH SAVINGS EXPERIMENTS"
**********************************************************************************
*                by PASCALINE DUPAS AND JONATHAN ROBINSON
* 			AMERICAN ECONOMIC REVIEW



#delimit;
set more off;
clear;
set mem 150m;


************************************;
************************************;
***** MAIN TABLES   ****************;
************************************;
************************************;


*******************************;
*******Table 1: Baseline stats by treatment groups - individual level;
********************************;
#delim;
use HARP_ROSCA_final, clear;

drop if has_followup2!=1;

pause on;
for any 
 bg_female 
 bg_b1_age
 bg_married 
 bg_children  
 bg_own_education
 bg_b6_write_kiswahili
 bg_cementfloor 
 bg_provider
 bg_weekly_income
 bg_childunder5_pr_malaria  
 bg_resp_malaria
 bg_chlorine 
 bg_c17_bednets_number
 bg_somewhat_patient 
 bg_hyperbolic
 bg_pat_now_impat_later 
 bg_max_discount
 bg_invest_choice_risky_asset
 bg_n_roscas 
 bg_part_ROSCA_cant_save_alone
 bg_part_ROSCA_socialize:
 sum X \
 reg X safe_box locked_box health_pot health_savings multitreat , cluster(id_harp_rosca) \
 test safe_box=locked_box=health_pot=health_savings=0 \ 
 pause;


*/;


*******************************;
*******Table 2: Sum Stats on Take-up of various programs;
********************************;
#delimit;
use HARP_ROSCA_final, clear;

pause on;

*Follow-up 1, Safe Box (Col 1);
for any uses_safe_box sb_amt_in_box sb_helped_save_more sb_has_box sb_spouse_knows_box :
 sum fol1_X, d \
 pause;

*Follow-up 1, Lock Box (Col 2);
for any uses_lbox l_amt_in_box l_helped_save_more l_has_box l_spouse_knows_box l_called_fo l_refusekey :
 sum fol1_X, d \
 pause;

*Follow-up 1, Health pot (Col 3);
for any hp_pot_contribute hp_helped_save_more hp_received_pot hp_prod_in_kind:
 sum fol1_X, d \
 pause;

*Follow-up 1, HSA (Col 4);
for any hsa_deposit_hsa hsacc_balance hsa_helped_save_more hsacc_num_deposits hsacc_deposit_amount hsa_made_wd hsacc_mean_withdrawal
 hsa_wd_emergency  hsa_wd_funeral hsa_wd_prev_health: 
 sum fol1_X, d \
 pause;

*Follow-up 2, Safe Box (Col 5);
for any uses_safe_box sb_amt_in_box sb_helped_save_more sb_has_box sb_spouse_knows_box :
 sum fol2_X, d \
 pause;

*Follow-up 2, Lock Box (Col 6);
for any uses_lbox l_amt_in_box l_helped_save_more l_has_box l_spouse_knows_box l_called_fo:
 sum fol2_X, d \
 pause;

*Follow-up 2, Health pot (Col 7);
for any hp_pot_contribute hp_helped_save_more hp_received_pot hp_prod_in_kind hp_prod_accompany hp_prod_encourage :
 sum fol2_X, d \
 pause;

*Follow-up 2, HSA (Col 8);
for any hsa_deposit_hsa hsacc_balance hsa_helped_save_more hsacc_num_deposits hsacc_deposit_amount hsa_made_wd hsacc_mean_withdrawal
 hsa_wd_emergency  hsa_wd_funeral hsa_wd_prev_health: 
 sum fol2_X, d \
 pause;
*/;


**************************************;
*******Table 3: impacts on investment, risk-coping;
**************************************;

#delimit;

use HARP_ROSCA_final, clear;

gen bg_female_married=bg_female*bg_married; // marital status 

global individual_controls "bg_b1_age bg_female bg_female_married bg_hyperbolic  bg_pat_now_impat_later bg_max_discount multitreat"; // create individual controls 


*Column 1;
xi: reg fol2_amtinvest_healthproducts safe_box locked_box health_pot health_savings i.strata, cluster(id_harp_rosca); // treatment effects 
testparm safe_box locked_box health_pot  health_savings; // effects of features 
lincom safe_box; // P1 
lincom locked_box-safe_box; // P2 - P1
lincom health_pot-locked_box; // P3 - P2
sum fol2_amtinvest_healthproducts if e(sample) & encouragement==1;

*Column 2;
xi: reg fol2_amtinvest_healthproducts safe_box locked_box health_pot  health_savings i.strata $individual_controls, cluster(id_harp_rosca); // treatment effects with controls 
testparm safe_box locked_box health_pot  health_savings;
lincom safe_box;
lincom locked_box-safe_box;
lincom health_pot-locked_box;
sum fol2_amtinvest_healthproducts if e(sample) & encouragement==1;


*Column 3;
xi: reg fol2_illness_untreated_3mo safe_box locked_box health_pot  health_savings i.strata, cluster(id_harp_rosca);
testparm safe_box locked_box health_pot  health_savings;
lincom safe_box;
lincom health_savings-safe_box; // P4 - P1 
sum fol2_illness_untreated_3mo if e(sample) & encouragement==1;

*Column 4;
xi: reg fol2_illness_untreated_3mo safe_box locked_box health_pot  health_savings i.strata $individual_controls, cluster(id_harp_rosca);
testparm safe_box locked_box health_pot  health_savings;
lincom safe_box;
lincom health_savings-safe_box;
sum fol2_illness_untreated_3mo if e(sample) & encouragement==1;

*Column 5;
xi: reg fol2_reached_goal safe_box locked_box health_pot  health_savings i.strata, cluster(id_harp_rosca);
testparm safe_box locked_box health_pot  health_savings;
lincom safe_box;
lincom locked_box-safe_box;
lincom health_pot-locked_box;
lincom health_savings-safe_box;
sum fol2_reached_goal if e(sample) & encouragement==1;

*Column 6;
xi: reg fol2_reached_goal safe_box locked_box health_pot  health_savings i.strata $individual_controls, cluster(id_harp_rosca);
testparm safe_box locked_box health_pot  health_savings;
lincom safe_box;
lincom locked_box-safe_box;
lincom health_pot-locked_box;
lincom health_savings-safe_box;
sum fol2_reached_goal if e(sample) & encouragement==1;
*/;


**************************************;
*******Table 4: heterogeneity for preventative health;
**************************************;
#delimit;

use HARP_ROSCA_final, clear;
pause on;
gen bg_female_married=bg_female*bg_married;

global individual_controls "bg_b1_age bg_female bg_female_married bg_provider bg_hyperbolic  bg_pat_now_impat_later bg_max_discount bg_n_roscas";

for var safe_box locked_box health_pot health_savings multitreat:
 gen X_prov=bg_provider*X \
 gen X_pb=bg_hyperbolic*X \
 gen X_fmarry=bg_married*X if bg_female==1;

*Column 1;
xi: reg fol2_amtinvest_healthproducts 
 safe_box safe_box_prov safe_box_pb
 locked_box locked_box_prov locked_box_pb
 health_pot health_pot_prov health_pot_pb 
 health_savings health_savings_prov health_savings_pb
 multitreat multitreat_prov multitreat_pb
 rosbg_monthly_contrib i.strata, cluster(id_harp_rosca);
lincom safe_box+safe_box_prov;
lincom safe_box+safe_box_pb;
lincom locked_box+locked_box_prov;
lincom locked_box+locked_box_pb;
lincom health_pot+health_pot_prov;
lincom health_pot+health_pot_pb;
sum bg_provider if e(sample);
sum bg_hyperbolic if e(sample);
sum fol2_amtinvest_healthproducts if encouragement==1 & e(sample);

*Column 3;
xi: reg fol2_amtinvest_healthproducts 
 safe_box safe_box_prov safe_box_pb
 locked_box locked_box_prov locked_box_pb
 health_pot health_pot_prov health_pot_pb 
 health_savings health_savings_prov health_savings_pb
 multitreat multitreat_prov multitreat_pb
 rosbg_monthly_contrib i.strata $individual_controls, cluster(id_harp_rosca);
lincom safe_box+safe_box_prov;
lincom safe_box+safe_box_pb;
lincom locked_box+locked_box_prov;
lincom locked_box+locked_box_pb;
lincom health_pot+health_pot_prov;
lincom health_pot+health_pot_pb;
sum bg_provider if e(sample);
sum bg_hyperbolic if e(sample);
sum fol2_amtinvest_healthproducts if encouragement==1 & e(sample);


*Column 5;
xi: reg fol2_amtinvest_healthproducts 
 safe_box safe_box_prov safe_box_pb safe_box_fmarry
 locked_box locked_box_prov locked_box_pb locked_box_fmarry
 health_pot health_pot_prov health_pot_pb health_pot_fmarry
 health_savings health_savings_prov health_savings_pb health_savings_fmarry
 multitreat multitreat_prov multitreat_pb multitreat_fmarry
 rosbg_monthly_contrib i.strata  if bg_female==1, cluster(id_harp_rosca);
lincom safe_box+safe_box_prov;
lincom safe_box+safe_box_pb;
lincom safe_box+safe_box_fmarry;
lincom locked_box+locked_box_prov;
lincom locked_box+locked_box_pb;
lincom locked_box+locked_box_fmarry;
lincom health_pot+health_pot_prov;
lincom health_pot+health_pot_pb;
lincom health_pot+health_pot_fmarry;
sum bg_provider if e(sample);
sum bg_hyperbolic if e(sample);
sum fol2_amtinvest_healthproducts if encouragement==1 & e(sample);

*Column 7;
xi: reg fol2_amtinvest_healthproducts 
 safe_box safe_box_prov safe_box_pb safe_box_fmarry
 locked_box locked_box_prov locked_box_pb locked_box_fmarry
 health_pot health_pot_prov health_pot_pb health_pot_fmarry
 health_savings health_savings_prov health_savings_pb health_savings_fmarry
 multitreat multitreat_prov multitreat_pb multitreat_fmarry
 rosbg_monthly_contrib i.strata $individual_controls if bg_female==1, cluster(id_harp_rosca);
lincom safe_box+safe_box_prov;
lincom safe_box+safe_box_pb;
lincom safe_box+safe_box_fmarry;
lincom locked_box+locked_box_prov;
lincom locked_box+locked_box_pb;
lincom locked_box+locked_box_fmarry;
lincom health_pot+health_pot_prov;
lincom health_pot+health_pot_pb;
lincom health_pot+health_pot_fmarry;
sum bg_provider if e(sample);
sum bg_hyperbolic if e(sample);
sum fol2_amtinvest_healthproducts if encouragement==1 & e(sample);

*/;


**************************************;
*******Table 5: heterogeneity for emergencies;
**************************************;
#delimit;

use HARP_ROSCA_final, clear;
pause on;
gen bg_female_married=bg_female*bg_married;

global individual_controls "bg_b1_age bg_female bg_female_married bg_provider bg_hyperbolic  bg_pat_now_impat_later bg_max_discount bg_n_roscas";

for var safe_box locked_box health_pot health_savings multitreat:
 gen X_prov=bg_provider*X \
 gen X_pb=bg_hyperbolic*X \
 gen X_fmarry=bg_married*X if bg_female==1;

*Column 1;
xi: reg fol2_illness_untreated_3mo
 safe_box safe_box_prov safe_box_pb
 locked_box locked_box_prov locked_box_pb
 health_pot health_pot_prov health_pot_pb 
 health_savings health_savings_prov health_savings_pb
 multitreat multitreat_prov multitreat_pb
 rosbg_monthly_contrib i.strata, cluster(id_harp_rosca);
lincom safe_box+safe_box_prov;
lincom safe_box+safe_box_pb;
lincom health_savings+health_savings_prov;
lincom health_savings+health_savings_pb;
sum bg_provider if e(sample);
sum bg_hyperbolic if e(sample);
sum fol2_illness_untreated_3mo if encouragement==1 & e(sample);


*Column 2;
xi: reg fol2_illness_untreated_3mo
 safe_box safe_box_prov safe_box_pb
 locked_box locked_box_prov locked_box_pb
 health_pot health_pot_prov health_pot_pb 
 health_savings health_savings_prov health_savings_pb
 multitreat multitreat_prov multitreat_pb
 rosbg_monthly_contrib i.strata $individual_controls, cluster(id_harp_rosca);
lincom safe_box+safe_box_prov;
lincom safe_box+safe_box_pb;
lincom health_savings+health_savings_prov;
lincom health_savings+health_savings_pb;
sum bg_provider if e(sample);
sum bg_hyperbolic if e(sample);
sum fol2_illness_untreated_3mo if encouragement==1 & e(sample);

pause;

*Column 3;
xi: reg fol2_illness_untreated_3mo
 safe_box safe_box_prov safe_box_pb safe_box_fmarry
 locked_box locked_box_prov locked_box_pb locked_box_fmarry
 health_pot health_pot_prov health_pot_pb health_pot_fmarry
 health_savings health_savings_prov health_savings_pb health_savings_fmarry
 multitreat multitreat_prov multitreat_pb multitreat_fmarry
 rosbg_monthly_contrib i.strata  if bg_female==1, cluster(id_harp_rosca);
lincom safe_box+safe_box_prov;
lincom safe_box+safe_box_pb;
lincom safe_box+safe_box_fmarry;
lincom health_savings+health_savings_prov;
lincom health_savings+health_savings_pb;
lincom health_savings+health_savings_fmarry;
sum bg_provider if e(sample);
sum bg_hyperbolic if e(sample);
sum fol2_illness_untreated_3mo if encouragement==1 & e(sample);

*Column 4;
xi: reg fol2_illness_untreated_3mo 
 safe_box safe_box_prov safe_box_pb safe_box_fmarry
 locked_box locked_box_prov locked_box_pb locked_box_fmarry
 health_pot health_pot_prov health_pot_pb health_pot_fmarry
 health_savings health_savings_prov health_savings_pb health_savings_fmarry
 multitreat multitreat_prov multitreat_pb multitreat_fmarry
 rosbg_monthly_contrib i.strata $individual_controls if bg_female==1, cluster(id_harp_rosca);
lincom safe_box+safe_box_prov;
lincom safe_box+safe_box_pb;
lincom safe_box+safe_box_fmarry;
lincom health_savings+health_savings_prov;
lincom health_savings+health_savings_pb;
lincom health_savings+health_savings_fmarry;
sum bg_provider if e(sample);
sum bg_hyperbolic if e(sample);
sum fol2_illness_untreated_3mo if encouragement==1 & e(sample);

*/;

*******************************;
*******Table 6: Long-term followup;
********************************;
#delimit;

use HARP_ROSCA_final, clear;

*************************;
*for follow up 3, pool the 2 boxes;
*************************;
 for any goal_emergency goal_business goal_school_fees goal_bednet goal_latrine goal_filter goal_other_health goal_wedding goal_other goal_animal goal_farm goal_hh_expense goal_construct:
  gen fol2_box_X=fol2_sb_X if fol2_sb_X!=. \
  replace fol2_box_X=fol2_l_X if fol2_l_X!=. \
  gen fol3_box_X=fol3_sb_X if fol3_sb_X!=. \
  replace fol3_box_X=fol3_l_X if fol3_l_X!=. \
  gen fol1_box_X=.;
	
gen fol3_uses_box=1 if fol3_uses_lbox==1 | fol3_uses_safe_box==1;
replace fol3_uses_box=0 if fol3_uses_lbox==0 & fol3_uses_safe_box!=1;
replace fol3_uses_box=0 if fol3_uses_safe_box==0 & fol3_uses_lbox!=1;

for any 
 amt_in_box helped_save_more has_box spouse_knows_box 
 total_deposit total_deposit_lot total_deposit_little
 total_withdraw total_withdraw_lot total_withdraw_little:
 gen fol3_box_X=fol3_l_X \
 replace fol3_box_X=fol3_sb_X if fol3_box_X==. ;
		
gen fol3_box_goal=fol3_l_goal;
replace fol3_box_goal=fol3_sb_goal if fol3_box_goal==.;
gen fol3_box_healthgoal=0 if fol3_box_goal!=.;
replace fol3_box_healthgoal=1 if fol3_box_goal_emergency==1 | fol3_box_goal_bednet==1 | fol3_box_goal_latrine==1 | fol3_box_goal_filter==1 | fol3_box_goal_other_health==1;

gen fol3_box_numeric_dep=1 if fol3_box_total_deposit!=.;
replace fol3_box_numeric_dep=0 if fol3_box_total_deposit_lot!=.;

gen fol3_box_numeric_wd=1 if fol3_box_total_withdraw!=.;
replace fol3_box_numeric_wd=0 if fol3_box_total_withdraw_lot!=.;

replace fol3_box_total_deposit_lot=0 if fol3_box_total_deposit!=. ;
replace fol3_box_total_deposit_little=0 if fol3_box_total_deposit!=. ;

replace fol3_box_total_withdraw_lot=0 if fol3_box_total_withdraw!=. ;
replace fol3_box_total_withdraw_little=0 if fol3_box_total_withdraw!=. ;


pause on;
*Table 6, Column 1;
for any fol3_uses_box fol3_box_amt_in_box fol3_box_helped_save_more fol3_box_has_box fol3_box_spouse  fol3_box_goal fol3_box_healthgoal
 fol3_box_numeric_dep fol3_box_total_deposit fol3_box_total_deposit_lot 
 fol3_box_numeric_wd fol3_box_total_withdraw fol3_box_total_withdraw_lot:
 sum X, detail \
 *pause;

*Table 6, Column 2;
for any fol3_hp_started_new_pot fol3_hp_helped_save_more fol3_hp_pot_contribute   fol3_hp_received_pot fol3_hp_prod_in_kind:
 sum X, detail \
 *pause;

*Table 6, Column 3;
for any fol3_hsa_deposit_hsa fol3_hsacc_balance fol3_hsa_helped_save_more  fol3_hsa_made_wd   fol3_hsacc_mean_withdrawal
 fol3_hsa_wd_emergency fol3_hsa_wd_funeral fol3_hsa_wd_prev_health  fol3_hsa_wd_other:
 sum X, detail \
 *pause;

*/;


*******************************;
*******Table 7: spillovers;
********************************;
#delimit;

use HARP_ROSCA_final, clear;
sort id_harp_rosca;

*ROSCA treatment indicator;
for any encouragement safe_box locked_box health_pot health_savings \ num 1/5:
 gen r_X=1 if strpos(group, "Y") \
 replace r_X=0 if strpos(group, "Y")==0;

sum r_encouragement r_safe_box r_locked_box r_health_pot r_health_savings if id_harp_rosca!=id_harp_rosca[_n-1] & fol3_rosca_hsa!=. & fol3_rosca_health_pot!=.;

sum fol3_rosca_health_pot fol3_rosca_hsa if r_encouragement==1 & id_harp_rosca!=id_harp_rosca[_n-1];
sum fol3_rosca_health_pot fol3_rosca_hsa if r_safe_box==1 & id_harp_rosca!=id_harp_rosca[_n-1];
sum fol3_rosca_health_pot fol3_rosca_hsa if r_locked_box==1 & id_harp_rosca!=id_harp_rosca[_n-1];
sum fol3_rosca_health_pot fol3_rosca_hsa if r_health_pot==1 & id_harp_rosca!=id_harp_rosca[_n-1];
sum fol3_rosca_health_pot fol3_rosca_hsa if r_health_savings==1 & id_harp_rosca!=id_harp_rosca[_n-1];
*/;


*******************************;
*******Table 8: semi-qualitative responses;
********************************;
#delimit;

use HARP_ROSCA_final, clear;
sort id_harp_rosca;

for any 
 why_help_invisible why_help_coins why_help_luxury  why_help_theft why_help_refuse_req why_help_encouraged_sav why_help_save_secret 
 easier_say_no_outHH easier_say_no_spouse
 why_ref_goal
 why_ref_othersDK
 why_ref_box_outside
 why_ref_box_hidden
 why_ref_box_mean
 why_ref_pretend_nokey
 why_ref_secret:
 gen fol3_b_X=fol3_sb_X \
 replace fol3_b_X=fol3_l_X if fol3_b_X==.;

*Panel A;
sum fol3_b_why_help_coins fol3_b_why_help_invisible  fol3_b_why_help_luxury fol3_b_why_help_encouraged_sav fol3_b_why_help_theft fol3_b_why_help_save_secret;

*Panel B;
sum fol1_everyone_obligated_cash;
sum fol1_sb_obligated_cash fol1_sb_obligated_box if fol1_sb_obligated_box!=. & fol1_sb_obligated_cash!=.;

sum fol3_b_easier_say_no_outHH fol3_b_easier_say_no_spouse;

sum fol3_b_why_ref_goal fol3_b_why_ref_othersDK
 fol3_b_why_ref_box_outside fol3_b_why_ref_secret fol3_b_why_ref_box_hidden 
 fol3_b_why_ref_pretend_nokey ;

*Panel C;
sum fol3_hsa_know_what_all_save fol3_hsa_know_what_some_save fol3_hsa_influenced_by_others;

*/;
*******************************;
*******Table 9: ROSCA survival;
********************************;
#delimit;

use HARP_ROSCA_final, clear;
sort id_harp_rosca;

*ROSCA treatment indicator;
for any encouragement safe_box locked_box health_pot health_savings \ num 1/5:
 gen r_X=1 if strpos(group, "Y") \
 replace r_X=0 if strpos(group, "Y")==0;

gen r_box=1 if r_safe_box==1 | r_locked_box==1;
replace r_box=0 if r_safe_box==0 & r_locked_box==0;

sum r_encouragement r_box r_health_pot r_health_savings if id_harp_rosca!=id_harp_rosca[_n-1] & fol3_rosca_hsa!=. & fol3_rosca_health_pot!=.;

*Column 1;
reg fol3_rosca_still_exists r_box r_health_pot r_health_savings if id_harp_rosca!=id_harp_rosca[_n-1];
sum fol3_rosca_still_exists if r_encouragement==1 & e(sample);

*Column 2;
xi: reg fol3_rosca_still_exists r_box r_health_pot r_health_savings rosbg_monthly_contrib i.strata if id_harp_rosca!=id_harp_rosca[_n-1];
sum fol3_rosca_still_exists if r_encouragement==1 & e(sample);

*Column 3;
dprobit fol3_rosca_still_exists r_box r_health_pot r_health_savings if id_harp_rosca!=id_harp_rosca[_n-1];
sum fol3_rosca_still_exists if r_encouragement==1 & e(sample);




***************************************;
******   APPENDIX TABLES **************;
****************************************;



************;
*Appendix Table A1;
************;
#delimit;
use ROSCA_masterlist.dta, clear;

for var rosbg_b2_participants rosbg_female_only rosbg_share_female meet_per_month rosbg_monthly_contrib rosbg_potsize 
 rosbg_e1_rosca_loans rosbg_f1_welfare_insurance predet_order script_regularmeeting morning_script \ num 1/11:
 global depvarY="X";

local i 1;
while `i' <= 11 {;

	sum ${depvar`i'} if encouragement==1;

	sum ${depvar`i'} if safe_box==1;

	sum ${depvar`i'} if locked_box==1;

	sum ${depvar`i'} if health_pot==1;

	sum ${depvar`i'} if health_savings==1;

	reg ${depvar`i'} encouragement safe_box locked_box health_pot health_savings, nocons;
	test encouragement=safe_box=locked_box=health_pot=health_savings;
	test encouragement=safe_box;
	test encouragement=locked_box;
	test encouragement=health_pot;
	test encouragement=health_savings;

	local i = `i' + 1;
	};




************;
*Appendix Table A2;
************;
#delimit;

use HARP_ROSCA_final, clear;
sort id_harp_rosca;

gen bg_female_married=bg_female*bg_married;

for any aquagard waterguard filter container net latrine gum_boots emergency other \ num 1/9:
 gen goal_X=1 if bg_p2_goal==Y \
 replace goal_X=0 if bg_p2_goal!=Y & bg_p2_goal!=. \
 global depvarY="X";

gen goal_chlorine=1 if goal_aqua==1 | goal_water==1;
replace goal_chlorine=0 if goal_aqua==0 & goal_water==0;

sum bg_p3_money_to_save, detail;
gen bg_p3_money_to_save_t1=bg_p3_money_to_save if bg_p3_money_to_save<r(p99);
replace bg_p4_months_reach_goal=. if bg_p4_months_reach_goal==99;

global individual_controls "bg_b1_age bg_female bg_female_married bg_provider bg_hyperbolic  bg_pat_now_impat_later bg_max_discount bg_n_roscas";

for var bg_p3_money_to_save_t1 bg_p4_months_reach_goal goal_chlorine  goal_filter goal_container goal_net goal_latrine goal_gum_boots goal_emergency \ num 1/9:
 global depvarY="X";

local i 1;
while `i' <= 9 {;

	xi: reg ${depvar`i'} safe_box locked_box health_pot health_savings multitreat ${individual_controls} rosbg_monthly_contrib i.strata, cluster(id_harp_rosca);
	sum ${depvar`i'} if e(sample) & encouragement==1;
	test safe_box =locked_box =health_pot =health_savings=0;
	local i = `i' + 1;
	};
*/;


************;
*Appendix Table A3;
************;
#delimit;

use HARP_ROSCA_final, clear;
sort id_harp_rosca;

gen bg_female_married=bg_female*bg_married;

global individual_controls "bg_b1_age bg_female bg_female_married bg_provider bg_hyperbolic  bg_pat_now_impat_later bg_max_discount bg_n_roscas";

for num 1/2: gen attritedX=1-has_followupX;

for var attrited1 attrited2 \ num 1/2:
 global depvarY="X";

local i 1;
while `i' <= 2 {;

	xi: reg ${depvar`i'} safe_box locked_box health_pot health_savings multitreat ${individual_controls} rosbg_monthly_contrib i.strata, cluster(id_harp_rosca);
	sum ${depvar`i'} if e(sample) & encouragement==1;
	test safe_box =locked_box =health_pot =health_savings=0;

	local i = `i' + 1;

	};

*/;


************;
*Appendix Table A4;
************;
#delimit;

use HARP_ROSCA_final, clear;
sort id_harp_rosca;

gen bg_female_married=bg_female*bg_married;

replace bg_weekly_income=bg_weekly_income/1000;

global individual_controls "bg_b1_age bg_female bg_female_married bg_provider bg_hyperbolic  bg_pat_now_impat_later bg_max_discount bg_n_roscas";

for var bg_weekly_income bg_children:
 gen X_m=1 if X==. \
 replace X_m=0 if X!=. \
 replace X=0 if X==.;

for var safe_box locked_box health_pot health_savings multitreat:
 gen X_prov=bg_provider*X \
 gen X_pb=bg_hyperbolic*X \
 gen X_fmarry=bg_married*X if bg_female==1 \
 gen X_inc=bg_weekly_income*X \
 gen X_kids=bg_children*X \
 gen X_inc_m=bg_weekly_income_m*X \
 gen X_kids_m=bg_children_m*X ;

*Columns 1&2;
xi: reg fol2_amtinvest_healthproducts 
 safe_box safe_box_prov safe_box_pb
 locked_box locked_box_prov locked_box_pb
 health_pot health_pot_prov health_pot_pb 
 health_savings health_savings_prov health_savings_pb
 multitreat multitreat_prov multitreat_pb
 safe_box_inc locked_box_inc health_pot_inc health_savings_inc multitreat_inc
 safe_box_kids locked_box_kids health_pot_kids health_savings_kids multitreat_kids
 safe_box_inc_m locked_box_inc_m health_pot_inc_m health_savings_inc_m multitreat_inc_m
 safe_box_kids_m locked_box_kids_m health_pot_kids_m health_savings_kids_m multitreat_kids_m
 bg_weekly_income bg_children
 bg_weekly_income_m  bg_children_m
 rosbg_monthly_contrib i.strata ${individual_controls}, cluster(id_harp_rosca);

lincom safe_box+safe_box_prov;
test safe_box+safe_box_prov=0;

lincom safe_box+safe_box_pb;
test safe_box+safe_box_pb=0;

lincom locked_box+locked_box_prov;
test locked_box+locked_box_prov=0;

lincom locked_box+locked_box_pb;
test locked_box+locked_box_pb=0;

lincom health_pot+health_pot_prov;
test health_pot+health_pot_prov=0;

lincom health_pot+health_pot_pb;
test health_pot+health_pot_pb=0;


*Columns 3&4;
xi: reg fol2_amtinvest_healthproducts 
 safe_box safe_box_prov safe_box_pb safe_box_fmarry
 locked_box locked_box_prov locked_box_pb locked_box_fmarry
 health_pot health_pot_prov health_pot_pb  health_pot_fmarry
 health_savings health_savings_prov health_savings_pb health_savings_fmarry
 multitreat multitreat_prov multitreat_pb multitreat_fmarry
 safe_box_inc locked_box_inc health_pot_inc health_savings_inc multitreat_inc
 safe_box_kids locked_box_kids health_pot_kids health_savings_kids multitreat_kids
 safe_box_inc_m locked_box_inc_m health_pot_inc_m health_savings_inc_m multitreat_inc_m
 safe_box_kids_m locked_box_kids_m health_pot_kids_m health_savings_kids_m multitreat_kids_m
 bg_weekly_income bg_children
 bg_weekly_income_m  bg_children_m
 rosbg_monthly_contrib i.strata ${individual_controls} if bg_female==1, cluster(id_harp_rosca);

lincom safe_box+safe_box_prov;
test safe_box+safe_box_prov=0;

lincom safe_box+safe_box_pb;
test safe_box+safe_box_pb=0;

lincom safe_box+safe_box_fmarry;
test safe_box+safe_box_fmarry=0;

lincom locked_box+locked_box_prov;
test locked_box+locked_box_prov=0;

lincom locked_box+locked_box_pb;
test locked_box+locked_box_pb=0;

lincom locked_box+locked_box_fmarry;
test locked_box+locked_box_fmarry=0;

lincom health_pot+health_pot_prov;
test health_pot+health_pot_prov=0;

lincom health_pot+health_pot_pb;
test health_pot+health_pot_pb=0;

lincom health_pot+health_pot_fmarry;
test health_pot+health_pot_fmarry=0;

*/;


************;
*Appendix Table A5;
************;
#delimit;

use HARP_ROSCA_final, clear;
sort id_harp_rosca;

gen bg_female_married=bg_female*bg_married;

replace bg_weekly_income=bg_weekly_income/1000;

global individual_controls "bg_b1_age bg_female bg_female_married bg_provider bg_hyperbolic  bg_pat_now_impat_later bg_max_discount bg_n_roscas";

for var bg_weekly_income bg_children:
 gen X_m=1 if X==. \
 replace X_m=0 if X!=. \
 replace X=0 if X==.;

for var safe_box locked_box health_pot health_savings multitreat:
 gen X_prov=bg_provider*X \
 gen X_pb=bg_hyperbolic*X \
 gen X_fmarry=bg_married*X if bg_female==1 \
 gen X_inc=bg_weekly_income*X \
 gen X_kids=bg_children*X \
 gen X_inc_m=bg_weekly_income_m*X \
 gen X_kids_m=bg_children_m*X ;

*Columns 1&2;
xi: reg fol2_illness_untreated_3mo
 safe_box safe_box_prov safe_box_pb
 locked_box locked_box_prov locked_box_pb
 health_pot health_pot_prov health_pot_pb 
 health_savings health_savings_prov health_savings_pb
 multitreat multitreat_prov multitreat_pb
 safe_box_inc locked_box_inc health_pot_inc health_savings_inc multitreat_inc
 safe_box_kids locked_box_kids health_pot_kids health_savings_kids multitreat_kids
 safe_box_inc_m locked_box_inc_m health_pot_inc_m health_savings_inc_m multitreat_inc_m
 safe_box_kids_m locked_box_kids_m health_pot_kids_m health_savings_kids_m multitreat_kids_m
 bg_weekly_income bg_children
 bg_weekly_income_m  bg_children_m
 rosbg_monthly_contrib i.strata ${individual_controls}, cluster(id_harp_rosca);

lincom safe_box+safe_box_prov;
test safe_box+safe_box_prov=0;

local sb_pb_estimate=r(estimate);
test safe_box+safe_box_pb=0;

lincom health_savings+health_savings_prov;
test health_savings+health_savings_prov=0;

lincom health_savings+health_savings_pb;
test health_savings+health_savings_pb=0;

*Columns 3&4;
xi: reg fol2_illness_untreated_3mo
 safe_box safe_box_prov safe_box_pb safe_box_fmarry
 locked_box locked_box_prov locked_box_pb locked_box_fmarry
 health_pot health_pot_prov health_pot_pb health_pot_fmarry
 health_savings health_savings_prov health_savings_pb health_savings_fmarry
 multitreat multitreat_prov multitreat_pb multitreat_fmarry
 safe_box_inc locked_box_inc health_pot_inc health_savings_inc multitreat_inc
 safe_box_kids locked_box_kids health_pot_kids health_savings_kids multitreat_kids
 safe_box_inc_m locked_box_inc_m health_pot_inc_m health_savings_inc_m multitreat_inc_m
 safe_box_kids_m locked_box_kids_m health_pot_kids_m health_savings_kids_m multitreat_kids_m
 bg_weekly_income bg_children
 bg_weekly_income_m  bg_children_m
 rosbg_monthly_contrib i.strata ${individual_controls}, cluster(id_harp_rosca);

lincom safe_box+safe_box_prov;
test safe_box+safe_box_prov=0;

lincom safe_box+safe_box_pb;
test safe_box+safe_box_pb=0;

lincom safe_box+safe_box_fmarry;
test safe_box+safe_box_fmarry=0;


lincom health_savings+health_savings_prov;
test health_savings+health_savings_prov=0;

lincom health_savings+health_savings_pb;
test health_savings+health_savings_pb=0;

lincom health_savings+health_savings_fmarry;
test health_savings+health_savings_fmarry=0;


*/;


************;
*Appendix Table A6;
************;
#delimit;

use HARP_ROSCA_final, clear;
sort id_harp_rosca;

gen bg_female_married=bg_female*bg_married;

global individual_controls "bg_provider bg_hyperbolic  bg_female_married  bg_b1_age bg_female bg_pat_now_impat_later bg_max_discount bg_n_roscas";

for var  fol1_sb_amt_in_box fol2_sb_amt_in_box  fol1_l_amt_in_box  fol2_l_amt_in_box  fol1_l_called_fo  fol2_l_called_fo  fol1_hsacc_deposit_amount  fol2_hsacc_deposit_amount
  fol1_hp_pot_contribute  fol2_hp_pot_contribute \ num 1/10: global depvarY="X";

local i 1;
while `i' <= 10 {;
	xi: reg ${depvar`i'}  ${individual_controls} rosbg_monthly_contrib i.strata, cluster(id_harp_rosca);
	sum ${depvar`i'} if e(sample);


	local i = `i' + 1;
	};
*/;


************;
*Appendix Table A7;
************;
#delimit;

use HARP_ROSCA_final, clear;
sort id_harp_rosca;

for var  
 fol1_uses_safe_box  fol2_uses_safe_box fol1_sb_amt_in_box fol2_sb_amt_in_box 
 fol1_uses_lbox  fol2_uses_lbox fol1_l_amt_in_box fol2_l_amt_in_box
 fol1_hp_pot_contribute fol2_hp_pot_contribute fol1_hp_helped_save_more fol2_hp_helped_save_more 
 fol1_hsa_deposit_hsa fol2_hsa_deposit_hsa fol1_hsacc_balance fol2_hsacc_balance \ num 1/16:
 global depvarY="X";

local i 1;
while `i' <= 16 {;

	xi: reg ${depvar`i'} has_followup3  rosbg_monthly_contrib i.strata, cluster(id_harp_rosca);
	sum ${depvar`i'} if e(sample) & has_followup3==0;

	local i = `i' + 1;
	};
*/;


*********************************;
*Appendix Table A8;
**********************************;

* DATA FOR THIS TABLE COMES FROM OTHER PROJECT FOR WHICH DATA CANNOT BE MADE PUBLIC AT THIS TIME;

*********************************;
*Appendix Table A9;
**********************************;

for any
 why_expensive why_never_thought why_theft why_otherbox why_other:
 gen fol3_box_X=1 if fol3_sb_X==1 | fol3_l_X==1 \
 replace fol3_box_X=0 if fol3_box_X==. & fol3_sb_X==0 \
 replace fol3_box_X=0 if fol3_box_X==. & fol3_l_X==0;

sum fol3_box_why_otherbox fol3_box_why_never_thought fol3_box_why_expensive fol3_box_why_theft;
sum fol3_hp_why_never_thought fol3_hp_why_ROSCA_notforhealth;
sum fol3_hsa_why_never_thought fol3_hsa_why_ROSCA_notforhealth;






