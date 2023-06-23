library(binance)


## TestingR
secret = "rEg9vqo61kMpB7up3kbp2Huy1mMyYQFpAdyc3OBO32dwE8m32eHcr3185aEa2d7k"
api_key = "UWG67pA2SI65uA3ZzqEzSQZbU9poUYHtOiZ5YAdV3lJXhi6dUSeanbxLlcTFrN3w"

binance::authenticate(key = api_key,secret = secret)

binance::base_url("https://api.binance.us")

binance::market_ping()

df = binance::market_average_price('DOGEUSDT')
df$price

spot_new_order(
  order_type = "MARKET",
  symbol = "DOGEUSDT",
  side = "BUY",
  quantity = 200
)


spot_new_order(
  order_type = "MARKET",
  symbol = "DOGEUSDT",
  side = "SELL",
  quantity = 199
  )
