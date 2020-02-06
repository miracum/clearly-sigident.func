# sigident.func (!!! currently under development !!!)

<!-- badges: start -->
[![pipeline status](https://gitlab.miracum.org/clearly/sigident.func/badges/master/pipeline.svg)](https://gitlab.miracum.org/clearly/sigident.func/commits/master)
[![coverage report](https://gitlab.miracum.org/clearly/sigident.func/badges/master/coverage.svg)](https://gitlab.miracum.org/clearly/sigident.func/commits/master)
<!-- badges: end -->

This is the repository of the R package `sigident.func`. It provides functional analysis and is part of the sigident package framework: [https://gitlab.miracum.org/clearly/sigident](https://gitlab.miracum.org/clearly/sigident)

# Overview 

The functional analysis includes the following steps:  
* DEG analysis  
* Gene enrichment  
* Test for over-representation  
* GO enrichment analysis

# Installation

You can install *sigident.func* with the following commands in R:

``` r
options('repos' = 'https://ftp.fau.de/cran/')
install.packages("devtools")
devtools::install_git("https://gitlab.miracum.org/clearly/sigident.func.git")
```

# Example: 

# Caution 

The *sigident.func* package is under active development and not on CRAN yet - this means, that from time to time, the API can break, due to extending and modifying its functionality. It can also happen, that previoulsy included functions and/or function arguments are no longer supported. 
However, a detailed package vignette will be provided alongside with every major change in order to describe the currently supported workflow.
