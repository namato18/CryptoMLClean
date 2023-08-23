library(riingo)
library(dplyr)
library(tictoc)
library(purrr)

tictoc::tic()
Sys.setenv(TZ='UTC')

possibly_riingo_prices = possibly(riingo_prices, otherwise = "ERROR")

########################################## READ IN NAMES OF COINS WERE INTERESTED IN AND REMOVE BAD COINS
########################################## 
str1 = readRDS('tickers/stock1.rds')

bad_data = which(str1 %in% c("VMT","PEOP"))

str1 = str1[-bad_data]
# str1 = readRDS('tickers/str1.rds')
# str1 = str1[-61]

########################################## SET TIMEFRAMES
########################################## 
# timeframes = c("15min","1hour","2hour","4hour","8hour","1day")
# timeframes.n = c(15,60,120,240,480,1440)

########################################## SET UP LOOPS, ONCE FOR EACH TIMEFRAME
########################################## 
days.back = 700
for(j in 1:length(str1)){
  # GRAB TIINGO DATA
  df1 = possibly_riingo_prices(ticker = str1[j], resample_frequency = "weekly", end_date = Sys.Date(), start_date = Sys.Date() - days.back)
  df2 = possibly_riingo_prices(ticker = str1[j], resample_frequency = "weekly", end_date = Sys.Date() - days.back, start_date = Sys.Date() - days.back*2)
  if(df2[1] == 'ERROR'){
    df = df1
  }else{
    # REMOVE FIRST ROW FROM DF1 TO AVOID DUPLICATE
    df1 = df1[-1,]
    
    # COMBINE DF1 AND DF2
    df = rbind(df2, df1)
  }
  
  df = df[,-c(1,8:14)]
  df = df[,c(1,5,3,4,2,6)]
  # WRITE .CSV
  write.csv(df, paste0("C:/Users/xbox/Desktop/Rstuff/RiingoPulledData/", str1[j],"_weekly.csv"), row.names = FALSE)
  
  print(j)
}


tictoc::toc()

# test = read.csv("C:/Users/xbox/Desktop/Rstuff/RiingoPulledData/AAPL_daily.csv")
