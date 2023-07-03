library(binance)


## TestingR

secret = "rEg9vqo61kMpB7up3kbp2Huy1mMyYQFpAdyc3OBO32dwE8m32eHcr3185aEa2d7k"
api_key = "UWG67pA2SI65uA3ZzqEzSQZbU9poUYHtOiZ5YAdV3lJXhi6dUSeanbxLlcTFrN3w"

# secret = "9qhPtPDePdBJnWL5zThAxqrUWXNcv37NYbyDHdkDctoJZGa0CZS6IyPqmqOdIh3i"
# api_key = "wZpij1rDxXsrnyRyuNmuaoLPsVSgJKvmmgt0rzi44GZB03za9GBFqeB6chXi1p0T"

binance::authenticate(key = api_key,secret = secret)

binance::base_url("https://api.binance.us")
# binance::base_url("https://api.binance")


binance::market_ping()

binance::spot_account()

df = binance::market_average_price('DOGEUSDT')
df$price

x = spot_new_order(
  order_type = "MARKET",
  symbol = "DOGEUSDT",
  side = "BUY",
  quantity = 200,
)


spot_new_order(
  order_type = "MARKET",
  symbol = "DOGEUSDT",
  side = "SELL",
  quantity = 199
  )

spot_new_order(
  order_type = 'LIMIT',
  symbol = 'BTCUSDT',
  side = 'SELL',
  stopPrice = 20000,
  test = TRUE
)
