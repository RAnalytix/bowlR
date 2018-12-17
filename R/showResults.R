#' @title Charts win and loss over the years for a team(s).
#'
#' @description This package charts win and loss over the years for all teams, or a single team, within a given year range.
#'
#' @param team
#' @param from
#' @param till
#'
#'
#' @return NULL
#'
#' @examples showResults("Pakistan", 2008, 2010)
#'
#' @export


showResults <- function(team = "All", from = 2006, till = 2017) {

  getYearRow <- function(df) which(df == "date", arr.ind = T)
  years <- sapply(listOfMatches, function(df) df[getYearRow(df)[1], getYearRow(df)[2]+1])
  years <- sapply(years, as.character)
  years <- as.numeric(unlist(sapply(years, substr, 1, 4)))
  within.range <- years >= from & years <= till
  list.within.range <- listOfMatches[within.range]

  getTeamDF <- function(team){
    team.games <- sapply(list.within.range, function(df) team %in% df[1:2,3])
    sum.games <- sum(team.games)
    team.list <- list.within.range[team.games]
    getWinnerRow <- function(df) which(df == "winner", arr.ind = T)
    team.losses <- sapply(team.list, function(df)
      df[getWinnerRow(df)[1],getWinnerRow(df)[2]+1])
    team.losses <- unlist(sapply(team.losses, as.character)) == team
    sum.losses <- sum(team.losses)
    team.df <- data.frame(name = team, Total = sum.games, Losses = sum.losses)
    return(team.df)
  }

  getAllDFs <- function(){
    all.teams <- table(c(sapply(list.within.range, function(df) df[1:2,3])))
    all.teams <- as.data.frame(all.teams)
    top.teams <- all.teams[order(all.teams$Freq, decreasing = T)[1:10],"Var1"]
    top.teams <- as.character(top.teams)
    team.dfs <- lapply(top.teams, getTeamDF)
    merged.dfs <- do.call(rbind.data.frame, team.dfs)
    labels <- levels(merged.dfs$name)
    labels <- toupper(substr(labels, 1, 3))
    labels[labels == "NEW"] <- "NZ"
    labels[labels == "WES"] <- "WI"
    labels[labels == "SRI"] <- "SL"
    labels[labels == "SOU"] <- "SA"
    levels(merged.dfs$name) <- labels
    return(merged.dfs)
  }

  makeBarPlot <- function(df){
    width <- ifelse(team == "All", 0.25, 0.05)
    plt <- ggplot() +
      geom_bar(aes(y = Total, x = name), data = df,
               stat="identity", width = width, fill = "#A62C2A") +
      geom_bar(aes(y = Losses, x = name), data = df,
               stat="identity", width = 3 * width, fill = "#E3B581") +
      geom_text(aes(label = name, y=Losses/2, x = name), data = df, angle = 90, nudge_x = 0) +
      theme(axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
      xlab("Team") +
      ylab("Number of Games") +
      ggtitle("Number of ODIs played",
              subtitle = paste(from, till, sep = "-"))
    print(plt)

  }
  ifelse(team == "All", makeBarPlot(getAllDFs()), makeBarPlot(getTeamDF(team)))
}

