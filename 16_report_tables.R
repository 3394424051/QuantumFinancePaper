####################################################
# TABLE 1
####################################################

final_results <-
data.frame(

 Strategy=c(
  "QQQ",
  "Equal",
  "Markowitz",
  "Black-Litterman",
  "QAOA",
  "VQE"
 ),

 CAGR=c(),
 Volatility=c(),
 Sharpe=c(),
 Sortino=c(),
 MaxDD=c(),
 VaR95=c(),
 CVaR95=c(),
 DSR=c()

)

write.csv(
 final_results,
 "results/final_table.csv",
 row.names = FALSE
)
