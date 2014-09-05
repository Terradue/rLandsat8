#' creates a raster with the brightness temperature extracted from Landsat tirs1 or tirs 2 band
#' @description Creates a raster with the at satellite brightness temperature extracted from Landsat tirs1 or tirs2 band.
#'
#' @param landsat8 list returned by rLandsat8::ReadLandsat8
#' @param band Landsat 2 bandname (one of "tirs1", "tirs2")
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
  
  allowedbands <- c("tirs1", "tirs2")
  
  if (!band %in% allowedbands)
  {
       stop(paste(band, "band not allowed"))
  }
  
  toarad <- ToTOARadiance(landsat8, band)
  
  idx <- seq_along(bandnames)[sapply(bandnames, function(x) band %in% x)]

  k1 <- as.numeric(landsat8$metadata[[paste0("k1_constant_band_",idx)]])
  k2 <- as.numeric(landsat8$metadata[[paste0("k2_constant_band_",idx)]])

  bt <- k2 / log(k1 / toarad + 1) 

  return(bt)

}
