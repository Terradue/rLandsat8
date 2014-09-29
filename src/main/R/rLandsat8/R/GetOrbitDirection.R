#' Get the Ascending (A) or Descending (D) orbit 
#' @description Retrieves ascending/descending orbit direction information from the product
#'
#' @param list with metadata and raster bands
#' @return [A]scending/[D]escending or NA if information not found
#' @examples \dontrun{
#' filename<-"LC81880342014238LGN00"
#' my.data <- ReadLandsat8(filename)
#' GetOrbitDirection(my.data)
#' }
#'
#' @export
GetOrbitDirection<-function(product){
     direction <- as.character(wrs2$MODE[wrs2$PATH == product$metadata$wrs_path & wrs2$ROW == product$metadata$wrs_row])
     if(length(direction) == 0)
          return ( NA )
     return ( direction )     
}