library(aws.s3)

Sys.setenv("AWS_ACCESS_KEY_ID" = "AKIAZI3NHYNJUAAKBDHG",
           "AWS_SECRET_ACCESS_KEY" = "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",
           "AWS_DEFAULT_REGION" = "us-east-1")
bucketlist()

write.csv(iris, file.path(tempdir(), "iris.csv"))


# PUT OBJECT
put_object(
  file = file.path(tempdir(), "iris.csv"), 
  object = "iris.csv", 
  bucket = "cryptomlbucket"
)

# READ OBJECT
GETBOOST = s3read_using(FUN = readRDS, bucket = "cryptomlbucket/bsts_T/bsts", object = "bst_ACHUSDT1day1.rds")
