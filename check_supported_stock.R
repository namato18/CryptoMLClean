# BAD
# XOR
library(riingo)

x = "AAPL MSFT GOOGL AMZN NVDA TSLA META BRK.B V JPM UNH XOM LLY VMT JNJ MA AVGO PG HD ORCL CVX MRK KO PEOP COST ABBV ADBE BAC CRM MCD CSCO PFE TMO CAN NFLX ABT LIN AMD DHR CMCSA NKE TMUS DIS WFC TXN UPS PM NEE MSFT SPGI INTC BAC AXP SBUX GS BLK C F MMM"
str1 = strsplit(x, split = " ")[[1]]
str1 = toupper(str1)
str2 = tolower(str1)
y = setNames(str2,str1)

not_supported = c()
for(i in 1:length(str1)){
  if(is_supported_ticker(str1[i]) == TRUE){
    next()
  }else{
    print(paste0(str1[i]," is not supported"))
    not_supported = c(not_supported, str1[i])
  }
}

ind = which(str1 %in% not_supported)
str1 = str1[-ind]
str2 = str2[-ind]


saveRDS(str1, 'tickers/stock1.rds')
saveRDS(str2, 'tickers/stock2.rds')

# check ho far back
# df = riingo_crypto_prices('btcusdt', end_date = Sys.Date(), resample_frequency = '4hour')
