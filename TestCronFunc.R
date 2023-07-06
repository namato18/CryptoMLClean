library(lubridate)



cond1 = (Sys.time() >= as_datetime(paste0(Sys.Date(), " 00:00:00"))) & (Sys.time() < as_datetime(paste0(Sys.Date(), " 00:02:00")))
cond2 = (Sys.time() >= as_datetime(paste0(Sys.Date(), " 04:00:00"))) & (Sys.time() < as_datetime(paste0(Sys.Date(), " 04:02:00")))
cond3 = (Sys.time() >= as_datetime(paste0(Sys.Date(), " 08:00:00"))) & (Sys.time() < as_datetime(paste0(Sys.Date(), " 08:02:00")))
cond4 = (Sys.time() >= as_datetime(paste0(Sys.Date(), " 12:00:00"))) & (Sys.time() < as_datetime(paste0(Sys.Date(), " 12:02:00")))
cond5 = (Sys.time() >= as_datetime(paste0(Sys.Date(), " 16:00:00"))) & (Sys.time() < as_datetime(paste0(Sys.Date(), " 16:02:00")))
cond6 = (Sys.time() >= as_datetime(paste0(Sys.Date(), " 20:00:00"))) & (Sys.time() < as_datetime(paste0(Sys.Date(), " 20:02:00")))

str1 = readRDS('str1.rds')

if(cond1 | cond2 | cond3 | cond4 | cond5 | cond6){
  source('/home/rstudio/CryptoWatching/MakePredictions.R')
  predict.tomorrow.multiple(str1[1:6], '4hour', 0.9)
}
