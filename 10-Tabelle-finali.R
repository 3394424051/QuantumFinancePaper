final_table <- rbind(

  compute_stats(qqq_returns),

  compute_stats(equal_returns),

  compute_stats(markowitz_returns),

  compute_stats(bl_returns),

  compute_stats(qaoa_returns),

  compute_stats(vqe_returns)

)

write.csv(
  final_table,
  "results/final_results.csv"
)
