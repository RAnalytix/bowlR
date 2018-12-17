#' @title Gets a list of matches available in the package.
#'
#' @description This package returns a dataframe of matches available in the package.
#'
#'
#' @param team
#' The team you want to see matches for. Default is NA; all teams.
#' @param from
#' The lower limit for the date, in YYYY-MM-DD format, to narrow searches. Only works if a corresponding 'till' argument provided. Set to NA by default.
#' @param till
#' The upper limit for the date, in YYYY-MM-DD format, to narrow searches. Only works if a corresponding 'from' argument provided. Set to NA by default.
#'
#'
#' @return
#'
#' @examples showProgress("England")
#'
#' @export

getMatches <- function(team = NA, from = NA, till = NA) {
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
  dat$`match number` <- as.numeric(dat$`match number`)

  if (!is.na(team)) {
    dat <- dat[dat$`team 1` == team | dat$`team 2` == team,]
  }
  if (!is.na(from)&!is.na(till)) {
    ll <- as.Date(from)
    ul <- as.Date(till)
    orig.date <- as.Date(dat$date)
    dat <- dat[orig.date > ll & orig.date <ul,]
  }
  return(dat)
}

