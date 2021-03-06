% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/enrichment.R
\name{extract_go_terms}
\alias{extract_go_terms}
\title{extract_go_terms}
\usage{
extract_go_terms(gene, species, fdr = NULL)
}
\arguments{
\item{gene}{A character vector containing the Entrez-IDs.}

\item{species}{A character string indicating the sample's species.
Currently supported: "Hs".}

\item{fdr}{The false discovery rate passed to `limma::goana`.}
}
\description{
Helper function to extract GO terms
}
