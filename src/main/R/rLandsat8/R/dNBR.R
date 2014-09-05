#' creates a raster with the difference of Normalized Burn Ratio (NBR) index
#' @description Creates a raster with the difference of Normalized Burn Ratio (NBR) index 
#'
#' @param prefire name of the prefire product, e.g. LC80522102014165LGN00. It must be in the working directory.
#' @param postfire name of the postfire product, e.g. LC80522102014165LGN00. It must be in the working directory.
#' @param sun angle correction, default is.suncorrected = FALSE
#' @return difference of Normalized Burn Ratio (NBR) indexes raster
#' @examples \dontrun{
#' prels8 <- ReadLandsat8("LC81880342014174LGN00")
#' postls8 <- ReadLandsat8("")
#' r <- dNBR(prels8, postls8)
#' }
#'
#' @export
#' @import raster

dNBR <- function(prefire, postfire, is.suncorrected = FALSE) {

  dnbr <- ToNBR(prefire, is.suncorrected) - ToNBR(postfire, is.suncorrected)

  return(dnbr)

}
