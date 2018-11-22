
<!-- README.md is generated from README.Rmd. Please edit that file -->
rwalkable
=========

The goal of rwalkable is to look up and summarise some information about the walkability of a neighbourhood. We look at two components of walkability:

-   how many places are there within walking distance that you might want to go to?
-   is there a reasonably dense network of roads or paths to walk on.

We use data from OpenStreetMap for both components, via the `osmdata` package: it provides both a road network and a list of locations ('amenities') that someone has thought worth adding to the map. Most of the heavy lifting is done by the `dodgr` package.
