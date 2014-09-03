# rLandsat8

R interface to rLandsat8

<!---[![DOI](https://zenodo.org/badge/3806/Terradue/rOpenSearch.png)](http://dx.doi.org/10.5281/zenodo.10642)-->

### Documentation

The rLandsat8 documentation is live at: http://terradue.github.io/rLandsat8

The rLandsat8 documentation source is available at: https://github.com/Terradue/rLandsat8/tree/master/src/main/doc

Inside R, use ?_<function name>_ to view the function's help page. Example:

```coffee
?ReadLandsat8
```

### Citing this package

<!---To cite rOpenSearch use its [DOI](http://dx.doi.org/10.5281/zenodo.10642)-->

### Installing a release

The releases are available at: https://github.com/Terradue/rLandsat8/releases

Releases can be installed using [devtools](http://www.rstudio.com/products/rpackages/devtools/)

Start an R session and run:

```coffee
library(devtools)
install_url("https://github.com/Terradue/rLandsat8/releases/download/v0.1-SNAPSHOT/rLandsat8_0.1.0.tar.gz")
library(rLandsat8)
```

> Note the example above install the v0.1-SNAPSHOT release, adapt it to the current release

### Building and installing the development version

The rLandsat8 package is built using maven.

From a terminal: 

```bash
cd
git clone git@github.com:Terradue/rLandsat8.git
cd rLandsat8
mvn compile
```

That generates a compressed archive with the rOpenSearch package in:

```
~/rLandsat8/target/R/src/rLandsat8_x.y.z.tar.gz
```
To install the package, start an R session and run:

```coffee
install.packages("~/rLandsat8/target/R/src/rLandsat8_x.y.z.tar.gz", repos=NULL, type="source")
```

> Note x.y.z is the development version number.

Then load the library:

```coffee
library(rLandsat8)
```

## Getting Started 

### Calculate the Normalized Difference Vegetation Index

This example:

* Reads a previously downloaded Landsat 8
* Calculates the Normalized Difference Vegetation Index (NDVI) by converting the NIR and Red bands to TOA reflectances and applying the normalized difference: NDVI=(ρNIR −ρRed)/(ρNIR +ρRed)

```coffee
library(rLandsat8)

setwd("~/Downloads")
product  <- "LC82040322013219LGN00"
l <- ReadLandsat8(product)

ndvi <- ToNDVI(l)
plot(ndvi)
```

## Questions, bugs, and suggestions

Please file any bugs or questions as [issues](https://github.com/Terradue/rLandsat8/issues/new) or send in a pull request.



