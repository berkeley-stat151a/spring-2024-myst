---
title: "Lecture 1"
jupytext:
  formats: md:myst
  text_representation:
    extension: .md
    format_name: myst
math:
  '\trans': '^\mathsf{T}'
  '\X': '\tilde{X}'
  '\Y': '\tilde{Y}'
  '\x': 'x'
  '\xv': '\tilde{x}'
  '\y': 'y'
  '\r': '\varepsilon'
  '\rt': '\tilde{\varepsilon}'
  '\bt': '\tilde{\beta}'
  '\new': '\mathrm{new}'
exports:
  - format: pdf
    template: ../templates/latex_beamer_pure_minimalistic_mystjs/
    output: Lecture1.pdf
    dark_mode: false
    outline: false
    no_footer_logo: true
#settings:
#  myst_to_tex:
#    beamer: true
---


# What do we want to convey?

## Some examples

Here are some types of tasks.


```{code-cell} R
library(tidyverse)
library(gridExtra)
library(car)

setwd("/home/rgiordan/Documents/git_repos/stat151a-spring-2024")
```

### Exploratory data analysis
  - Spotify

### Prediction
  - Bodyfat

### Inference
  - Aluminum

```{code} R
:name: R example
:caption: fizz_buzz definition in R
fizz_buzz <- function(fbnums = 1:50) {
  output <- dplyr::case_when(
    fbnums %% 15 == 0 ~ "FizzBuzz",
    fbnums %% 3 == 0 ~ "Fizz",
    fbnums %% 5 == 0 ~ "Buzz",
    TRUE ~ as.character(fbnums)
  )
  print(output)
}

fizz_buzz(3)
```

## Regression models in general

These tasks all have the following attributes:

- A bunch of data points.  We'll index with $n = 1, \ldots, N$.
- Each datapoint consists of:
  - A "response" $y_n$
  - A "regressor" $\xv_n = (\x_1, \ldots, \x_P)$.

We are interested in what $\xv_n$ can tell us about $\y_n$.

- Spotify
  - Is there any interesting relationship between $\xv_n$ and $\y_n$?  If $P$ is large
    then simply making pictures might not be enough.
- Bodyfat
  - Imagine we see some new $\xv_{\new}$ but not $\y_{\new}$.  Can we make a good guess?
- Aluminum
  - Something about the relationship between $\xv_{n}$ and $\y_n$ tells us something
    about the world that extends beyond the current dataset, and beyond simple
    prediction.


## Linear models

All of the above questions can and are attacked with a variety of tools.  But
there is one class of models that strikes a remakable balance between
efficacy and simplicity, and those are linear models.

Here is the type of model that we will study for the vast majority of the semester:

\begin{align*}
\y_n ={}& \beta_0 + \beta_1 \x_{1n} + \beta_2 \x_{2n} + \ldots + \r_{n}, \quad\textrm{For }n=1,\ldots,N
\end{align*}


## Why linear models

Linear models are easy to compute and to understand formally.

But they can be very challenging to interpret directly.

For this reason, they are a gateway to deeper understanding of statistics in general.

Many deep and general statistical phenomena have their origin or a particularly
clear expression in linear models, like:
- The bias / variance tradeoff
- The influence function
- Domain transfer
- More recently, benign overfitting
- Post selection inference
- Multiple testing
- Regularization
- Sparsity









