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

## Course outline
- Week 1
	- Lecture: Why study linear models?  Class goals and organization.
	- Lecture: Simple regression as EDA, prediction, and inference
- Week 2
	- Lecture: Linear algebra review: matrix inverses and projections
	- Lecture: Probability review: consistency, unbiasedness, CLT
- Week 3
	- Lecture: Multivariate regression as maximum likelihood estimation
	- Lecture: ANOVA: categorical predictors and one-hot encoding
- Week 4
	- Lecture: Multivariate regression as empirical risk minimization.  Train / test split.
	- Lecture: Basis expansions and regularization
- Week 5
	- Lecture: Frequentist inference: level, power, testing, and confidence intervals
	- Lecture: Grouping data in the bootstrap
- Week 6
	- Lecture: Asymptotics of empirical risk minimization: sandwich covariance
	- Lecture: Conformal inference for prediction
- Week 7
	- Lecture: How regression fails: Omitted variables, endogeneity
	- Lecture: How regression fails: Domain adaptation, outliers
- Week 8
	- Lecture: How regression fails: Model reification
	- Lecture: Midterm review
- Week 9
	- Lecture: Binary regression for prediction
	- Lecture: Binary regression for inference
- Week 10
	- Lecture: Bayesian inference: multivariate normal
	- Lecture: Bayesian inference: regression and shrinkage
- Week 11:
  - Spring break
- Week 12
	- Lecture: Variable selection: collinearity and shrinkage
	- Lecture: Variable selection: LASSO and post-selection inference
- Week 13
	- Lecture: Basis expansions: Bias and variance 
	- Lecture: Basis expansions: Interpolation and double descent 
- Week 14
	- Lecture: Cross-validation
	- Lecture: Permutation testing

(prerequisites)=
## Prerequisites

While we are working to make this class widely accessible, we currently require the following (or equivalent) prerequisites. **Prerequisites will be enforced in Stat 151A. It is your responsibility to know the material in the prerequisites.** 

