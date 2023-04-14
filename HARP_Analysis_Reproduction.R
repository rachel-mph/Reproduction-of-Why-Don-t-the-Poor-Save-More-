
-------------------------------------------------------------------------------
  # Reproduction of 
  # Dupas, Pascaline; Robinson, Jonathan, 2015, "Why Don’t the Poor Save More? 
  # Evidence from Health Savings Experiments"Why Don't the Poor Save More?             
  # 
  # Replication completed by Rachel Pizatella - rachel_pizatella@berkeley.edu
  #-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# This file includes R code to replicate Table 3 in the original paper
# impacts on investment, risk-coping; and health goals 
#
#-------------------------------------------------------------------------------
# Install packages 
install.packages("foreign") 
install.packages("lmtest")
install.packages("car")
install.packages ("sandwich")
install.packages ("multcomp")


# Load libararies
library(foreign)
library(lmtest)
library(car)
library(sandwich)
library(multcomp)

# Load data
df <- read.dta("HARP_ROSCA_final.dta")

#===============================================================================
# Table 3: impacts on investment, risk-coping;
#===============================================================================

#-------------------------------------------------------------------------------
# Column 1
#-------------------------------------------------------------------------------
# run regression
model_1 <- lm(fol2_amtinvest_healthproducts ~ safe_box + locked_box + health_pot + 
              health_savings + multitreat + rosbg_monthly_contrib + 
              strata_dummies, data = df)
model_clSE_1 <- coeftest(model_1, vcov = vcovCL, cluster = ~id_harp_rosca)

# print results
print(model_clSE_1)

# test joint hypothesis
joint_1 <- lm(fol2_amtinvest_healthproducts ~ safe_box + locked_box + 
                 health_pot + health_savings, data = df)

# test significance of safe_box,locked_box - safe_box, health_pot - locked_box
summary(glht(joint_1, linfct = c("safe_box = 0")))
summary(glht(joint_1, linfct = c("locked_box - safe_box = 0")))
summary(glht(joint_1, linfct = c("health_pot - locked_box = 0")))

# calculate control summary statistics
subset_data <- df[df$e == 1 & df$encouragement == 1, ]

# print results 
summary(subset_data$fol2_amtinvest_healthproducts)


#-------------------------------------------------------------------------------
# Column 2
#-------------------------------------------------------------------------------
# run regression
model_2 <- lm(fol2_amtinvest_healthproducts ~ safe_box + locked_box + health_pot + 
                health_savings + multitreat + rosbg_monthly_contrib + 
                strata_dummies + bg_b1_age + bg_female + bg_female_married + 
                bg_provider + bg_hyperbolic  + bg_pat_now_impat_later + 
                bg_max_discount + bg_n_roscas, data = df)
model_clSE_2 <- coeftest(model_2, vcov = vcovCL, cluster = ~id_harp_rosca)

# print results
print(model_clSE_2)

# test joint hypothesis
joint_1 <- lm(fol2_amtinvest_healthproducts ~ safe_box + locked_box + 
                health_pot + health_savings, data = df)

# test significance of safe_box,locked_box - safe_box, health_pot - locked_box
summary(glht(joint_1, linfct = c("safe_box = 0")))
summary(glht(joint_1, linfct = c("locked_box - safe_box = 0")))
summary(glht(joint_1, linfct = c("health_pot - locked_box = 0")))


# calculate control summary statistics
summary(subset_data$fol2_amtinvest_healthproducts)

#-------------------------------------------------------------------------------
# Column 3
#-------------------------------------------------------------------------------
# run regression
model_3 <- lm(fol2_illness_untreated_3mo ~ safe_box + locked_box + health_pot + 
                health_savings + multitreat + rosbg_monthly_contrib + 
                strata_dummies, data = df)
model_clSE_3 <- coeftest(model_3, vcov = vcovCL, cluster = ~id_harp_rosca)

# print results
print(model_clSE_3)

# calculate control summary statistics
summary(subset_data$fol2_illness_untreated_3mo)

#-------------------------------------------------------------------------------
# Column 4
#-------------------------------------------------------------------------------
# run regression
model_4 <- lm(fol2_illness_untreated_3mo ~ safe_box + locked_box + health_pot + 
                health_savings + multitreat + rosbg_monthly_contrib + 
                strata_dummies + bg_b1_age + bg_female + bg_female_married + 
                bg_provider + bg_hyperbolic  + bg_pat_now_impat_later + 
                bg_max_discount + bg_n_roscas, data = df)
model_clSE_4 <- coeftest(model_4, vcov = vcovCL, cluster = ~id_harp_rosca)

# print results
print(model_clSE_4)

# calculate control summary statistics
summary(subset_data$fol2_illness_untreated_3mo)

#-------------------------------------------------------------------------------
# Column 5
#-------------------------------------------------------------------------------
# run regression
model_5 <- lm(fol2_reached_goal ~ safe_box + locked_box + health_pot + 
                health_savings + multitreat + rosbg_monthly_contrib + 
                strata_dummies, data = df)
model_clSE_5 <- coeftest(model_5, vcov = vcovCL, cluster = ~id_harp_rosca)

# print results
print(model_clSE_5)

# calculate control summary statistics
summary(subset_data$fol2_reached_goal)

#-------------------------------------------------------------------------------
# Column 6
#-------------------------------------------------------------------------------
# run regression
model_6 <- lm(fol2_reached_goal ~ safe_box + locked_box + health_pot + 
                health_savings + multitreat + rosbg_monthly_contrib + 
                strata_dummies + bg_b1_age + bg_female + bg_female_married + 
                bg_provider + bg_hyperbolic  + bg_pat_now_impat_later + 
                bg_max_discount + bg_n_roscas, data = df)
model_clSE_6 <- coeftest(model_6, vcov = vcovCL, cluster = ~id_harp_rosca)

# print results
print(model_clSE_6)

# calculate control summary statistics
summary(subset_data$fol2_reached_goal)

