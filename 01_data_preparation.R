library(xts)
library(zoo)
library(PerformanceAnalytics)

df <- read.csv2(
  "data/Quantum_dataset.csv",
  dec=","
)

df$Date <- as.Date(
  df$Date,
  format="%d/%m/%Y"
)

prices <- xts(
  df[, -1],
  order.by=df$Date
)

returns <- na.omit(
  Return.calculate(prices)
)

save(
  prices,
  returns,
  file="results/prepared.RData"
)
