######################################################
# WALK FORWARD STUDY
######################################################

library(xts)
library(PerformanceAnalytics)

######################################################

portfolio_return_series <- function(
  returns,
  weights
){

  xts(
    as.numeric(
      returns %*%
      matrix(weights,ncol=1)
    ),
    order.by=index(returns)
  )
}

######################################################

walkforward_study <- function(
  returns,
  train_years=2
){

  all_dates <- index(returns)

  years <- unique(
    format(
      all_dates,
      "%Y"
    )
  )

  results <- list()

  counter <- 1

  for(i in seq(
    train_years+1,
    length(years)-1
  ))
  {

    train_start <- years[i-train_years]

    train_end <- years[i]

    test_year <-[i,jqiskit_algorithms.minimum_rns[
      paste0(
        train_start,
        "/",
        train_end
      )
    ]

    test <- returns[
      paste0(test_year)
    ]

    if(
      nrow(train)<100 ||
      nrow(test)<50
    )
    {
      next
    }

    ################################################
    # MARKOWITZ
    ################################################

    mu <- colMeans(train)

    covmat <- cov(train)

    inv_cov <- solve(covmat)

    w_m <-
      inv_cov %*% mu

    w_m <-
      as.vector(w_m)

    w_m <-
      pmax(w_m,0)

    w_m <-
      w_m/sum(w_m)

    ################################################
    # EQUAL
    ################################################

    w_eq <-
      rep(
        1/ncol(train),
        ncol(train)
      )

    ################################################
    # QAOA
    ################################################

    qaoa_res <-
      qaoa_portfolio(
        train,
        k=4
      )

    ################################################
    # VQE
    ################################################

    vqe_res <-
      vqe_portfolio(
        train,
        k=4
      )

    ################################################
    # TEST RETURNS
    ################################################

    markowitz_test <-
      portfolio_return_series(
        test,
        w_m
      )

    equal_test <-
      portfolio_return_series(
        test,
        w_eq
      )

    qaoa_test <-
      portfolio_return_series(
        test,
        qaoa_res$weights
      )

    vqe_test <-
      portfolio_return_series(
        test,
        vqe_res$weights
      )

    ################################################

    results[[counter]] <- list(

      train_period=
        paste(
          train_start,
          train_end
        ),

      test_period=test_year,

      markowitz=markowitz_test,

      equal=equal_test,

      qaoa=qaoa_test,

      vqe=vqe_test,

      qaoa_assets=
        qaoa_res$assets,

      vqe_assets=
        vqe_res$assets

    )

    counter <- counter + 1

  }

  return(results)

}
