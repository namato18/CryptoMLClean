list.compare = list.files(path = "../bsts-8-24-2023", full.names = TRUE)
short.names =list.files(path = "../bsts-8-24-2023", full.names = FALSE) 

ind = grep(pattern = "compare", x = list.compare)

list.compare = list.compare[ind]
short.names = short.names[ind]


f1.scores = c()
for(i in 1:length(list.compare)){
  df = readRDS(list.compare[i])
  
  colnames(df) = c("outcome.test","pred")
  
  df$decision = 0
  df$decision[df$pred >= 0.5] = 1
  assign('compare',df,.GlobalEnv)
  
  true.pos = length(which(df$outcome.test == 1 & df$decision == 1))
  false.pos = length(which(df$outcome.test == 0 & df$decision == 1))
  false.neg = length(which(df$outcome.test == 1 & df$decision == 0))
  
  
  precision = true.pos / (true.pos + false.pos) * 100
  recall = true.pos / (true.pos + false.neg) * 100
  f1 = 2*((precision * recall)/(precision + recall)) / 100
  
  precision = round(precision, digits = 4)
  recall = round(recall, digits = 4)
  f1 = round(f1, digits = 4)
  
  f1.scores = c(f1.scores, f1)
}
f1.scores[is.na(f1.scores)] = 0

quick.look = data.frame(f1.scores = f1.scores,
                        short.names = short.names)
quick.look = quick.look[order(quick.look$f1.scores, decreasing = TRUE),]

sort(f1.scores, decreasing = TRUE)
max(f1.scores)

short.names[which(f1.scores == max(f1.scores))]


