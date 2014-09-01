#' creates a raster with the brightness temperature extrcted from Landsat tirs1 band
#' @description Creates a raster with the brightness temperature extrcted from Landsat tirs1 band.
#'
#' @param product name of the product, e.g. LC80522102014165LGN00. It must be in the working directory.
#' @return brightness temperature raster
#' @examples \dontrun{
#' DownloadLandsat("http://earthexplorer.usgs.gov/download/4923/LC81370362014185LGN00/STANDARD/INVSVC", "LC80522102014165LGN00")
#' }
#'
#' @export
#' @import RCurl

DownloadLandsat <- function(url, output.name) {
  # todo: use RCurl instead of the system call
  
  command.args <- paste0("-c cookies.txt -d 'username=", usgs.username, "&password=", usgs.password,"' https://earthexplorer.usgs.gov/login")
  
  # invoke the system call to curl.
  # I'd rather have done this with RCurl but couldn't get it working ;-(
  ret <- system2("curl", command.args, stdout=TRUE, stderr=TRUE)
  
  command.args <- paste0("-b cookies.txt -L ", url," -o ", output.name)
  ret <- system2("curl", command.args, stdout=TRUE, stderr=TRUE)
  
  file.remove(cookies.txt)
  
  return(ret)
  
}
