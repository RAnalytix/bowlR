#' @title Get data for a match
#'
#' @description This package gets the data for a match.
#'
#' @param match
#'
#' @return NULL
#'
#' @examples getData(1104482)
#'
#' @export

getData <- function(match) {
  file <- system.file("extdata", paste(c(match, ".csv"), collapse = ""), package = "bowlR")
  return(read.csv(file, stringsAsFactors = F, row.names = NULL))
}
