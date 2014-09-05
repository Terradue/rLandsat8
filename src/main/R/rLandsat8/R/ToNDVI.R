#' creates a raster with the NDVI vegetation index
#' @description Creates a raster with the with the NDVI vegetation index: NDVI=(??NIR ?????Red)/(??NIR +??Red)
#'
#' @param product name of the product, e.g. LC80522102014165LGN00. It must be in the working directory.
#' @param sun angle correction, default is.suncorrected = FALSE
#' @return brightness temperature raster
#' @examples \dontrun{
#' ls8 <- ReadLandsat8("LC81880342014174LGN00")
#' r <- ToNDVI(ls8)
#' }
#'
#' @export
#' @import raster

ToNDVI <- function(landsat8, is.suncorrected = FALSE) {

  # NDVI=(??NIR ?????Red)/(??NIR +??Red)
  nir <- ToTOAReflectance(landsat8, "nir", is.suncorrected)
  red <- ToTOAReflectance(landsat8, "red", is.suncorrected)
  
  ndvi <- (nir - red) / (nir + red)
  
  return(ndvi)

}
