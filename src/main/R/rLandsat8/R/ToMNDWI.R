#' creates a raster with the MNDWI vegetation index
#' @description Creates a raster with the with the MNDWI vegetation index: MNDWI=(ρGreen − ρSWIR1)/(ρGreen + ρSWIR1) 
#'
#' @param product name of the product, e.g. LC80522102014165LGN00. It must be in the working directory.
#' @return brightness temperature raster
#' @examples \dontrun{
#' ls8 <- ReadLandsat8("LC81880342014174LGN00")
#' r <- ToMNDWI(ls8)
#' }
#'
#' @export
#' @import raster

ToMNDWI <- function(landsat8) {

  # MNDWI=(ρGreen − ρSWIR1)/(ρGreen + ρSWIR1) 
  green <- ToTOAReflectance(landsat8, "green")
  swir1 <- ToTOAReflectance(landsat8, "swir1")
  
  mndwi <- (greeb - swir1) / (green + swir1)
  
  return(mndwi)

}
