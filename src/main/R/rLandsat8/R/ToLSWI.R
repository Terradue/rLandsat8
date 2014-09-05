#' creates a raster with the LSWI vegetation index
#' @description Creates a raster with the with the LSWI vegetation index: LSWI=(??NIR ?????SWIR1)/(??NIR +??SWIR1)
#'
#' @param product name of the product, e.g. LC80522102014165LGN00. It must be in the working directory.
#' @param sun angle correction, default is.suncorrected = FALSE
#' @return brightness temperature raster
#' @examples \dontrun{
#' ls8 <- ReadLandsat8("LC81880342014174LGN00")
#' r <- ToLSWI(ls8)
#' }
#'
#' @export
#' @import raster

ToLSWI <- function(landsat8, is.suncorrected = FALSE) {

  # LSWI=(??NIR ?????SWIR1)/(??NIR +??SWIR1) 
  nir <- ToTOAReflectance(landsat8, "nir", is.suncorrected)
  swir1 <- ToTOAReflectance(landsat8, "swir1", is.suncorrected)
  
  lswi <- (nir - swir1) / (nir + swir1)  
  
  return(lswi)

}
