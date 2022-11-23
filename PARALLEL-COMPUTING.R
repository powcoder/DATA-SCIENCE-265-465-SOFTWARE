
library(parallel)

### test function

f0 = function(nv) {
  mat = matrix(runif(prod(nv)),nv[1],nv[2])
  return(apply(mat,1,median)) 
  
}

### set up parallel input

in.list = list(c(200,100000), c(400,100000), c(600,100000), c(800,100000),c(200,100000), c(400,100000), c(600,100000), c(800,100000))

### we can time the jobs

system.time(junk <- f0(in.list[[1]]))
system.time(junk <- f0(in.list[[2]]))
system.time(junk <- f0(in.list[[3]]))
system.time(junk <- f0(in.list[[4]]))

### the lapply function does all 8 jobs in series

system.time(junk <- lapply(in.list,f0))

### with parallel processing the jobs are done in parallel

mc = 8
cl = makeCluster(mc)
clusterSetRNGStream(cl,1234)
system.time(junk2 <- parLapply(cl,in.list,f0))
stopCluster(cl)

