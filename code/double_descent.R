library(tidyverse)

GetFourierFeature <- function(a) {
  at <- t(as.matrix(a))
  stopifnot(nrow(a) == 1)
  
  EvalPhi <- function(x) {
    stopifnot(is.null(dim(x)))
    x_mod <- 2 * pi * matrix(x, ncol=1) %*% at
    cx <- data.frame(cos(x_mod))
    sx <- data.frame(sin(x_mod))
    names(cx) <- paste0("C", 1:ncol(at))
    names(sx) <- paste0("S", 1:ncol(at))
    return(cbind(cx, sx))
  }
  return(EvalPhi)
}


n_obs <- 50

p_true <- 100
TruePhi <- GetFourierFeature(seq(1, p_true))
decay <- 0.1
wavenumber <- (1:p_true)
decay  <- 1.5
bc_true <- rnorm(p_true) / (wavenumber^decay)
bs_true <- rnorm(p_true) / (wavenumber^decay)
x_grid <- seq(0, 1, length.out=n_obs)
phi_grid <- TruePhi(x_grid) %>% as.matrix()
y <- phi_grid %*% c(bc_true, bs_true)

if (FALSE) {
  plot(x_grid, y, 'l')
}

nf <- 200
a <- rnorm(nf)
GetPhi <- GetFourierFeature(a)
phi <- GetPhi(x_grid)
features <- colnames(phi)
phi <- phi %>% mutate(y=y, x=x_grid)
reg_form <- formula(sprintf("y ~ -1 + %s", paste0(features, collapse=" + ")))
reg <- lm(reg_form, phi)
err <- sum((reg$fitted.values - phi$y)^2)
if (FALSE) {
  ggplot(phi) +
    geom_line(aes(x=x, y=y, color="true")) +
    geom_line(aes(x=x, y=reg$fitted.values, color="fitted"))
}
