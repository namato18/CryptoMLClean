# BAD
# XOR
library(riingo)

x = "btc eth lina reef key sand mdt neo cfx fet twt xrp Vet matic sand ar chz dent doge dot fet icp lrc fet mana mask mina near glmr rsr movr Dydx algo auction dar ens imx loka woo scrt ape gal arb op stg apt hook ldo inj ankr cfx ocean ceres dego ceek hero ufo bonk dexe oxt tlm tko tru burger lit ckb uma cro mbox yfdai perp rfox ygg iota gala sui yooshi sidus cru wnxm cwar swash velo vra srm ordi icx snx flux ilv ach high pha pros vite iost qtum trx ctxc phb ctk ont ern nkn wtc cocos chess for dodo df yfii sun kas kda fil alu ksm orn dc caw tomo celer one mx dext deso psg og cgg rare hft agix zil nexa fida tvk cream hard eos atom pdex kai brise pyr joe UNI LINK FRAX GRT AAVE RPL MKR CRV KAVA GMX FXS NXM COMP RUNE GNO OSMO 1INCH CVX BAL ZRX BAND JOE TRIBE SUSHI GNS AMP KNC VVS ALPHA API3 LQTY NMR NRV STPT CQT NEST POND KEEP REN BNT MPL XVS RAY AURA BADGER IDEX FTM HFT AMPL AKT SPELL TLOS BSW ACA GAFI ORN ZEN DATA OGN OMG ENJ BAT XTZ LPT SKL"
# x = "UNI LINK FRAX GRT AAVE RPL MKR CRV KAVA GMX FXS NXM COMP RUNE GNO OSMO 1INCH CVX BAL ZRX BAND JOE TRIBE SUSHI GNS AMP KNC VVS ALPHA API3 LQTY NMR NRV STPT CQT NEST POND KEEP REN BNT MPL XVS RAY AURA BADGER IDEX FTM HFT AMPL AKT SPELL TLOS BSW ACA GAFI ORN ZEN DATA OGN OMG ENJ BAT XTZ LPT SKL"
x2 = "BNB; ADA; SOL; SHIB; LTC; AVAX; STX; EOS; THETA; XTZ; FLOW; BTT; LUNC; FTT; CAKE; ROSE; CELO; SFP; GMT; WAVES; SC; STORJ; C98; SYS; STRAX; ARPA; COTI; UTK; KMD; TRB; FLOKI; RNDR; ETC"


# combining lists of coins
x = strsplit(toupper(x),split = " ")[[1]]
x2 = strsplit(x2, split = "; ")[[1]]

x3 = c(x,x2)
x3 = paste0(x3,"USDT")
x3 = unique(x3)
x3 = tolower(x3)
#saveRDS(x3, "tickers/str1.rds")
##



# str1 = strsplit(x2, split = "; ")[[1]]
# str1 = paste0(str1,"usdt")
# str1 = toupper(str1)
# str2 = tolower(str1)
# y = setNames(str2,str1)

not_supported = c()
for(i in 1:length(x3)){
if(is_supported_ticker(x3[i], 'crypto') == TRUE){
  next()
}else{
  print(paste0(x3[i]," is not supported"))
  not_supported = c(not_supported, x3[i])
}
}

not_supported = paste(not_supported, collapse = "|")

ind.remove = grep(pattern = not_supported, x = x3)

clean.list = x3[-ind.remove]

saveRDS(clean.list, "C:/Users/xbox/Desktop/Rstuff/master.lists/clean.list.rds")

# new_cryptos = str1

# ind = which(str2 %in% not_supported)
# str1 = str1[-ind]
# str2 = str2[-ind]
# 
# 
# 
# # saveRDS(str1, 'tickers/str.new.coins.rds')
# 
# y2 = setNames(str2,str1)
# 
# ind.remove = which(str1 %in% c('COCOSUSDT','YFDAIUSDT','DEXTUSDT','KEEPUSDT'))
# 
# str1 = str1[-ind.remove]
# str2 = str2[-ind.remove]
# 
# saveRDS(str1, 'tickers/str1.rds')
# saveRDS(str2, 'tickers/str2.rds')

# check ho far back
# df = riingo_crypto_prices('btcusdt', end_date = Sys.Date(), resample_frequency = '4hour')
