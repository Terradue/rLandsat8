#' creates a raster with the MNDWI vegetation index
#' @description Creates a raster with the with the MNDWI vegetation index: MNDWI=(??Green ??? ??SWIR1)/(??Green + ??SWIR1) 
#'
#' @param product name of the product, e.g. LC80522102014165LGN00. It must be in the working directory.
#' @param sun angle correction, default is.suncorrected = FALSE
#' @return brightness temperature raster
#' @examples \dontrun{
#' ls8 <- ReadLandsat8("LC81880342014174LGN00")
#' r <- ToMNDWI(ls8)
#' }
#'
#' @export
#' @import raster

ToMNDWI <- function(landsat8, is.suncorrected = FALSE) {

  # MNDWI=(??Green ??? ??SWIR1)/(??Green + ??SWIR1) 
  green <- ToTOAReflectance(landsat8, "green", is.suncorrected)
  swir1 <- ToTOAReflectance(landsat8, "swir1", is.suncorrected)
  
  mndwi <- (green - swir1) / (green + swir1)
  
  return(mndwi)

}
