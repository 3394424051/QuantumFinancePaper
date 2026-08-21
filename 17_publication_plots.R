# EQUITY CURVE

charts.PerformanceSummary(
 cbind(
  qqq,
  equal,
  markowitz,
  bl,
  qaoa,
  vqe
 )
)


# Rolling Sharpe
chart.RollingPerformance(
 qaoa,
 width = 126,
 FUN = "SharpeRatio"
)


#  Drawdown
chart.Drawdown(
 cbind(
  markowitz,
  bl,
  qaoa,
  vqe
 )
)

#Efficient Frontier
chart.EfficientFrontier(
 markowitz_object
)

# Risk-Return Scatter
plot(
 vol_vector,
 ret_vector
)
#
