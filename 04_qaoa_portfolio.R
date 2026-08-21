######################################################
# QAOA PORTFOLIO OPTIMIZATION
######################################################

library(reticulate)

qiskit_opt <- import("qiskit_optimization")
qiskit_alg <- import("qiskit_algorithms")

QuadraticProgram <- qiskit_opt$QuadraticProgram

MinimumEigenOptimizer <-
  import(
    "qiskit_optimization.algorithms"
  )$MinimumEigenOptimizer

Sampler <- import(
  "qiskit.primitives"
)$StatevectorSampler

COBYLA <- import(
  "qiskit_algorithms.optimizers"
)$COBYLA

QAOA <- qiskit_alg$QAOA

######################################################

qaoa_portfolio <- function(
  returns,
  k = 4,
  risk_aversion = 0.50,
  reps = 3
){

  mu <- colMeans(returns)

  covmat <- cov(returns)

  assets <- colnames(returns)

  n <- length(assets)

  qp <- QuadraticProgram()

  for(a in assets)
  {
    qp$binary_var(name=a)
  }

  linear <- dict()

  for(i in 1:n)
  {
    linear[[ assets[i] ]] <- -as.numeric(mu[i])
  }

  quadratic <- dict()

  for(i in 1:n)
  {
    for(j in 1:n)
    {

      quadratic[
        list(
          tuple(
            assets[i],
            assets[j]
          )
        )
      ] <- risk_aversion *
        covmat[i,j]

    }
  }

  qp$minimize(
    linear = linear,
    quadratic = quadratic
  )

  budget <- dict()

  for(a in assets)
  {
    budget[[a]] <- 1L
  }

  qp$linear_constraint(
    linear = budget,
    sense = "==",
    rhs = as.integer(k),
    name = "budget"
  )

  sampler <- Sampler()

  qaoa <- QAOA(
    sampler=sampler,
    optimizer=COBYLA(maxiter=250L),
    reps=as.integer(reps)
  )

  optimizer <-
    MinimumEigenOptimizer(qaoa)

  result <- optimizer$solve(qp)

  selection <- result$x

  names(selection) <- assets

  chosen <-
    names(selection)[
      round(selection)==1
    ]

  weights <-
    rep(
      0,
      length(selection)
    )

  names(weights) <- assets

  weights[chosen] <-
    1/length(chosen)

  list(
    weights=weights,
    assets=chosen,
    objective=result$fval
  )
}
`
