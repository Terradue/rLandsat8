#' creates a raster with the classified Normalized Burn Ratio (NBR) index
#' @description Creates a raster with the classified Normalized Burn Ratio (NBR) index 
#'
#' @param prefire name of the prefire product, e.g. LC80522102014165LGN00. It must be in the working directory.
#' @param postfire name of the postfire product, e.g. LC80522102014165LGN00. It must be in the working directory.
#' @param sun angle correction, default is.suncorrected = FALSE
#' @return classified Normalized Burn Ratio (NBR) raster
#' @examples \dontrun{
#' prefire <- "LC82040322013219LGN00"
#' postfire <- "LC82040322013267LGN00"
#'
#' lspre <- ReadLandsat8(prefire)
#' lspost <- ReadLandsat8(postfire)
#' r <- ToNBRClass(lspre, lspost)
#' }
#'
#' @export
#' @import raster

ToNBRClass <- function(prefire, postfire, is.suncorrected = FALSE) {

  # classify
  m <- c(-Inf, -500, -1, -500, -251, 1, -251, -101, 2, -101, 99, 3, 99, 269, 
    4, 269, 439, 5, 439, 659, 6, 659, 1300, 7, 1300, +Inf, -1)
  class.mat <- matrix(m, ncol=3, byrow=TRUE)

  reclass <- reclassify(10^3 * dNBR(prefire, postfire, is.suncorrected), class.mat)
  
  reclass <- ratify(reclass)
  rat <- levels(reclass)[[1]]
  rat$legend  <- c("NA", "Enhanced Regrowth, High", "Enhanced Regrowth, Low", "Unburned", "Low Severity", "Moderate-low Severity", "Moderate-high Severity", "High Severity")
  levels(reclass) <- rat
  
  return(reclass)

}
