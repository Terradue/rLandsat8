#' creates a raster with the Normalized Burn Ratio (NBR) index
#' @description Creates a raster with with the Normalized Burn Ratio (NBR) index: NBR =(ρNIR −ρSWIR2)/(ρNIR +ρSWIR2)
#'
#' @param product name of the product, e.g. LC80522102014165LGN00. It must be in the working directory.
#' @param sun angle correction, default is.suncorrected = FALSE
#' @return Normalized Burn Ratio (NBR) index raster
#' @examples \dontrun{
#' ls8 <- ReadLandsat8("LC81880342014174LGN00")
#' r <- ToNBR(ls8)
#' }
#'
#' @export
#' @import raster

ToNBR <- function(landsat8, is.suncorrected = FALSE) {

  # NBR =(ρNIR −ρSWIR2)/(ρNIR +ρSWIR2)
  nir <- ToTOAReflectance(landsat8, "nir", is.suncorrected)
  swir2 <- ToTOAReflectance(landsat8, "swir2", is.suncorrected)
  
  nbr <- (nir - swir2) / (nir + swir2)
  
  return(nbr)

}
