% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/deprecated.R
\name{MizerParams}
\alias{MizerParams}
\title{Alias for set_multispecies_model}
\usage{
MizerParams(
  species_params,
  interaction = matrix(1, nrow = nrow(species_params), ncol = nrow(species_params)),
  min_w_pp = 1e-10,
  min_w = 0.001,
  max_w = max(species_params$w_inf) * 1.1,
  no_w = 100,
  n = 2/3,
  q = 0.8,
  f0 = 0.6,
  kappa = 1e+11,
  lambda = 2 + q - n,
  r_pp = 10,
  ...
)
}
\arguments{
\item{species_params}{A data frame of species-specific parameter values.}

\item{interaction}{Optional interaction matrix of the species (predator
species x prey species). Entries should be numbers between 0 and 1. By
default all entries are 1. See "Setting interactions" section below.}

\item{min_w_pp}{The smallest size of the resource spectrum. By default this
is set to the smallest value at which any of the consumers can feed.}

\item{min_w}{Sets the size of the eggs of all species for which this is not
given in the \code{w_min} column of the \code{species_params} dataframe.}

\item{max_w}{The largest size of the consumer spectrum. By default this is
set to the largest \code{w_inf} specified in the \code{species_params} data
frame.}

\item{no_w}{The number of size bins in the consumer spectrum.}

\item{n}{The allometric growth exponent. This can be overruled for individual
species by including a \code{n} column in the \code{species_params}.}

\item{q}{Allometric exponent of search volume}

\item{f0}{Expected average feeding level. Used to set \code{gamma}, the
coefficient in the search rate. Ignored if \code{gamma} is given
explicitly.}

\item{kappa}{Coefficient of the intrinsic resource carrying capacity}

\item{lambda}{Scaling exponent of the intrinsic resource carrying capacity}

\item{r_pp}{Coefficient of the intrinsic resource birth rate}

\item{...}{Unused}
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}
An alias provided for backward compatibility with mizer version <= 1.0
}
\concept{deprecated}
