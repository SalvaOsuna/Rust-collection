library(openxlsx)
library(data.table)
library(tidyverse)
library(ggstatsplot)
library(readxl)
library(hrbrthemes)
library(metan)

df_cc <- data.frame(Rust_controlled_condition)

gen_alpha_cc <- gamem(df_cc, GEN, REP, c("AUDPC_n","PL50_n", "IF_n","IT_n"), block = BLOCK)

get_model_data(gen_alpha_cc)


get_model_data(gen_alpha_cc,  "lrt")
plot(gen_alpha_cc)
plot(gen_alpha_cc, type = "re")

hist(gen_alpha_cc$AUDPC$BLUPgen$Predicted)
hist(df_cc$AUDPC_n)

BLUP_AUDPC <- gen_alpha_cc$AUDPC_n$BLUPgen
write.xlsx(BLUP_AUDPC, file = "BLUP_AUDPC.xlsx", sep = "\t")

BLUP_PL50 <- gen_alpha_cc$PL50_n$BLUPgen
write.xlsx(BLUP_PL50, file = "BLUP_PL50.xlsx", sep = "\t")

BLUP_IF <- gen_alpha_cc$IF_n$BLUPgen
write.xlsx(BLUP_IF, file = "BLUP_IF.xlsx", sep = "\t")

BLUP_IT <- gen_alpha_cc$IT_n$BLUPgen
write.xlsx(BLUP_IT, file = "BLUP_IT.xlsx", sep = "\t")

BLUPSinfo <- data.frame(BLUPS)
head(BLUPSinfo)
library(ggplot2)

#by material:
bp18 <- ggplot(BLUPSinfo, aes(x=Material, y=Predicted_R18, group=Material)) + 
  geom_boxplot(aes(fill=Material))
bp18

bp19 <- ggplot(BLUPSinfo, aes(x=Material, y=Predicted_R19, group=Material)) + 
  geom_boxplot(aes(fill=Material))
bp19

bp20 <- ggplot(BLUPSinfo, aes(x=Material, y=Predicted_20, group=Material)) + 
  geom_boxplot(aes(fill=Material))
bp20

bpall <- ggplot(BLUPSinfo, aes(x=Material, y=Predicted_Rall, group=Material)) + 
  geom_boxplot(aes(fill=Material))
bpall

bpaudpc <- ggplot(BLUPSinfo, aes(x=Material, y=Predicted_AUDPC , group=Material)) + 
  geom_boxplot(aes(fill=Material))
bpaudpc

#by specie
bp18s <- ggplot(BLUPSinfo, aes(x=Specie, y=Predicted_R18, group=Specie)) + 
  geom_boxplot(aes(fill=Specie))
bp18s

bp19s <- ggplot(BLUPSinfo, aes(x=Specie, y=Predicted_19, group=Specie)) + 
  geom_boxplot(aes(fill=Specie))
bp19s

bp20s <- ggplot(BLUPSinfo, aes(x=Specie, y=Predicted_20, group=Specie)) + 
  geom_boxplot(aes(fill=Specie))
bp20s

bpalls <- ggplot(BLUPSinfo, aes(x=Specie, y=Predicted_Rall, group=Specie)) + 
  geom_boxplot(aes(fill=Specie))
bpalls

bpaudpcs <- ggplot(BLUPSinfo, aes(x=Specie, y=Predicted_AUDPC , group=Specie)) + 
  geom_boxplot(aes(fill=Specie))
bpaudpcs

#Load info U. pisi colonies
colonies <- data.frame(read.xlsx("U_pisi colonies.xlsx", sheet = "DEFINITIVO", colNames = T))
head(colonies)
library(agricolae)
library(foreign)
tx <- with(data = colonies, interaction(Rust, HA))
amod <- aov(HA ~ tx, data=colonies)
dd<- HSD.test(amod, "tx", group=TRUE)
dd$groups
