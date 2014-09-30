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

ToRGB<-function(red.component, green.component = NULL, blue.component = NULL){
     # landsat 8 properties
     landsat8.bitdepth <- 16
     landsat8.colourlevel <- 2 ^ landsat8.bitdepth - 1
     mapping.landasta8colourlevel <- 255 / landsat8.colourlevel
     
     # check band components compatibilities
     # we always have the red component (at least a channel to get a black & white image)
     
     if(!is.null(green.component))
          if( (red.component@ncols != green.component@ncols) | (red.component@nrows != green.component@nrows))
               stop("The bands components must have the same dimension!")     
     
     if(!is.null(blue.component))
          if( (red.component@ncols != blue.component@ncols) | (red.component@nrows != blue.component@nrows))
               stop("The bands components must have the same dimension!")     
     
     # any r/g/b component is suitable for the setting operation
     rgb.datasize <- red.component@ncols * red.component@nrows
     GT   <- GridTopology(c(0, 0), c(1, 1), c(red.component@ncols, red.component@nrows))
     
     SGDF.red <- SpatialGridDataFrame(GT, data=data.frame(red = rep(0,times=rgb.datasize)))
     SGDF.green <- SpatialGridDataFrame(GT, data=data.frame(green = rep(0,times=rgb.datasize)))
     SGDF.blue <- SpatialGridDataFrame(GT, data=data.frame(blue = rep(0,times=rgb.datasize)))
     
     r <- stack()
     
     # we always have the red component (at least a channel to get a black & white image)
     data.red <- getValues(red.component) * mapping.landasta8colourlevel
     data.red[data.red < 0] <- 0
     data.red[data.red > 255] <- 255
     SGDF.red$red   <- data.red   * mapping.landasta8colourlevel
     r <- stack(r,raster(SGDF.red))
     
     if(!is.null(green.component)) {
          data.green <- getValues(green.component) * mapping.landasta8colourlevel
          data.green[data.green < 0] <- 0
          data.green[data.green > 255] <- 255
          SGDF.green$green <- data.green
          r<- stack(r,raster(SGDF.green))
     }
     
     if(!is.null(blue.component)) {
          data.blue <- getValues(blue.component) * mapping.landasta8colourlevel
          data.blue[data.blue < 0] <- 0
          data.blue[data.blue > 255] <- 255
          SGDF.blue$blue <- data.blue
          r<- stack(r,raster(SGDF.blue)) 
     }

     return(r)
}