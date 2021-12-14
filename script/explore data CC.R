library(openxlsx)
library(data.table)
library(tidyverse)
library(ggstatsplot)
library(readxl)
library(hrbrthemes)
library(metan)

df_cc <- data.frame(Rust_controlled_condition)

gen_alpha_cc <- gamem(df_cc, GEN, REP, c(AUDPC,PL50,IF), block = BLOCK)
gen_alpha_cc2 <- gamem(df_cc, GEN, REP, c(AUDPC,PL50,IF))

get_model_data(gen_alpha_cc)
get_model_data(gen_alpha_cc2)

hist(gen_alpha_cc$AUDPC$BLUPgen$Predicted)
hist(df_cc$AUDPC)

hist(gen_alpha_cc$PL50$BLUPgen$Predicted)
hist(df_cc$PL50)

hist(gen_alpha_cc$IF$BLUPgen$Predicted)
hist(df_cc$IF)

