library(aws.s3)
library(tictoc)
# Sys.setenv("AWS_ACCESS_KEY_ID" = "AKIAZI3NHYNJUAAKBDHG",
#            "AWS_SECRET_ACCESS_KEY" = "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",
#            "AWS_DEFAULT_REGION" = "us-east-1")
Sys.setenv(
  "AWS_ACCESS_KEY_ID" = "AKIAZI3NHYNJ2L5YMIHV",
  "AWS_SECRET_ACCESS_KEY" = "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",
  "AWS_DEFAULT_REGION" = "us-east-1"
)
# bucketlist()
# 
# write.csv(iris, file.path(tempdir(), "iris.csv"))
# 
# 
# # PUT OBJECT
# put_object(
#   file = file.path(tempdir(), "iris.csv"),
#   object = "iris.csv",
#   bucket = "cryptomlbucket"
# )
# 
# 
# # READ OBJECT
# GETBOOST = s3read_using(FUN = readRDS, bucket = "cryptomlbucket/TiingoBoosts", object = "bst_ZRXUSDT_15min-0.1.rds")


# AUTOMATED PUT TO AWS
tic()
x = list.files(path = 'E:/bsts-11-22-2023')

for(i in 1:length(x)){
  put_object(
    file = file.path("E:/bsts-11-22-2023", x[i]), 
    object = x[i], 
    bucket = "cryptomlbucket/TiingoBoosts"
  )
  print(i)
}
toc()

# TRY TO REMOVE A FILE
# aws.s3::delete_object(object = "BTCUSDT.rds", bucket = "cryptomlbucket/Automation/nick")
# 
# aws.s3::bucketlist()
