######################################################
# VQE PORTFOLIO OPTIMIZER
######################################################

library(reticulate)

qiskit_opt <- import("qiskit_optimization")

QuadraticProgram <-
  qiskit_opt$QuadraticProgram

MinimumEigenOptimizer <-
  import(
    "qiskit_optimization.algorithms"
  )$MinimumEigenOptimizer

VQE <-
  import(
    "qiskit_algorithms.minimum_eigensolvers"
  )$VQE

COBYLA <-
  import(
    "qiskit_algorithms.optimizers"
  )$COBYLA

Estimator <-
  import(
    "qiskit.primitives"
  )$StatevectorEstimator

RealAmplitudes <-
  import(
    "qiskit.circuit.library"
  )$RealAmplitudes

######################################################

vqe_portfolio <- function(
  returns,
  k=4,
  risk_aversion=0.50,
  reps=3
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
    linear[[assets[i]]] <-
      -as.numeric(mu[i])
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
      ] <-
        risk_aversion *
        covmat[i,j]

    }
  }

  qp$minimize(
    linear=linear,
    quadratic=quadratic
  )

  budget <- dict()

  for(a in assets)
  {
    budget[[a]] <- 1L
  }

  qp$linear_constraint(
    linear=budget,
    sense="==",
    rhs=as.integer(k),
    name="budget"
  )

  ansatz <-
    RealAmplitudes(
      num_qubits=n,
      reps=as.integer(reps)
    )

  estimator <- Estimator()

  vqe <- VQE(
    estimator=estimator,
    ansatz=ansatz,
    optimizer=COBYLA(
      maxiter=500L
    )
  )

  optimizer <-
    MinimumEigenOptimizer(vqe)

  result <- optimizer$solve(qp)

  selection <- result$x

  names(selection) <- assets

  chosen <-
    names(selection)[
      round(selection)==1
    ]

  weights <- rep(
    0,
    n
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
