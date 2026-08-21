####################################################
# JOBSON KORKIE
####################################################

library(PairedData)

jobson_korkie <- function(
  r1,
  r2,
  rf = 0
){

  s1 <- SharpeRatio.annualized(
    r1,
    Rf = rf
  )

  s2 <- SharpeRatio.annualized(
    r2,
    Rf = rf
  )

  diff <- as.numeric(s1 - s2)

  test <- t.test(
    coredata(r1),
    coredata(r2)
  )

  list(
    sharpe1 = s1,
    sharpe2 = s2,
    pvalue = test$p.value
  )
}
