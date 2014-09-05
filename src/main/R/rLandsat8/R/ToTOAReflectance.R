#' creates a raster with the TOA reflectance
#' @description Creates a raster with the TOA reflectance
#'
#' @param landsat8 list returned by rLandsat8::ReadLandsat8
#' @param band Landsat 9 bandname (one of "aerosol", "blue", "green", "red", "nir", "swir1", "swir2", "panchromatic", "cirrus")
#' @param sun angle correction, default is.suncorrected = FALSE
#' @return TOA Reflectance raster
#' @examples \dontrun{
#' ls8 <- ReadLandsat8("LC81880342014174LGN00")
#' r <- ToTOAReflectance(ls8, "blue")
#' }
#'
#' @export
#' @import raster

ToTOAReflectance <- function(landsat8, band, is.suncorrected = FALSE) {

  bandnames <-c("aerosol", "blue", "green", "red",
  "nir", "swir1", "swir2",
  "panchromatic",
  "cirrus",
  "tirs1", "tirs2")
  
  allowedbands <- c("aerosol", "blue", "green", "red",
  "nir", "swir1", "swir2",
  "panchromatic",
  "cirrus")
  
  if (!band %in% allowedbands)
  {
       stop(paste(band, "band not allowed"))
  }
  
  idx <- seq_along(bandnames)[sapply(bandnames, function(x) band %in% x)]

  ml <- as.numeric(landsat8$metadata[[paste0("reflectance_mult_band_",idx)]])
  al <- as.numeric(landsat8$metadata[[paste0("reflectance_add_band_",idx)]])
  
  # sun_elevation is in degree, need to convert into radians
  sun.correction.factor <- 1
  if(is.suncorrected)
       sun.correction.factor <- sin(as.numeric(landsat8$metadata$sun_elevation) * pi /180)

  TOAref <- (landsat8$band[[band]] * ml + al)/sun.correction.factor
  
  return(TOAref)

  
}
