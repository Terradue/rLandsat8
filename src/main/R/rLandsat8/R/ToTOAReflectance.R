#' creates a raster with the TOA reflectance
#' @description Creates a raster with the TOA reflectance
#'
#' @param landsat8 list returned by rLandsat8::ReadLandsat8
#' @param band Landsat 8 bandname (one of "aerosol", "blue", "green", "red", "nir", "swir1", "swir2", "panchromatic", "cirrus", "tirs1", "tirs2"
#' @return TOA Reflectance raster
#' @examples \dontrun{
#' ls8 <- ReadLandsat8("LC81880342014174LGN00")
#' r <- ToTOAReflectance(ls8, "blue")
#' }
#'
#' @export
#' @import raster

ToTOAReflectance <- function(landsat8, band) {

  bandnames <-c("aerosol", "blue", "green", "red",
  "nir", "swir1", "swir2",
  "panchromatic",
  "cirrus")
  
  # todo check if band is in bandnames

  idx <- seq_along(bandnames)[sapply(bandnames, function(x) band %in% x)]

  ml <- as.numeric(landsat8$metadata[[paste0("reflectance_mult_band_",idx)]])
  al <- as.numeric(landsat8$metadata[[paste0("reflectance_add_band_",idx)]])
  
  TOAref <- landsat8$band[[band]] * ml + al
  
  return(TOAref)
  
}
