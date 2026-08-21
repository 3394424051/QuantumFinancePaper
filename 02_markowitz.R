library(PortfolioAnalytics)
library(ROI)
library(ROI.plugin.quadprog)

load("results/prepared.RData")

assets <- colnames(returns)

port <- portfolio.spec(assets)

port <- add.constraint(
  port,
  type="full_investment"
)

port <- add.constraint(
  port,
  type="long_only"
)

port <- add.objective(
  port,
  type="risk",
  name="StdDev"
)

port <- add.objective(
  port,
  type="return",
  name="mean"
)

markowitz <- optimize.portfolio(
  R=returns,
  portfolio=port,
  optimize_method="ROI"
)

markowitz_weights <-
  extractWeights(markowitz)

save(
  markowitz_weights,
  file="results/markowitz.RData"
)
