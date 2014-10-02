#' creates a raster using 3 landsat8 bands 
#' @description Creates a raster by any 3 component from Landsat bands.
#'
#' @param red.component, landsat8 band mapped to the red channel. This first channel is mandatory
#' @param green.component default NULL, landsat8 band mapped to the green channel (optional channel)
#' @param blue.component default NULL, landsat8 band mapped to the blue channel (optional channel)
#' @return the combined raster (stack)
#' @examples \dontrun{
#' filename<-"LC81880342014238LGN00"
#' my.raster <- ReadLandsat8(filename)
#' ToRGB(my.raster$band$red, my.raster$band$green, my.raster$band$blue)
#' }
#'
#' @export

ToRGB <- function(landsat8, band.red, band.green, band.blue, is.suncorrected = FALSE) {
     
     red.component <- ToTOAReflectance(landsat8, band.red, is.suncorrected)
     
     red.component[red.component > 1] <- 1
     red.component[red.component < 0] <- 0
     
     green.component <- ToTOAReflectance(landsat8, band.green, is.suncorrected)
     
     green.component[green.component > 1] <- 1
     green.component[green.component < 0] <- 0
     
     blue.component <- ToTOAReflectance(landsat8, band.blue, is.suncorrected)
     
     blue.component[blue.component > 1] <- 1
     blue.component[blue.component < 0] <- 0
     
     rgb.stack <- stack(c(red.component * 255,
                              green.component * 255,
                              blue.component * 255))
     
     return(rgb.stack)
}
