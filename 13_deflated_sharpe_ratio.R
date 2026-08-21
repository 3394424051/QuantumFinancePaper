####################################################
# DEFLATED SHARPE RATIO
####################################################

library(PerformanceAnalytics)

deflated_sharpe <- function(
  returns
){

  sr <-
    as.numeric(
      SharpeRatio.annualized(
        returns
      )
    )

  n <- length(returns)

  skew <- moments::skewness(
    returns
  )

  kurt <- moments::kurtosis(
    returns
  )

  dsr <-
    sr *
    sqrt(
      (n - 1) /
      (
        1 -
        skew * sr +
        ((kurt - 1)/4) *
        sr^2
      )
    )

  return(dsr)
}
