# bowlR
`bowlR` is my opensource package for aggregating and visualizing ODI Cricket data. As a cricket fan from Pakistan, it was only a matter of time before I started visualizing cricket in R. This is an ongoing project, and I will keep adding more functions for aggregating data, making informative and elegant visualizations etc in the coming time. I will also incorporate some predictive functions using ML methods. Meanwhile, you can begin using the package by installing it through RStudio/your R IDE.

## Installation

Make sure you have devtools installed and loaded. You can do that by running `install.packages("devtools")` followed by `library(devtools)`. Next, you can install `bowlR` by running 
``` R 
devtools::install_github(“ttehseen/bowlR”)
library(bowlR)
```

## Data

The data used in this package is from [Cricsheet](http://cricsheet.com). While over all the data was well-structured, there were some kinks throughout that required cleaning out. The R code behind all functions in this package meticulously cleans/munges the source data before using it in any way.

## Functions

Here are a few functions contained in the package:

### `getMatches()`

`getMatches()` retrieves a dataset of cricket ODI matches for the country and time frame provided. The country and upper/lower bound arguments are optional. Not selecting any will generate datasets for all available teams and for the entire time frame in the dataset.

```R
data <- getMatches("Pakistan", "2015-01-01", "2017-06-01")
head(data, 10)
```
```        
team 1      team 2 gender  season       date                                   series
1    Australia    Pakistan   male 2016/17 2017/01/13         Pakistan in Australia ODI Series
2    Australia    Pakistan   male 2016/17 2017/01/15         Pakistan in Australia ODI Series
3    Australia    Pakistan   male 2016/17 2017/01/19         Pakistan in Australia ODI Series
4    Australia    Pakistan   male 2016/17 2017/01/22         Pakistan in Australia ODI Series
5    Australia    Pakistan   male 2016/17 2017/01/26         Pakistan in Australia ODI Series
81    Pakistan West Indies   male 2016/17 2016/09/30        Pakistan v West Indies ODI Series
82    Pakistan West Indies   male 2016/17 2016/10/02        Pakistan v West Indies ODI Series
83    Pakistan West Indies   male 2016/17 2016/10/05        Pakistan v West Indies ODI Series
84 New Zealand    Pakistan female 2016/17 2016/11/11 Pakistan Women in New Zealand ODI Series
85 New Zealand    Pakistan female 2016/17 2016/11/13   ICC Women's Championship, 2014-2016/17
   match number                                        venue      city         toss winner
1             1       Brisbane Cricket Ground, Woolloongabba  Brisbane           Australia
2             2                     Melbourne Cricket Ground                     Australia
3             3 Western Australia Cricket Association Ground     Perth           Australia
4             4                        Sydney Cricket Ground                     Australia
5             5                                Adelaide Oval                     Australia
81            1                      Sharjah Cricket Stadium                   West Indies
82            2                      Sharjah Cricket Stadium                      Pakistan
83            3                         Sheikh Zayed Stadium Abu Dhabi            Pakistan
84            2                          Bert Sutcliffe Oval   Lincoln         New Zealand
85            3     Pakistan Women in New Zealand ODI Series         3 Bert Sutcliffe Oval
   toss decision player of match      umpire          umpire.1 reserve umpire         tv umpire
1            bat         MS Wade  MD Martell     C Shamshuddin    SJ Nogajski       CB Gaffaney
2            bat Mohammad Hafeez CB Gaffaney          P Wilson    SJ Nogajski     C Shamshuddin
3          field       SPD Smith      SD Fry     C Shamshuddin       P Wilson       CB Gaffaney
4            bat       DA Warner CB Gaffaney        MD Martell       P Wilson     C Shamshuddin
5            bat       DA Warner      SD Fry     C Shamshuddin    SJ Nogajski       CB Gaffaney
81         field      Babar Azam  Ahsan Raza RSA Palliyaguruge    Shozab Raza            S Ravi
82           bat      Babar Azam      S Ravi       Shozab Raza     Ahsan Raza RSA Palliyaguruge
83           bat      Babar Azam  Ahsan Raza RSA Palliyaguruge    Shozab Raza            S Ravi
84           bat     JAK Bromley  ED Sanders        GAV Baxter    New Zealand                60
85       Lincoln        Pakistan         bat           K Cross     ED Sanders        SR Bernard
   match referee
1       JJ Crowe
2       JJ Crowe
3       JJ Crowe
4       JJ Crowe
5       JJ Crowe
81    AJ Pycroft
82    AJ Pycroft
83    AJ Pycroft
84           D/L
85   New Zealand
```

### `getBreakdown()`

One of my personal favorites, this function displays team performances over a period of time. The arguments to `getBreakdown` are optional. If not provided, performance breakdown for all teams across the maximum time frame possible in the data will be displayed on the batplot- bar plots but with a cricket flavor. Here are a few examples.

```R
getBreakdown()
```
![Batplot1](https://github.com/ttehseen/bowlR/blob/master/imgs/batPlot1.png)

Over here the heights of the bats represent the number of ODI games that a national side has played. The red handles represent the proportion of game lost while the the blade of the bat accounts for games won.

We can also provide additional arguments to specify a country and time frame. Let us see how Australia has been doing more recently.

```R
getBreakdown("Australia", 2017, 2017)
```
![Batplot1](https://github.com/ttehseen/bowlR/blob/master/imgs/Batplot2.png)

### `showProgress()`

Another useful visualization is that of the score chase in an ODI match. A typical match 'progresses' as the chasing side tries to hunt down the target within the stipulated number of bowls. The following visualization, for any match in the last decade or so, visualizes this progression. Let us have a look at the oldest game I remember watching on TV, South Africa playing Australia back in 2006.

```R
showProgress("Australia", "2006/03/05") # Only one of the two teams is required to search for the game.
```
![Progressplot1](https://github.com/ttehseen/bowlR/blob/master/imgs/Progressplot1.png)

South Africa put up a good fight, and kept close to the required run-rate throughout the match. They did, however, regularly lose wickets which led them to a loss- a good ~20 run loss.

....

I will update the package with more graphics functions as well as a few predictive ones using Machine Learning methods in R.
