library(tidyverse)
library(gridExtra)
library(car)

# Spotify

setwd("/home/rgiordan/Documents/git_repos/stat151a-spring-2024")
spotify_df <- read.csv("datasets/spotify_songs.csv")
head(spotify_df)
nrow(spotify_df)

if (FALSE) {
  grid.arrange(
    qplot(x=track_popularity, geom="histogram", data=spotify_df),
    qplot(x=log10(track_popularity), geom="histogram", data=spotify_df))
}

names(spotify_df)
vars <- c("danceability", "energy", "key", "loudness", "speechiness", "acousticness", "instrumentalness", "liveness")
stopifnot(all(vars %in% names(spotify_df)))
vars[!(vars %in% names(spotify_df))]

ggplot(spotify_df) + geom_point(aes(y=track_popularity, x=danceability))
ggplot(spotify_df) + geom_density_2d_filled(aes(y=track_popularity, x=danceability))

reg_small <- lm(track_popularity ~ danceability, spotify_df)
summary(reg_small)
if (FALSE) {
  ggplot(spotify_df) +
    geom_density_2d_filled(aes(y=track_popularity, x=danceability)) +
    geom_line(aes(x=danceability, y=reg_small$fitted.values), color="red", linewidth=2)
}
  
regressors <- paste(vars, collapse=" + ")
reg_form <- formula(paste0("track_popularity ~ 1 + ", regressors))
reg <- lm(reg_form, spotify_df)
summary(reg)



# Bodyfat

bodyfat_df <- read.csv("datasets/bodyfat.csv")
head(bodyfat_df)
nrow(bodyfat_df)

vars <- c("Weight", "Height", "Neck", "Chest", "Abdomen", "Hip", "Thigh", "Knee", "Ankle", "Biceps", "Forearm", "Wrist")
stopifnot(all(vars %in% names(bodyfat_df)))


ggplot(bodyfat_df) + geom_point(aes(x=Abdomen, y=bodyfat))
ggplot(bodyfat_df) + geom_point(aes(x=Height, y=bodyfat))
ggplot(bodyfat_df) + geom_point(aes(x=Weight, y=bodyfat))

regressors <- paste(vars, collapse=" + ")
reg_form <- formula(paste0("bodyfat ~ 1 + ", regressors))
reg <- lm(reg_form, bodyfat_df)
summary(reg)

if (FALSE) {
  ggplot() +
    geom_point(aes(x=bodyfat_df$bodyfat, y=reg$fitted.values)) +
    geom_abline(aes(slope=1, intercept=0)) +
    xlab("Actual bodyfat") + ylab("Predicted bodyfat")
}




# Aluminum

al_df <- read.csv(file="datasets/aluminum_dataset.csv") %>% 
  filter(loading_type == "T", temp == 20, lot == "A")
head(al_df)
table(al_df[c("lot", "specimen")])

ggplot(al_df) +
  geom_point(aes(x=Strain, y=Stress_MPa, color=factor(specimen)))

al_df %>% filter(Strain < 0.0035) %>%
  ggplot() +
    geom_point(aes(x=Strain, y=Stress_MPa, color=factor(specimen)))


al_reg_df <- al_df %>% filter(Strain < 0.0035, Strain > 0.0001, specimen == 1)
ggplot(al_reg_df) +
  geom_point(aes(x=Strain, y=Stress_MPa, color=factor(specimen)))


reg <- lm(Stress_MPa ~ 1 + Strain, al_reg_df)
al_reg_df$fit <- reg$fitted.values
al_df %>% filter(Strain < 0.0035) %>%
  ggplot() +
    geom_point(aes(x=Strain, y=Stress_MPa, color=factor(specimen))) +
    geom_line(aes(x=Strain, y=fit, color="Specimen 1 Fitted"), data=al_reg_df)

