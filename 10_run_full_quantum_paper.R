load("results/prepared.RData")

source("04_qaoa_portfolio.R")

source("05_vqe_portfolio.R")

source("06_walkforward_backtest.R")

wf <- walkforward_study(
  returns,
  train_years=2
)

save(
  wf,
  file="results/walkforward_results.RData"
)

cat(
  "\nQUANTUM FINANCE STUDY COMPLETED\n"
)
