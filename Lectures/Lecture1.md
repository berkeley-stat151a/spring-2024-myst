---
title: "Lecture 1"
jupytext:
  formats: md:myst
  text_representation:
    extension: .md
    format_name: myst
math:
  '\X': '\tilde{X}'
  '\Y': '\tilde{Y}'
  '\x': 'x'
  '\z': 'z'
  '\xv': '\tilde{x}'
  '\y': 'y'
  '\r': '\varepsilon'
  '\rv': '\tilde{\varepsilon}'
  '\bv': '\tilde{\beta}'
  '\new': '\mathrm{new}'
  '\trans': '^{\top}'
kernelspec:
  display_name: R
  language: R
  name: R
execute:
  execute_notebooks: force
---


# Some guiding principles

This is a course about linear models.  You probably all know what linear models
are already --- in short, they are models which fit straight lines through data,
possibly high-dimensional data.   Every setting we consider in this class will
have the following attributes:
- A bunch of data points.  We'll index with $n = 1, \ldots, N$.
- Each datapoint consists of:
  - A "response" $y_n$
  - A "regressor" $\xv_n = (\x_{n1}, \ldots, \x_{nP})$.

We will be interested in what $\xv_n$ can tell us about $\y_n$. This setup is
called a "regression problem," and can be attacked with lots of models,
including non-linear modles.  But we will focus on approaches to this problem
that operate via fitting straight lines to the dependence of
$y_n$ on $\xv_n$.

Relative to a lot of other machine learning or statistical procedures, linear
models are relatively easy to analyze and understand.  Yet they are also complex
enough to exhibit a lot of the strengths and pitfalls of all machine learning
and statistics.  So really, this is only partly a course about linear models
*per se*.  I hope to make it a course about concepts in statistics in machine
learning more generally, but viewed within the relatively simple framework of
linear models.  Some examples (not all of which will be covered, probably)
include:
- The bias / variance tradeoff
- The influence function
- Domain transfer
- Post selection inference
- Multiple testing
- Consistency and asymptotic normality
- Distributed learning
- Regularization
- Sparsity
- Benign overfitting and double descent


Our results and conclusions will be expressed in formal mathematical statements
and in software.  For the purpose of this class, I view mathematics and coding
as analogous to language, grammar, and style: you need to have a command of
these things in order to say something.  But the content of this course doesn't
stop and math and conding, just as learning language alone does not give you
something to say. Linear models will be a mathematical and computational tool
for communicating with and about the real world.  Datasets can speak to us in
the language of linear models, and we can communicate with other humans through
the language of linear models.  Learning to communicate effectively in this way
is the most important content of this course, and is a skill that will remain
relevent whether or not you ever interpret or fit another linear model in your
life.

Whether or not a statistical analysis is "good" cannot be evaluated outside a
particular context.  Why do we care about the conclusions of this analysis? What
will they be used for?  Who needs to understand our analysis?  What are the
consequences of certain kinds of errors?   Outside of a classroom, you will
probably never encounter a linear model without a real question and context
attached to it.  I will make a real effort in this class to respect this fact,
and always present data in context, to the extent possible within a classroom
setting.  I hope you will in turn get in the habit of always thinking about the
context of a problem, even when going through formal homework and lab exercises.
For pedagogical reasons we may have to step into abstract territory at times,
but I will make an effort to tie what we learn back to reality, and, in grading
we'll make sure to reward your efforts to do so as well.  Just as there is not a
"correct" essay in an English class, this will often mean that there are not
"correct" analyses for a dataset, even though there are certainly better and
worse approaches, as well as unambiguous errors.



# Some examples of three classes of analyses

See the [Lecture 1 notebook](Lecture1.ipynb).

This course will use the following (coarse) taxonomy of tasks:

## Exploratory data analysis
  - **Spotify example**
  - EDA is part of every project (start by plotting your data)
  - Often a starting point for more detailed analyses
  - Anything goes, but correpsondingly the results may not be that meaningful
  - Helpful to have a formal understanding of what regression is doing
  - Linear algebra perspective
## Prediction problems
  - **Bodyfat example**
  - Have some pairs of responses and explanatory variables
  - Given new explanatory variables, we want a "best guess" for an unseen response
  - We care about how our model fits the data we have, and how it extrapolates
  - The model itself (i.e., the slopes of the fitted line) doesn't have much
    meaning
  - Care about uncertainty in and calibration of our prediction
  - Loss minimization perspective
## Inference problems
  - **Aluminum stress-strain curve example**
  - We have a question about the world that can't be expressed as pure prediction
  - Sometimes we "reify" our model, even if tentatively
  - Sometimes has a causal intepretation: if we intervene in some aspect of the world, what will happen?
  - We need some notion of the subjective uncertainty of our estimates
  - Maximum likelihood perspective

  These perspectives are highly overlapping, and often a problem doesn't fit
  neatly into one or the other.  For example, good inference should give good
  predictions, and inference in a very tentatively reified model is close to
  exploratory data analysis.  Still, I'll lean on this division to help organize
  the course conceptually.



