library(cronR)

cmd <- cron_rscript("testCronFunc.R")

cron_add(command = cmd, frequency = 'hourly', id = 'test1', at= '00:01', description = 'my process 1')
