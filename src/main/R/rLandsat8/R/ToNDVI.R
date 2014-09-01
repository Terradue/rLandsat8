#' creates a raster with the NDVI vegetation index
#' @description Creates a raster with the with the LSWI vegetation index: NDVI=(ρNIR −ρRed)/(ρNIR +ρRed)
#'
#' @param product name of the product, e.g. LC80522102014165LGN00. It must be in the working directory.
#' @return brightness temperature raster
#' @examples \dontrun{
#' ls8 <- ReadLandsat8("LC81880342014174LGN00")
#' r <- ToNDVI(ls8)
#' }
#'
#' @export
#' @import raster

ToNDVI <- function(landsat8) {

  # NDVI=(ρNIR −ρRed)/(ρNIR +ρRed)
  nir <- ToTOAReflectance(landsat8, "nir")
  red <- ToTOAReflectance(landsat8, "red")
  
  ndvi <- (nir - red) / (nir + red)
  
  return(ndvi)

}
