####################################################
# WHITE REALITY CHECK
####################################################

white_reality_check <- function(
  benchmark,
  strategy,
  nboot = 10000
){

  diff_ret <-
    strategy -
    benchmark

  observed <-
    mean(diff_ret)

  boot_means <-
    numeric(nboot)

  for(i in 1:nboot)
  {

    idx <- sample(
      1:length(diff_ret),
      replace = TRUE
    )

    boot_means[i] <-
      mean(
        diff_ret[idx]
      )

  }

  pvalue <-
    mean(
      boot_means >= observed
    )

  list(
    observed = observed,
    pvalue = pvalue
  )

}
