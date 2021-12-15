library(openxlsx)
library(data.table)
library(tidyverse)
library(ggstatsplot)
library(readxl)
library(hrbrthemes)
library(metan)

df_cc <- data.frame(Rust_controlled_condition)

gen_alpha_cc <- gamem(df_cc, GEN, REP, AUDPC_n, block = BLOCK)

get_model_data(gen_alpha_cc)
get_model_data(gen_alpha_cc,  "lrt")
plot(gen_alpha_cc)
plot(gen_alpha_cc, type = "re")

hist(gen_alpha_cc$AUDPC$BLUPgen$Predicted)
hist(df_cc$AUDPC_n)

