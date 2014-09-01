#' creates a raster with the brightness temperature extrcted from Landsat tirs1 band
#' @description Creates a raster with the brightness temperature extrcted from Landsat tirs1 band.
#'
#' @param product name of the product, e.g. LC80522102014165LGN00. It must be in the working directory.
#' @return brightness temperature raster
#' @examples \dontrun{
#' ls8 <- ReadLandsat8("LC80522102014165LGN00")
#' ToAtSatelliteBrightnessTemperature(ls8, "tirs1")
#' }
#'
#' @export
#' @import raster

ToAtSatelliteBrightnessTemperature <- function(landsat8, band) {
  
  bandnames <-c("aerosol", "blue", "green", "red",
  "nir", "swir1", "swir2",
  "panchromatic",
  "cirrus",
  "tirs1", "tirs2")
  
  # todo stop if band != tirs1, tirs2
  
  toarad <- ToTOARadiance(landsat8, band)
  
  idx <- seq_along(bandnames)[sapply(bandnames, function(x) band %in% x)]

  k1 <- as.numeric(landsat8$metadata[[paste0("k1_constant_band_",idx)]])
  k2 <- as.numeric(landsat8$metadata[[paste0("k2_constant_band_",idx)]])

  bt <- k2 / log(k1 / toarad + 1) 

  return(bt)

}
