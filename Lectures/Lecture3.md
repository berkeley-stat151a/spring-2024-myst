---
title: "Lecture 3: Linear algebra review. Matrix inverses, square roots, projections"
jupytext:
  formats: md:myst
  text_representation:
    extension: .md
    format_name: myst
math:
  '\X': '\bm{X}'
  '\Y': '\bm{Y}'
  '\x': 'x'
  '\z': 'z'
  '\xv': '\bm{x}'
  '\y': 'y'
  '\r': '\varepsilon'
  '\rv': '\bm{\varepsilon}'
  '\bv': '\bm{\beta}'
  '\new': '\mathrm{new}'
  '\trans': '^{\top}'
kernelspec:
  display_name: R
  language: R
  name: R
execute:
  execute_notebooks: force
---


## Linear algebra review



## Linear models and matrix notation

Here is a formal definition of the type of model that we will study for the vast
majority of the semester:


```{math}
:label: lm-scalar
\begin{align*}
\y_n ={}& \beta_1 \x_{n1} + \beta_2 \x_{n2} + \ldots + \x_{nP} + \r_{n}, \quad\textrm{For }n=1,\ldots,N.
\end{align*}
```

```{tip} Notation
I will always use $N$ for the number of observed data points, and $P$ 
for the dimension of the regression vector.
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

```{tip} Notation
Bold lowercase variables are column vectors (unless otherwise specified).
```

Recall that the "transpose" operator $(\cdot)\trans$ flips the row and
columns of a matrix.  For example,

\begin{align*}
\xv_n \trans = 
\begin{pmatrix}
  \x_{n1} & \x_{n2} & \ldots & \x_{nP}
\end{pmatrix}.
\end{align*}

By matrix multiplication rules,

\begin{align*}
\xv_n\trans \bv = 
\begin{pmatrix}
  \x_{n1} & \x_{n2} & \ldots & \x_{nP}
\end{pmatrix}
\begin{pmatrix}
  \beta_{1} \\ \beta_2 \\ \vdots \\ \beta_{P}
\end{pmatrix}
= \beta_1 \x_{n1} + \beta_2 \x_{n2} + \ldots + \x_{nP}.
\end{align*}

```{tip} Notation
I have written $\xv_n\trans \bv$ for the "dot product" or "inner product"
between $\xb_n$ and $\bv$.  Writing it in this way clarifies the relationship
with matrix notation below.

There are many other ways to denote inner products in the literature,
including $\xv_n \cdot \bv$ and $<\xv_n, \bv>$.
```

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

```{tip} Notation
I will use upper case bold letters for multi-dimensional matrices like $\X$.  But
I may also use upper case bold letters even when the quantity could also be
a column vector, when I think it's more useful to think of the quantity
as a matrix with a single column.  Examples are $\Y$ above, or $\X$ when $P = 1$.
```

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









