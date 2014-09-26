#' creates a raster using 3 landsat8 bands 
#' @description Creates a raster by any 3 component from Landsat bands.
#'
#' @param red.component, landsat8 band mapped to the red channel
#' @param green.component, landsat8 band mapped to the green channel
#' @param blue.component, landsat8 band mapped to the blue channel
#' @return the combined raster
#' @examples \dontrun{
#' filename<-"LC81880342014238LGN00"
#' my.raster <- ReadLandsat8(filename)
#' ToRGB(my.raster$band$red, my.raster$band$green, my.raster$band$blue)
#' }
#'
#' @export

ToRGB<-function(red.component, green.component, blue.component){
     # landsat 8 properties
     landsat8.bitdepth <- 16
     landsat8.colourlevel <- 2 ^ landsat8.bitdepth - 1
     mapping.landasta8colourlevel <- 255 / landsat8.colourlevel
     
     # check band components compatibilities
     if( (red.component@ncols != green.component@ncols) | (red.component@ncols != blue.component@ncols) | (red.component@nrows != green.component@nrows) | (red.component@nrows != blue.component@nrows))
          stop("The 3 band components must have the same dimension!")
     
     # any r/g/b component is suitable for the setting operation
     rgb.datasize <- red.component@ncols * red.component@nrows
     GT   <- GridTopology(c(0, 0), c(1, 1), c(red.component@ncols, red.component@nrows))
     SGDF <- SpatialGridDataFrame(GT, data=data.frame(red = rep(0,times=rgb.datasize), green = rep(0,times=rgb.datasize), blue = rep(0,times=rgb.datasize)))
     
     data.red <- getValues(red.component) * mapping.landasta8colourlevel
     data.red[data.red < 0] <- 0
     data.red[data.red > 255] <- 255
     SGDF$red   <- data.red   * mapping.landasta8colourlevel
     
     data.green <- getValues(green.component) * mapping.landasta8colourlevel
     data.green[data.green < 0] <- 0
     data.green[data.green > 255] <- 255
     SGDF$green <- data.green
     
     data.blue <- getValues(blue.component) * mapping.landasta8colourlevel
     data.blue[data.blue < 0] <- 0
     data.blue[data.blue > 255] <- 255
     SGDF$blue  <- data.blue
     #image(SGDF, red="red", green="green", blue="blue")
     return(raster(SGDF))
}