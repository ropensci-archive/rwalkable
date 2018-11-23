## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
devtools::load_all("../")
paris <- nearby("3rd Arrondissement, Paris, France")
paris

the_other_paris <- nearby("Paris, Texas, USA")
the_other_paris

## ---- eval = FALSE-------------------------------------------------------
#  nearby("Paris, France", radius = 2000)

## ---- eval = FALSE-------------------------------------------------------
#  nearby("Paris, France", radius = walk_time(15))

## ---- eval = FALSE-------------------------------------------------------
#  nearby("Paris, France", amenities = "cafe")

## ------------------------------------------------------------------------
plot(paris)

## ------------------------------------------------------------------------
plot(the_other_paris)

