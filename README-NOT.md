
<!-- README.md is generated from README.Rmd. Please edit that file -->
rwalkable
=========

The goal of rwalkable is to look up and summarise some information about the walkability of a neighbourhood. We look at two components of walkability:

-   how many places are there within walking distance that you might want to go to (per hectare)?
-   is there a reasonably dense network of roads or paths to walk on (number of road segments connections minus number of intersections, per hectare)

We use data from [OpenStreetMap](https://www.openstreetmap.org/copyright) for both components, via the `osmdata` package: it provides both a road network and a list of locations ('amenities') that someone has thought worth adding to the map. Most of the heavy lifting is done by the `dodgr` package.

Installation
------------

``` r
#install.packages("devtools")
devtools::install_github("ropenscilabs/rwalkable")
```

Example
-------

The location can be specified as (the centre of) a geographic area that OpenStreetMap knows about, or as a two-element vector of latitude and longitude

``` r
library(rwalkable)
nearby("Paris, France")
#> Within  800  m of Paris, France 
#>    7.6 points of interest per hectare
#>    2.2 road branches per hectare
nearby("Paris, Texas")
#> Within  800  m of Paris, Texas 
#>    0 points of interest per hectare
#>    0.4 road branches per hectare
```

More detail is better:

``` r
 nearby("3rd Arrondissement, Paris, France")
#> Within  800  m of 3rd Arrondissement, Paris, France 
#>    7.1 points of interest per hectare
#>    2.2 road branches per hectare
```

Check out the vignette for examples with interactive plots in `leaflet`!
