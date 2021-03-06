% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Pred.R
\name{Pred}
\alias{Pred}
\alias{Pred.MSGARCH_SPEC}
\alias{Pred.MSGARCH_ML_FIT}
\alias{Pred.MSGARCH_MCMC_FIT}
\title{Predictive density.}
\usage{
Pred(object, ...)

\method{Pred}{MSGARCH_SPEC}(object, x = NULL, par = NULL, data = NULL,
  log = FALSE, do.its = FALSE, n.ahead = 1L, ctr = list(), ...)

\method{Pred}{MSGARCH_ML_FIT}(object, x = NULL, new.data = NULL,
  log = FALSE, do.its = FALSE, n.ahead = 1L, ctr = list(), ...)

\method{Pred}{MSGARCH_MCMC_FIT}(object, x = NULL, new.data = NULL,
  log = FALSE, do.its = FALSE, n.ahead = 1L, ctr = list(), ...)
}
\arguments{
\item{object}{Model specification of class \code{MSGARCH_SPEC} created with \code{\link{CreateSpec}}
or fit object of type \code{MSGARCH_ML_FIT} created with \code{\link{FitML}} or \code{MSGARCH_MCMC_FIT}
created with \code{\link{FitMCMC}}.}

\item{...}{Not used. Other arguments to \code{Pred}.}

\item{x}{Vector (of size n). Used when \code{do.its = FALSE}.}

\item{par}{Vector (of size d) or matrix (of size \code{n.mcmc} x d) of parameter
estimates where d must have the same length as the default parameters of the specification.}

\item{data}{Vector (of size T) of observations.}

\item{log}{Logical indicating if the log-density is returned. (Default: \code{log = FALSE})}

\item{do.its}{Logical indicating if the in-sample predictive is returned. (Default: \code{do.its = FALSE})}

\item{n.ahead}{Scalar indicating the number of step-ahead evaluation.
Valid only when \code{do.its = FALSE}. (Default: \code{n.ahead = 1L})}

\item{ctr}{A list of control parameters:
\itemize{
\item \code{n.sim} (integer >= 0) :
Number indicating the number of simulation done for the evaluation
of the density at \code{n.ahead} > 1. (Default: \code{n.sim = 10000L})
}}

\item{new.data}{Vector (of size T*) of new observations. (Default \code{new.data = NULL})}
}
\value{
A vector or matrix of class \code{MSGARCH_PRED}.\cr
If \code{do.its = FALSE}: (Log-)predictive of
the points \code{x} at \code{t = T + T* + 1, ... ,t = T + T* + n.ahead} (matrix of
size \code{n.ahead} x n).\cr
If \code{do.its = TRUE}: In-sample predictive of \code{data} if \code{x = NULL}
(vector of size T + T*) or in-sample predictive of \code{x} (matrix of size (T + T*) x n).
}
\description{
Method returning the predictive probability density.
}
\details{
If a matrix of MCMC posterior draws is given, the Bayesian
predictive probability density  is calculated.
Two or more step-ahead predictive probability density are estimated via simulation of \code{n.sim} paths up to
 \code{t = T + T* +  n.ahead}. The predictive distribution are then inferred from these
 simulations via a Gaussian Kernel density.
If \code{do.its = FALSE}, the vector \code{x} are evaluated as \code{t = T + T* + 1, ... ,t = T + T* + n.ahead}
realization.\cr
If \code{do.its = TRUE} and  \code{x} is evaluated
at each time \code{t} up top time \code{t = T + T*}.\cr
Finally, if \code{x = NULL} the vector \code{data} is evaluated for sample evaluation of the predictive denisty ((log-)likelihood of each sample points).
}
\examples{
# load data
data("SMI", package = "MSGARCH")

# create model specification
# MS(2)-GARCH(1,1)-Normal (default)
spec <- CreateSpec()

# fit the model on the data by ML
fit <- FitML(spec = spec, data = SMI)

# run Pred method in-sample
pred.its <- Pred(object = fit, log = TRUE, do.its = TRUE)

# create a mesh
x <- seq(-3,3,0.01)

# run pred method on mesh at T + 1
pred.x <- Pred(object = fit, x = x, log = TRUE, do.its = FALSE)
}
