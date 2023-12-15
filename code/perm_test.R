library(tidyverse)

n <- 200
d0 <- 2
d1 <- 2

SimulateIndep <- function(n, d0, d1, het) {
  x0 <- rnorm(n * d0) %>% matrix(n, d0)
  x1 <- rnorm(n * d1) %>% matrix(n, d1)
  x0[, 1] <- 1
  
  b0 <- rnorm(d0)
  b1 <- rep(0, d1)
  
  eps <- rnorm(n, 0, 1)
  if (het) {
    eps <- eps * x1[,1]  # Heteroskedastic
  }
  
  df <- data.frame(x0, x1)
  x_regressors <- paste0("X", 1:d0)
  z_regressors <- paste0("Z", 1:d1)
  names(df) <- c(x_regressors, z_regressors)
  df$eps <- eps
  df$y <- x0 %*% b0 + x1 %*% b1 + eps
  attributes(df)$x_regressors <- x_regressors
  attributes(df)$z_regressors <- z_regressors
  return(df)
}


SummarizeReg <- function(reg) {
  coeff <-
    summary(reg)$coefficients %>%
    as.data.frame() %>%
    mutate(reg=names(reg$coefficients))
  return(coeff)  
}


RunReg <- function(df) {
  form_str <- paste0(
    "y ~ -1 + ", 
    paste(c(attributes(df)$x_regressors, 
            attributes(df)$z_regressors), 
          collapse=" + "))
  reg <- lm(formula(form_str), data=df)
  return(reg)  
}


GetPermP <- function(df, reg, target, n_perm=500) {
  GetStat <- function(reg, target) {
    SummarizeReg(reg) %>% filter(reg == target) %>% pull("t value")
  }
  
  null_form_str <- paste0(
    "y ~ -1 + ", 
    paste(attributes(df)$x_regressors, 
          collapse=" + "))
  reg_null <- lm(formula(null_form_str), data=df)
  
  t1 <- GetStat(reg, target=target)
  t_stats <- c()
  df_perm <- df
  for (perm in 1:n_perm) {
    df_perm$y <- reg_null$fitted.values + sample(reg_null$residuals)
    t_perm <- RunReg(df_perm) %>% GetStat(target=target)
    t_stats <- c(t_stats, t_perm)
  }
  perm_p <- mean(abs(t1) > abs(t_stats))
  return(perm_p)
}


target <- "Z1"

sim_df <- data.frame()
n_sims <- 1000
pb <- txtProgressBar(min=0, max=n_sims, initial=0, style=3)
for (sim in 1:n_sims) {
  setTxtProgressBar(pb, sim)
  df <- SimulateIndep(n, d0, d1, het=TRUE)
  reg <- RunReg(df)
  perm_p <- GetPermP(df, reg, target, n_perm=250)
  sim_df <-
    bind_rows(sim_df,
              SummarizeReg(reg) %>%
                filter(reg == target) %>%
                mutate(perm_p=perm_p, sim=sim))
}
close(pb)

p_vals <- 
  sim_df %>%
  pull("Pr(>|t|)")
mean(p_vals < 0.1)

perm_p_vals <- 
  sim_df %>%
  pull("perm_p")
mean(perm_p_vals < 0.1)
hist(perm_p_vals)

#X <-model.matrix(reg)
#eigen(t(X) %*%X)




