library(httr)
library(openssl)
library(jsonlite)

access.key = "mx0vglKvuaMH82ONzF"
secret.key = "ae761ddd0309456cac6ca8b055c92a4b"

#################################################
#################################################
#################################################
#################################################

MEXC_Spot_Balances <- function(){
# Generate timestamp in milliseconds
timestamp <- as.character(round(as.numeric(Sys.time()) * 1000))

message <- paste0("recvWindow=5000&timestamp=",timestamp)

hash <- sha256(message, key = secret.key)


# Create full.url
# Added timestamp to URL as it's listed as required parameter in docs
full.url = paste0("https://api.mexc.com/api/v3/account?recvWindow=5000&timestamp=",timestamp,"&signature=",hash)

# Create headers as described in documentation
headers <- c(
  "X-MEXC-APIKEY" = access.key,
  "Content-Type" = "application/json"
)

test_get <- httr::GET(full.url, config = add_headers(headers))

test_get$status_code

test = rawToChar(test_get$content)
test = fromJSON(test, flatten = TRUE)
x = test$balances

return(x)
}


#################################################
#################################################
#################################################
#################################################

MEXC_Spot_Order <- function(symbol, side, type, quantity){
  # symbol = 'REEFUSDT'
  # side = 'BUY'
  # type = 'MARKET'
  # quantity = 10
  # price = 2.9
  
  timestamp <- as.character(round(as.numeric(Sys.time()) * 1000))
  if(side == "BUY"){
    message <- paste0("symbol=",symbol,"&side=",side,"&type=",type,"&quoteOrderQty=",quantity,"&timestamp=",timestamp)
  }else{
    message <- paste0("symbol=",symbol,"&side=",side,"&type=",type,"&quantity=",quantity,"&timestamp=",timestamp)
  }
  
  hash <- sha256(message, key = secret.key)
  
  
  # Create full.url
  # Added timestamp to URL as it's listed as required parameter in docs
  full.url = paste0("https://api.mexc.com/api/v3/order?",message,"&signature=",hash)
  
  # Create headers as described in documentation
  headers <- c(
    "X-MEXC-APIKEY" = access.key,
    "Content-Type" = "application/json"
  )
  
  test_get <- httr::POST(full.url, config = add_headers(headers))
  
  test_get$status_code
  
  test = rawToChar(test_get$content)
  test = fromJSON(test, flatten = TRUE)
  x = test$balances
}

# x = MEXC_Spot_Balances()


