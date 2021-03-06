% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functions.R
\name{bgzip}
\alias{bgzip}
\title{bgzip}
\usage{
bgzip(...)
}
\arguments{
\item{...}{Path to input vcf to compress with bgzip}
}
\description{
Run bgzip
}
\details{
Find more help online \url{https://github.com/stephenturner/om..bcftools}.
}
\examples{
library(outsider)
bcftools <- module_import('bcftools', repo = 'stephenturner/om..bcftools')
bcftools('-h')  # or --help or whichever argument prints help
}
