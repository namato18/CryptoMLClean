library(aws.s3)
library(binance)

############################################# 
############################################# PREPARE SOME THINGS

possibly_spot_new_order = possibly(spot_new_order, otherwise = 'ERROR')
coin_decimals = readRDS('coin_decimals.rds')
readRenviron(".Renviron")


Sys.setenv(
  "AWS_ACCESS_KEY_ID" = "AKIAZI3NHYNJ2L5YMIHV",
  "AWS_SECRET_ACCESS_KEY" = "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",
  "AWS_DEFAULT_REGION" = "us-east-1"
)

credentials = s3read_using(FUN = readRDS, bucket = paste0("cryptomlbucket/APIKeys"), object = "credentials.rds")

############################################# 
############################################# READ IN ACTIVE AUTOMATION

x = aws.s3::get_bucket_df("cryptomlbucket")

x.sel = x[grepl(pattern = "ActiveAutomation/.*", x = x$Key),]
user.files = unique(str_match(string = x.sel$Key, pattern = "/(.*)")[,2])
user.files = user.files[user.files != ""]


for(i in 1:length(user.files)){
  df = s3read_using(FUN = readRDS, bucket = paste0("cryptomlbucket/ActiveAutomation"), object = user.files[1])
  df$TakeProfitPrice = df$Price * (1 + (df$TakeProfit / 100))
  df$StopLossPrice = df$Price * (1 - (df$StopLoss / 100))
}
