% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/multiness_sim.R
\name{multiness_sim}
\alias{multiness_sim}
\title{Simulate from the MultiNeSS model}
\usage{
multiness_sim(n,m,d1,d2,model,sigma,self_loops,opts)
}
\arguments{
\item{n}{A positive integer, the number of nodes.}

\item{m}{A positive integer, the number of layers.}

\item{d1}{A non-negative integer, the number of common latent dimensions.}

\item{d2}{A non-negative integer, the number of individual latent dimensions.}

\item{model}{A string which provides choice of model,
either \code{'gaussian'} or \code{'logistic'}. Defaults to \code{'gaussian'}.}

\item{sigma}{A positive scalar or numeric vector of length \code{m},
the entry-wise standard deviation for the Gaussian noise for all layers
(if a scalar) or for each layer (if a vector). Ignored under the logistic
model. Defaults to \code{1}.}

\item{self_loops}{A Boolean, if \code{FALSE}, all diagonal entries are set
to zero. Defaults to \code{TRUE}.}

\item{opts}{A list, containing additional optional arguments:
\describe{
\item{density_shift}{A positive scalar, for the logistic model only, a shift
subtracted from the log-odds of each edge to control overall edge density. Defaults to \code{0}.}
\item{dependence_type}{A string, valid choices are \code{'all'} or
\code{'U_only'} for the Gaussian model; \code{'all'} for the logistic
model. If \code{'all'}, \eqn{V} and \eqn{U_k}; and \eqn{U_k} and \eqn{U_l}
(for \eqn{k \neq l}) have expected canonical correlation approximately equal to
|\eqn{rho}| (see \code{rho}).
If \code{'U_only'}, \eqn{U_k} and \eqn{U_l} (for \eqn{k \neq l}) have expected
canonical correlation approximately equal to |\eqn{rho}| (see \code{rho}).
Defaults to \code{'all'}.}
\item{gamma}{A positive scalar, the standard deviation of the entries of
the latent position matrices \eqn{V} and \eqn{U_k}. Defaults to \code{1}.}
\item{return_density}{A Boolean, if \code{TRUE} and \code{model='logistic'}, the function will return an array containing
the overall edge density. Defaults to \code{FALSE}.}
\item{return_P}{A Boolean, if \code{TRUE}, the function will return an array containing
the expected adjacency matrices. Defaults to \code{FALSE}.}
\item{rho}{A positive scalar in the interval (-1,1), controls the expected canonical
correlation between latent position matrices (see \code{dependence_type}).
Defaults to \code{0}.}
}}
}
\value{
A list is returned with the realizations of the latent dimensions
and the multiplex network:
\item{A}{An array of dimension \eqn{n \times n \times m}, the realized
multiplex network.}
\item{V}{A matrix of dimension \eqn{n \times d1}, the realized common
latent positions. If \code{d1=0}, returns \code{NULL}.}
\item{U}{An array of dimension \eqn{n \times d2 \times m}, the realized
individual latent positions. If \code{d2=0}, returns \code{NULL}.}
\item{P}{If specified, an array of dimension \eqn{n \times n \times m}, the expected
multiplex network.}
\item{density}{If specified and \code{model='logistic'}, the overall edge density.}
}
\description{
\code{multiness_sim} simulates a realization of the Gaussian
or logistic MultiNeSS model with Gaussian latent positions.
}
\details{
The common and individual latent positions, \eqn{V} and \eqn{U_k}
respectively, are generated as
Gaussian random variables with standard deviation \code{opts$gamma}, and
dependence controlled by the optional
arguments \code{opts$dependence_type} and \code{opts$rho}.

Under the Gaussian model, the \eqn{n \times n} adjacency matrix for layer \eqn{k=1,...,m}
has independent Gaussian entries with standard deviation \code{sigma} and
mean given by
\deqn{E(A_k) = VV^{T} + U_kU_k^{T}.}

Under the logistic model, the \eqn{n \times n} adjacency matrix for layer \eqn{k=1,...,m}
has independent Bernoulli entries with mean given by
\deqn{E(A_k) = g(VV^{T} + U_kU_k^{T}),}
where \eqn{g} denotes the element-wise application of the inverse logistic
link (\code{\link{expit}}) function. Under both models, \code{self_loops} provides
an option to set the diagonal entries of the adjacency matrices to zero.
}
\examples{
# gaussian model, uncorrelated latent positions
data1 <- multiness_sim(n=100,m=4,d1=2,d2=2,
                      model="gaussian")

# logistic model, correlated latent positions
data2 <- multiness_sim(n=100,m=4,d1=2,d2=2,
                       model="logistic",
                       self_loops=FALSE,
                       opts=list(dependence_type="all",rho=.3,return_density=TRUE))

}
