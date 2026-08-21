load("results/prepared.RData")

years <- sort(
  unique(
    format(index(returns),"%Y")
  )
)

walk_results <- list()

for(i in 3:(length(years)-1))
{

  train_end <- years[i]

  train <- returns[
    paste0("/",train_end)
  ]

  test <- returns[
    paste0(
      years[i+1]
    )
  ]

  # ricalcolo pesi

  # markowitz

  # BL

  # QAOA

  # VQE

  # applicazione a test

}
