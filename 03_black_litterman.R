library(BLCOP)

load("results/prepared.RData")

mu <- colMeans(returns)

sigma <- cov(returns)

bl <- BLPosterior(
  Mu=mu,
  Sigma=sigma
)

bl_weights <-
  solve(sigma) %*%
  bl@posteriorMean

bl_weights <-
  as.vector(bl_weights)

bl_weights <-
  bl_weights /
  sum(bl_weights)

save(
  bl_weights,
  file="results/black_litterman.RData"
)
