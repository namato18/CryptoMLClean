library(stringr)
library(lubridate)
library(xgboost)
library(quantmod)
library(tictoc)
library(CandleStickPattern)
library(dplyr)
library(riingo)

###############################
############################### GET LIST OF ALL DATASETS GATHERED USING TIINGO (COMMENTED BECAUSE NOT LOOPING NOW)

str1 = readRDS("../master.lists/clean.list.rds")
stock1 = readRDS("tickers/stock1.rds")
comb.str = paste(str1, collapse = "|")
comb.stock = paste(stock1, collapse = "|")

comb = paste(comb.str, comb.stock,sep="|")

x = list.files(path = '../RiingoPulledData',full.names = TRUE)
file.names = list.files('../RiingoPulledData')
file.names = str_replace(string = file.names, pattern = '\\.csv', replacement = "")

ind = grep(pattern = comb, x = file.names, ignore.case = TRUE)

x = x[ind]
file.names = file.names[ind]

ls.files = lapply(x, read.csv)

file.names.short = str_match(string = file.names, pattern = "(.*USDT).*")[,2]

for(i in 1:length(file.names)){
###############################
############################### READ IN DATASET
df = ls.files[[i]]
# df = read.csv("C:/Users/xbox/Desktop/Rstuff/RiingoPulledData/LINAUSDT_15min.csv")
if(nrow(df) < 30){
  next()
}

###############################
############################### JUST FILTERING OUT UNECESSARY COLUMNS
if(grepl(pattern = "USDT", file.names[i])){
  df = df[,3:8]
}


###############################
############################### CHANGE NAMES
colnames(df) = c("Date","Open","High","Low","Close","Volume")


###############################
############################### ADD IN MOVING AVERAGES
df$MA10 = NA
df$MA20 = NA
df$VMA20 = NA

for(k in 21:nrow(df)){
  df$MA10[k] = mean(df$Close[k-10:k])
  df$MA20[k] = mean(df$Close[k-20:k])
  df$VMA20[k]= mean(df$Volume[k-20:k])
}

###############################
############################### ADD IN CHECKS FOR CLOSING VALUES
C1 = rep(0, nrow(df))
C2 = rep(0, nrow(df))
C3 = rep(0, nrow(df))

for(k in 4:nrow(df)){
  if(df$Close[k] > df$Close[k-1]){
    C1[k] = 1
  }
  if(df$Close[k-1] > df$Close[k-2]){
    C2[k] = 1
  }
  if(df$Close[k-2] > df$Close[k-3]){
    C3[k] = 1
  }
}

df$P3C = C1 + C2 + C3


###############################
############################### DEFINE OTHER INPUT VALUES
df$OH = (df$High - df$Open)/df$Open * 100
df$CH = (df$Close - df$Open)/ df$Open * 100
df$LH = (df$High - df$Low) / df$Low * 100
df$LC = (df$Close - df$Low) / df$Low * 100

df$HMA = (df$High - df$MA20)/ df$MA20 * 100
df$LMA = (df$Low - df$MA20)/ df$MA20 * 100
df$CMA = (df$Close - df$MA20)/ df$MA20 * 100
df$VMA = (df$Volume - df$VMA20) / df$VMA20 * 100

lag1Vol = Lag(df$Volume, 1)
df$VolumeD = (df$Volume - lag1Vol)/lag1Vol * 100

###############################
############################### DETERMINE OUTCOME VALUES
BreakL = NA
BreakH = NA
CloseGR = NA

for(k in 2:(nrow(df))){
  if(df$Low[k] <= df$Low[k-1]){
    BreakL[k] = 1
  }else{
    BreakL[k] = 0
  }
  
  if(df$High[k] >= df$High[k-1]){
    BreakH[k] = 1
  }else{
    BreakH[k] = 0
  }
  
  if(df$Close[k] > df$Open[k]){
    CloseGR[k] = 1
  }else{
    CloseGR[k] = 0
  }
}

BreakH = c(BreakH, NA)
BreakH = BreakH[-1]

BreakL = c(BreakL, NA)
BreakL = BreakL[-1]

CloseGR = c(CloseGR, NA)
CloseGR = CloseGR[-1]
###############################
############################### REMOVE FIRST 20 ROWS AND FIRST 5 COLUMNS FOR INPUT. ALSO REMOVE LAST ROW
df = df[-c(1:20,nrow(df)),-c(1:5)]
BreakL = BreakL[-c(1:20,length(BreakL))]
BreakH = BreakH[-c(1:20,length(BreakH))]
CloseGR = CloseGR[-c(1:20,length(CloseGR))]

###############################
############################### ROUND ALL INPUTS TO 2 DIGITS
df = round(df, 2)

###############################
############################### SELECT ONLY CERTAIN INPUTS FOR BUILDING THE MODEL
df = df %>%
  select("LH","LC","VolumeD","VMA","LMA","HMA","P3C")

###############################
############################### BREAK DATA INTO TRAIN AND TEST SETS AND MAKE INTO MATRICES
set.seed(123)
sample.split = sample(c(TRUE,FALSE), nrow(df), replace = TRUE, prob=c(0.8,0.2))

train = df[sample.split,]
test = df[!sample.split,]

train = as.matrix(train)
test = as.matrix(test)

###############################
############################### SET OUTPUT VALUE
outcome = CloseGR

outcome.train = outcome[sample.split]
outcome.test = outcome[!sample.split]

###############################
############################### CREATE XG BOOSTED MODLE
bst = xgboost(data = train,
              label = outcome.train,
              objective = "binary:logistic",
              max.depth = 20,
              nrounds = 200,
              eta = 0.3,
              verbose = FALSE)
saveRDS(bst, file = paste0("C:/Users/xbox/Desktop/Rstuff/bsts-8-24-2023/bst_",file.names[i],"CloseGR.rds"))

###############################
############################### SAVE FOR BACKTESTING
pred = predict(bst, test)

compare = data.frame(cbind(outcome.test, pred))

saveRDS(compare, file = paste0("C:/Users/xbox/Desktop/Rstuff/bsts-8-24-2023/compare_",file.names[i],"CloseGR.rds"))

print(paste0(i," out of ",length(file.names)))
}

# compare$pred.value = 0
# compare$pred.value[compare$pred >= 0.5] = 1
# 
# overall.accuracy = length(which(compare$outcome.test == compare$pred.value)) / nrow(compare) * 100
# 
# pred.yes = compare[compare$pred.value == 1,]
# 
# pred.yes.accuracy = length(which(pred.yes$outcome.test == pred.yes$pred.value)) / nrow(pred.yes) * 100
