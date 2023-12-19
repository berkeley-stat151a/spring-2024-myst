---
title: "Syllabus"
---

This is only a tentative (example) syllabus!  The final syllabus will be distributed
at the start of the class.

# Syllabus

Jump to:

- [About Stat 151A](#about-stat-151A)
  - [Goals](#goals)
  - [Prerequisites](#prerequisites)


(about-stat-151A)=
# About Stat 151A


(goals)=
## Goals

To be able to:
1. Express standard regression analyses both mathematically and in R code
1. Critically relate the intended use of a regression analysis to its methods and assumptions
1. Identify common practical and conceptual pitfalls of regression analysis, and to improve the analysis when possible
1. Communicate the process and results of a regression analysis simply and clearly for a broad audience, using well-organized prose, reproducible code, and effective data visualizations.


## Some candidate topics

- Modes of inference:
	- Descriptive statistics / exploratory data analysis
	- Prediction
	- Parametric inference
		- Frequentist inference
		- Bayesian parametric inference / inverse problems

- Perspectives on linear regression
	- Linear algebra + projections
		- Inner products
		- Matrix inverses
		- Projections and subspaces
	- Maximum likelihood and Bayesian estimators
	- Empirical loss minimization
	- Special cases and extensions
		- ANOVA and one-hot encodings
		- Estimating equations
		- Nonlinear regression

- Common pitfalls of regression
	- Domain transfer
	- Gross errors and outliers
	- Collinearity
	- Model reification
	- Post-selection inference
	- Multiple testing
	- Model misspecification
		- Misspecified MLE
		- Biased error terms / omitted variables
		- Heteroskedasticity
		- Non-invariance under transforms

- Inferential tools
	- Bootstrap
	- Nonparametric asymptotics (sandwich)
	- Standard statistics and tests (t-test, F-test)
	- Grouping observations
	- Conformal prediction
	- Permutation testing

- Diagnostics
	- Plotting
		- QQ plots
		- Residual plots
		- Influence scores
	- Cross-validation and train / test split
	- Simulation

- Overparameterized methods
	- L2 regularization
	- Pseudo-inverse
	- Lasso
	- Feature expansions
		- Double descent


- Lecture: Visual diagnostics: residual plots, influence scores
- Lecture: Train / test splitting and cross-validation


(prerequisites)=
## Prerequisites

While we are working to make this class widely accessible, we currently require the following (or equivalent) prerequisites. **Prerequisites will be enforced in Stat 151A. It is your responsibility to know the material in the prerequisites.** 

