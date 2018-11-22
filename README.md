
<!-- README.md is generated from README.Rmd. Please edit that file -->
rwalkable
=========

The goal of rwalkable is to look up and summarise some information about the walkability of a neighbourhood. We look at two components of walkability:

-   How many places are there within walking distance that you might want to go to?
-   Is there a reasonably dense network of roads or paths to walk on?

We use data from OpenStreetMap for both components, via the `osmdata` package: it provides both a road network and a list of locations ('amenities') that someone has thought worth adding to the map. Most of the heavy lifting is done by the `dodgr` package.

Installation
============

Install this package by running `devtools::install_github("sa-lee/rwalkable)`. 

Main functions
==============

The main function in `rwalkable` is the function `nearby(location, radius, amenities = NULL)`. The output is of class `nearby`. Objects of this class have a print, summary, and plot method. The plot method displays an interactive leaflet map of all amenities within a specified walking distance of a location when called.


