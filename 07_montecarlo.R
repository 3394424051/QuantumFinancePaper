N <- 1000

mc <- list()

for(i in 1:N)
{

  idx <- sample(
    1:nrow(returns),
    replace=TRUE
  )

  sample_returns <-
    returns[idx,]

  ret <- apply(
    sample_returns,
    2,
    mean
  )

  vol <- apply(
    sample_returns,
    2,
    sd
  )

  mc[[i]] <- c(
    ret,
    vol
  )

}
