#' creates a raster with the TOA radiance 
#' @description Creates a raster with the TOA radiance
#'
#' @param landsat8 list returned by rLandsat8::ReadLandsat8
#' @param band Landsat 11 bandname (one of "aerosol", "blue", "green", "red", "nir", "swir1", "swir2", "panchromatic", "cirrus", "tirs1", "tirs2" 
#' @return TOA Radiance raster
#' @examples \dontrun{
#' ls8 <- ReadLandsat8("LC81880342014174LGN00")
#' r <- ToTOARadiance(ls8, "red")
#' }
#'
#' @export
#' @import raster

ToTOARadiance <- function(landsat8, band) {

  bandnames <-c("aerosol", "blue", "green", "red",
  "nir", "swir1", "swir2",
  "panchromatic",
  "cirrus",
  "tirs1", "tirs2")
  
  allowedbands <- bandnames
  
  if (!band %in% allowedbands)
  {
       stop(paste(band, "band not allowed"))
  }
  
  idx <- seq_along(bandnames)[sapply(bandnames, function(x) band %in% x)]

  ml <- as.numeric(landsat8$metadata[[paste0("radiance_mult_band_",idx)]])
  al <- as.numeric(landsat8$metadata[[paste0("radiance_add_band_",idx)]])
  
  TOArad <- landsat8$band[[band]] * ml + al
  
  return(TOArad)
  
}
