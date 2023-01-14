# test parameters
test_fun <- function(x){
  for(i in 1:1000000){
    v = rep(1,x)
    v = v * 100 / 100 + 100 - 100
  }
}
test_n = 20


# for
start <- Sys.time()
for(i in 1:test_n){
  test_fun(100)
}
end <- Sys.time()
print(end - start)


# parallel
library(parallel)

cl_num <- detectCores() 
cl <- makeCluster(cl_num)

# clusterExport(cl, c("变量名1", "变量名2", "函数1"))
# clusterEvalQ(cl, library(包名))

start <- Sys.time()
result <- parSapply(cl = cl,
                    X = rep(100,test_n),
                    FUN = test_fun)
end <- Sys.time()
print(end - start)

stopCluster(cl)


# doparallel+foreach
library(doParallel)
library(foreach)

cl_num <- detectCores()
cl <- makeCluster(cl_num)

start <- Sys.time()
result <- foreach(x = rep(100,test_n),
                  .export = NULL,
                  .packages = NULL) %dopar% test_fun(x)
end <- Sys.time()
print(end - start)

stopCluster(cl)