## Linear models and matrix notation

Here is a formal definition of the type of model that we will study for the vast
majority of the semester:


```{math}
:label: lm-scalar
\begin{align*}
\y_n ={}& \beta_1 \x_{n1} + \beta_2 \x_{n2} + \ldots + \x_{nP} + \r_{n}, \quad\textrm{For }n=1,\ldots,N.
\end{align*}
```

Equation {eq}`lm-scalar` is a general form of simpler cases.  For example,
if we take $\x_{n1} \equiv 1$, $\x_{n2}= \z_n$ to be some scalar, and $P = 2$, then
{eq}`lm-scalar` becomes the straight line
\begin{align*}
\y_n ={}& \beta_1  + \beta_2 \z_{n} + \r_{n}, \quad\textrm{For }n=1,\ldots,N.
\end{align*}

The residuals $\r_n$ measure the "misfit" of the line.  If you know $\beta_1, \ldots, \beta_P$,
then you can compute

\begin{align*}
\r_n ={}& \y_n -  (\beta_1 \x_{n1} + \beta_2 \x_{n2} + \ldots + \x_{nP}).
\end{align*}

But in general we only observe $\y_n$ and $\x_{n1}, \ldots, \x_{nP}$, and we
choose $\beta_1, \ldots, \beta_P$ to make the residuals small.  (How we do
this precisely will be something we talk about at great length.)


The general form of equation {eq}`lm-scalar` can be written more compactly using
matrix and vector notation. Specifically, if we let

\begin{align*}
\xv_n := 
\begin{pmatrix}
  \x_{n1} \\ \x_{n2} \\ \vdots \\ \x_{nP}
\end{pmatrix}
\quad
\textrm{and}
\quad
\bv := 
\begin{pmatrix}
  \beta_{1} \\ \beta_2 \\ \vdots \\ \beta_{P}
\end{pmatrix}
\end{align*}

then by matrix multiplication rules,

\begin{align*}
\xv_n \trans \bv = 
\begin{pmatrix}
  \x_{n1} & \x_{n2} & \ldots & \x_{nP}
\end{pmatrix}
\begin{pmatrix}
  \beta_{1} \\ \beta_2 \\ \vdots \\ \beta_{P}
\end{pmatrix}
= \beta_1 \x_{n1} + \beta_2 \x_{n2} + \ldots + \x_{nP}.
\end{align*}

Then we can compactly write

\begin{align*}
\y_n ={}& \xv_n \trans \bv + \r_{n}, \quad\textrm{For }n=1,\ldots,N.
\end{align*}

We can compactify it even further if we stack the $n$ observations:
%
\begin{align*}
\y_1 ={}& \xv_1 \trans \bv + \r_{1} \\
\y_2 ={}& \xv_2 \trans \bv + \r_{2} \\
\vdots\\
\y_N ={}& \xv_N \trans \bv + \r_{N} \\
\end{align*}

As before we can stack the responses and residuals:

\begin{align*}
\Y := 
\begin{pmatrix}
  \y_{1} \\ \y_2 \\ \vdots \\ \y_{P}
\end{pmatrix}
\quad
\textrm{and}
\quad
\rv := 
\begin{pmatrix}
  \r_{1} \\ \r_2 \\ \vdots \\ \r_{P}
\end{pmatrix}
\end{align*}

We can also stack the regressors:

\begin{align*}
\X := 
\begin{pmatrix}
  \x_{11} & \x_{12} & \ldots & \x_{1P}\\
  \x_{21} & \x_{22} & \ldots & \x_{2P}\\
  \vdots\\
  \x_{n1} & \x_{n2} & \ldots & \x_{nP}\\
  \vdots\\
    \x_{N1} & \x_{N2} & \ldots & \x_{NP}
\end{pmatrix}
=
\begin{pmatrix}
  \xv_{1}\trans \\ \xv_{2}\trans \\ \vdots \\ \xv_n\trans \\ \vdots \\ \xv_{N}\trans
\end{pmatrix}
\end{align*}

Note that by matrix multiplication rules,

\begin{align*}
\X  \bv = 
\begin{pmatrix}
  \xv_{1}\trans \\ \xv_{2}\trans \\ \vdots \\ \xv_n\trans \\ \vdots \\ \xv_{N}\trans
\end{pmatrix}
\bv
=
\begin{pmatrix}
  \xv_{1}\trans\bv \\ \xv_{2}\trans\bv \\ \vdots \\ \xv_n\trans\bv \\ \vdots \\ \xv_{N}\trans\bv
\end{pmatrix}
\end{align*}

so we end up with the extremely tidy expression

\begin{align*}
\y_n ={}& \beta_1 \x_{n1} + \beta_2 \x_{n2} + \ldots + \x_{nP} + \r_{n}, \quad\textrm{For }n=1,\ldots,N
\\\\&\textrm{is the same as}\quad\\\\
\Y ={}& \X \bv + \rv.
\end{align*}









