#' @description Retrieves ascending/descending orbit direction information from the product
#'
#' @param list with metadata and raster bands
#' @return ascending/descending or NA if information not found
#' @examples \dontrun{
#' filename<-"LC81880342014238LGN00"
#' my.data <- ReadLandsat8(filename)
#' Get.Orbit.Direction(my.data)
#' }
#'
#' @export
GetOrbitDirection<-function(product){
     direction <- as.character(wrs2$MODE[wrs2$PATH == product$metadata$wrs_path & wrs2$ROW == product$metadata$wrs_row])
     if(length(direction)==0)
          return(NA)
     return ( direction )     
}