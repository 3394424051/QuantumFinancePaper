library(PerformanceAnalytics)

compute_stats <- function(x)
{

  c(
    CAGR =
      Return.annualized(x),

    Vol =
      StdDev.annualized(x),

    Sharpe =
      SharpeRatio.annualized(x),

    Sortino =
      SortinoRatio(x),

    MaxDD =
      maxDrawdown(x),

    VaR =
      VaR(x),

    CVaR =
      ES(x)
  )

}
``
