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
     # landsat 8 properties
     landsat8.bitdepth <- 16
     landsat8.colourlevel <- 2 ^ landsat8.bitdepth - 1
     # check band components compatibilities

     if(!is.null(green.component))
          if( (red.component@ncols != green.component@ncols) | (red.component@nrows != green.component@nrows))
               stop("The bands components must have the same dimension!")     
     
     if(!is.null(blue.component))
          if( (red.component@ncols != blue.component@ncols) | (red.component@nrows != blue.component@nrows))
               stop("The bands components must have the same dimension!")     
     
     red.component <- ToTOAReflectance(landsat8, band.red, is.suncorrected)
     
     red.component[red.component > 1] <- 1
     red.component[red.component < 0] <- 0
     
     red.component <- ToTOAReflectance(landsat8, band.green, is.suncorrected)
     
     green.component[green.component > 1] <- 1
     green.component[green.component < 0] <- 0
     
     red.component <- ToTOAReflectance(landsat8, band.blue, is.suncorrected)
     blue.component[blue.component > 1] <- 1
     blue.component[blue.component < 0] <- 0
     
     rgb.stack <- stack(c(red.component * 255 / landsat8.colourlevel,
                              green.component * 255 / landsat8.colourlevel,
                              blue.component * 255 / landsat8.colourlevel))
     
     return(rgb.stack)
}
