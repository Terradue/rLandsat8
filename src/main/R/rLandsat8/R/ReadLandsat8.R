#' Reads a Landsat 8 product
#' @description Reads a Landsat 8 product
#'
#' @param product name of the product, e.g. LC80522102014165LGN00. It must be in the working directory
#' @return list with metadata and raster bands
#' @examples \dontrun{
#' ReadLandsat8("LC80522102014165LGN00")
#' }
#'
#' @export
#' @import raster

ReadLandsat8 <- function(product) {  

  raster.files <- list("aerosol"="file_name_band_1",
    "blue"="file_name_band_2", 
    "green"="file_name_band_3",
    "red"="file_name_band_4",
    "nir"="file_name_band_5",
    "swir1"="file_name_band_6",
    "swir2"="file_name_band_7",
    "panchromatic"="file_name_band_8",
    "cirrus"="file_name_band_9",
    "tirs1"="file_name_band_10",
    "tirs2"="file_name_band_11"
    )
  
  meta.file <- paste0(product, "/", product, "_MTL.txt")
  
  if (!file.exists(meta.file))
       stop(paste(meta.file, "file not found."))
  
  textLines <- readLines(meta.file)
  
  counts <- count.fields(textConnection(textLines), sep="=")
  
  met <- read.table(text=textLines[counts == 2], as.is=TRUE, header=FALSE, sep="=", strip.white=TRUE, stringsAsFactors=FALSE)
  
  met <- read.table(text=textLines[counts == 2], as.is=TRUE, header=FALSE, sep="=", strip.white=TRUE, stringsAsFactors=FALSE, row.names = NULL, col.names=c("name", "value"))
  
  met <- met[!met$name == "GROUP", ] 
  met <- met[!met$name == "END_GROUP", ] 
  rownames(met) <- tolower(met[, "name"])
  met[, "name"] <- NULL
  
  met <- as.list(as.data.frame(t(met), stringsAsFactors=FALSE))
  
  bands=lapply(raster.files, function(x) {
    r <- raster(paste0(product, "/", met[[x]]))
    r@title <- names(raster.files)[seq_along(raster.files)[sapply(raster.files, function(a) x %in% a)]]
    NAvalue(r) <- 0
    return(r)
  }) 
  
  return(list(metadata=met,
    band=bands) 
  )
}
