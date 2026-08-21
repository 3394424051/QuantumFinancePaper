outperform_probability <- function(
  strategy,
  benchmark
){

  mean(
    rowMeans(strategy) >
    rowMeans(benchmark)
  )

}
