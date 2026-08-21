####################################################
# BLACK LITTERMAN WALK FORWARD
####################################################

library(BLCOP)

black_litterman_weights <- function(ret)
{
  mu <- colMeans(ret)
  sigma <- cov(ret)

  bl <- BLPosterior(
    Mu = mu,
    Sigma = sigma
  )

  w <-
    solve(sigma) %*%
    bl@posteriorMean

  w <- as.vector(w)

  w[w < 0] <- 0

  w <- w / sum(w)

  return(w)
}
