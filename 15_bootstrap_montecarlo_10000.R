####################################################
# MONTE CARLO
####################################################

N <- 10000

simulate_strategy <- function(
  returns,
  weights,
  horizon = 252
){

  sims <- matrix(
    NA,
    N,
    horizon
  )

  for(i in 1:N)
  {

    idx <- sample(
      1:nrow(returns),
      horizon,
      replace = TRUE
    )

    sample_ret <-
      returns[idx,]

    sims[i,] <-
      sample_ret %*%
      weights

  }

  sims
}
