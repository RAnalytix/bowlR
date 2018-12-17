#' @title Gets a list of matches available in the package.
#'
#' @description This package returns a dataframe of matches available in the package.
#'
#'
#' @param team
#' @param date
#'
#'
#' @return
#'
#' @examples showProgress("England", "2017-03-05")
#'
#' @export

getMatches <- function(team = NA, date = NA) {
  # Making the header
  header <- as.character(listOfMatches[[1]][1:17,2])
  header[1:2] <- c("team 1", "team 2")
  header <- gsub("_", " ", header)

  dat <- lapply(listOfMatches, function(x) t(x[1:18,3]))
  dat <- lapply(dat, as.character)
  dat <- lapply(dat, function(x) x[x!="true" & x!="false"])
  dat <- lapply(dat, function(x) x[1:17])
  dat <- data.frame(do.call(rbind, dat), stringsAsFactors = F)

  names(dat) <- header
  indices <- which(!grepl("[0-9]", dat$`match number`))
  dat[indices,8:17] <- dat[indices,7:16]
  dat <- dat[,1:17]

  return(dat)
}

showProgress("Australia", "2006/03/05")


