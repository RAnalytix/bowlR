#' @title Gets match progress for a team.
#'
#' @description This package charts the two teams progress over a game specified by date.
#'
#' @param team
#' @param date
#'
#'
#' @return NULL
#'
#' @examples showProgress("England", "2017-03-05")
#'
#' @export

showProgress <- function(team, date) {
  bools <- sapply(listOfMatches, function(x) (all(c(team, date)
                                              %in% as.character(x[,3]))))
  df <- listOfMatches[bools][[1]] # Zeroing in our match
  df_copy <- df # Saving a copy for future reference
  df <- sapply(df, as.character) # To get rid of factors
  df <- matrix(as.numeric(df), ncol = 3) # Preserve numbers, and lose others
  df <- data.frame(df)[,-1] # Entirely useless
  df <- na.omit(df) # Losing all the useless non-numeric details.

  bools <- df[,2] == 0.0 | df[,2] == 1.0
  runs <- df[bools,1] # Getting the runs and the
  balls <- df[!bools, 2 ] # deliveries.
  balls.splt <- strsplit(as.character(balls), split = "\\.")
  balls.splt <- unlist(balls.splt)
  balls.splt <- matrix(balls.splt, ncol = 2, byrow = T)
  over <- balls.splt[,1] # It is also useful to have over and delivery
  ball <- as.numeric(balls.splt[,2]) # details be separate
  df <- cbind.data.frame(over = over, ball = ball,
                         run = runs, tgt = balls)
  # Need to partition this df further into first and second innings.
  sec.inn.starts <- which(df$tgt == "0.1")[2]
  firstInns <- df[1:sec.inn.starts-1,]
  secondInns <- df[sec.inn.starts:nrow(df),]
  firstInns$cum <- cumsum(firstInns$run) # Getting the cumulative scores
  secondInns$cum <- cumsum(secondInns$run)
  firstInns$Inns <- "1st Innings"
  secondInns$Inns <- "2nd Innings"

  df <- rbind(firstInns, secondInns)
  df <- df[!(df$ball > 6),] # Removing no balls. Note that we still retain the score.

  df$ball <- as.numeric(df$ball)/6 # fitting to 0-1 interval from 0-0.6
  df$overs <- as.numeric(as.character(df$over)) +  df$ball

  #df1 <- cbind(df[,c(11,5)], "1st Innings")
  #df2 <- cbind(df[,c(11,9)], "2nd Innings")
  #names(df2) <- names(df1)
  #df3 <- rbind(df1, df2)
  #names(df3) <- c("overs", "t.runs", "Innings")

  # Getting data for dismissals

  possibleDismissals <- which( df_copy[1] == "ball") - 1
  dismissals <- df_copy[possibleDismissals, 1] != ""
  inns <- as.character(df_copy[possibleDismissals[dismissals] - 2, 1])
  wicket.balls <- as.character(df_copy[possibleDismissals[dismissals] - 3, 3])
  wicket.balls <- as.numeric(wicket.balls)
  fows <- na.omit(cbind.data.frame(Innings = inns, fow = wicket.balls))
  fows$Innings <- droplevels(fows$Innings)
  teams <- as.character(unique(fows$Innings))
  fows$Innings <- factor(fows$Innings, levels = unique(fows$Innings))
  levels(fows$Innings) <- c("1st Innings", "2nd Innings")


  fows$Innings <- as.character(fows$Innings)
  unli <- unlist(strsplit(as.character(fows$fow), split = "\\."))
  unli[c(F,T)] <- as.numeric(unli[c(F,T)])/6
  unli <- as.numeric(unli)
  fows$fow <- unli[c(T,F)] + unli[c(F,T)]
  fows$wickets <- "W"

  df <- merge(fows, df, by.x = c("fow", "Innings"),
                by.y = c("overs", "Inns"), all.y = T)
  names(df) <- c("Delivery", "Innings", "Wicket", "Over", "Ball", "Runs", "tgt", "Score")

  # Plotting

  ggplot(df, aes(Delivery, Score, group = Innings, fill = Innings), col = Innings) +
    geom_line(size = .5) +
    geom_ribbon(aes(x = Delivery, ymax = Score), ymin = 0, alpha = 0.35) +
    scale_fill_manual(name='', values=c("1st Innings" = "red", "2nd Innings" = "green4")) +
    geom_point(data = df[!is.na(df$wickets),], aes(color = Innings), size = 2.5,
               show.legend = F) +
    scale_color_manual(values = c("red", "green4")) +
    xlab("Overs") + ylab("Score") +
    ggtitle(paste("Match Progression for", teams[1], "vs", teams[2]),
            subtitle = date)
}

#showProgress("Australia", "2006/03/05")


