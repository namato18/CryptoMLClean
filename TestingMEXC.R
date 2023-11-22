library(httr)

access.key = "mx0vglKvuaMH82ONzF"
secret.key = "ae761ddd0309456cac6ca8b055c92a4b"

# Generate timestamp in milliseconds
timestamp <- as.character(round(as.numeric(Sys.time()) * 1000))

full.url = paste0("https://api.mexc.com/api/v3/account?timestamp=",timestamp)

headers <- c(
  "X-MEXC-APIKEY" = access.key,
  "Content-Type" = "application/json"
)

test_get <- httr::GET(full.url, config = add_headers(headers))

test_get$status_code





















##########################################################


url = "https://contract.mexc.com/api/v1/private/position/list/history_positions"

params <- list(
  page_num = "1",
  page_size = "20"
)
# Sort parameters in dictionary order and create parameter string
param_string <- paste0(names(params)[order(names(params))], "=", sapply(params[order(names(params))], URLencode), collapse = "&")
param_string

# body <- toJSON(params)

# Generate timestamp in milliseconds
timestamp <- as.character(as.numeric(Sys.time()) * 1000)

# Concatenate accessKey + timestamp + obtained parameter string
message <- paste0(access.key,timestamp, param_string)

# Create HMAC-SHA256 signature
signature <- sha256(message, key = "HMAC")


headers <- c(
  "Request-Time" = timestamp,
  "Signature" = signature,
  "ApiKey" = access.key
)

url = modify_url(url, query = params)

response <- httr::POST(url, config = httr::add_headers(.headers = headers))

test = rawToChar(response$content)
test = fromJSON(test, flatten = TRUE)
test$message
