library(tidyverse)
library(MASS) # for ginv

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



p_true <- 100
#TruePhi <- GetFourierFeature(seq(1, p_true))
# decay <- 0.1
# wavenumber <- (1:p_true)
# decay  <- 1.5
# bc_true <- rnorm(p_true) / (wavenumber^decay)
# bs_true <- rnorm(p_true) / (wavenumber^decay)
a_scale <- 5
a_true <- a_scale * rnorm(p_true)
TruePhi <- GetFourierFeature(a_true)
bc_true <- rnorm(p_true)
bs_true <- rnorm(p_true)

EvalY <- function(x) {
  phi_grid <- TruePhi(x) %>% as.matrix()
  y <- phi_grid %*% c(bc_true, bs_true)
  return(y)
}

x_grid <- seq(0, 1, length.out=100)
y_grid <- EvalY(x_grid)
if (FALSE) {
  plot(x_grid, EvalY(x_grid), 'l')
}


n_obs <- 40
x_train <- runif(n_obs)
x_test <- runif(n_obs)


y_train <- EvalY(x_train)
y_test <- EvalY(x_test)

ComputeCurve <- function(max_nf) {
  a <- rnorm(max_nf) * a_scale
  result <- data.frame()
  for (nf in 2:max_nf) {
    GetPhi <- GetFourierFeature(a[1:nf])
    phi_train <- GetPhi(x_train) %>% as.matrix()
    phi_test <- GetPhi(x_test) %>% as.matrix()

    betahat <- ginv(t(phi_train) %*% phi_train) %*% t(phi_train) %*% y_train
    y_train_pred <- phi_train %*% betahat
    y_test_pred <- phi_test %*% betahat
    
    err_train <- mean((y_train_pred - y_train)^2)
    err_test <- mean((y_test_pred - y_test)^2)
    
    this_result <- data.frame(nf=nf, err_test=err_test, err_train=err_train)
    result <- bind_rows(result, this_result)
  }
  return(result)
}

result <- data.frame()
n_sims <- 50
pb <- txtProgressBar(min=0, max=n_sims, style=3)
for (sim in 1:n_sims) {
  setTxtProgressBar(pb, sim)
  result <- bind_rows(
    result,
    ComputeCurve(100) %>% mutate(sim=sim)
  )
}
close(pb)

ggplot(result) +
  geom_line(aes(x=nf, y=err_train, group=sim, color="train")) +
  geom_line(aes(x=nf, y=err_test, group=sim, color="test")) +
  geom_vline(aes(xintercept=n_obs / 2))


if (FALSE) {
  ggplot() +
    geom_line(aes(x=x_grid, y=y_grid, color="true")) +
    geom_point(aes(x=x_train, y=reg$fitted.values, color="train")) +
    geom_point(aes(x=x_test, y=y_test_fit, color="test"))
}
