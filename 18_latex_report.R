library(knitr)
library(kableExtra)

kable(
 final_results,
 format="latex",
 digits=4,
 caption=
 "Performance Comparison"
)
