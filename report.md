Title
========================================================

## Synopsis



## Data Processing

### Downloading the file from the internet
The file containing all the data used in this assignment is accessible from
the [Original link][1]. For the maximum reprducibility, the code used for
download and extraction can be sourced by calling the function here:

```r
source("code/getData.R")
```

The function 

### Reading the data
Having the file downloaded, the file contained in the archive can be extracted
and loaded into the memory:

```r
weather = read.csv(bzfile(get.data()),
                   header = T,
                   sep = ",",
                   comment.char = "",
                   stringsAsFactors = F)
```

### Data transformation
To be able to answer some the two questions stated in the assignment,
two universal statistics need to be established so as to represent a total harm
to public health and a total economical effect, respectively, of all the weather
events.  
For a total harm to public health, a simple statistic *HEALTH_DMG* was inffered
from columns *FATALATIES* and *INJURIES* by weighting the fatalities to injuries
caused by ratio 2:1. See following code for clarification:

```r
weather$HEALTH_DMG = weather$FATALITIES*2 + weather$INJURIES*1
```
The increased weight of fatalities was used to emphasize the difference between
fatal and non-fatal health damage caused. 

For a total economical effect, another statistic named *TOTAL_DMG* was
calculated summing up the property damage (*PROPDMG*) and crop damage
(*CRPDMG*) caused by each particular event:

```r
weather$TOTAL_DMG = weather$PROPDMG + weather$CROPDMG
```

The questions in the assignment are meant to explore the total damage caused by
each type of event, that can be found in the data base. However, from
the current number of 48 types of events in the database, only four were being
recorded in the years before January, 1996. Refer to [Database Details][2]
[Storm Data Documentation][3]

## Results



```r
cat("hello")
```

```
## hello
```

[1]: https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2
"Original link"

[2]: http://www.ncdc.noaa.gov/stormevents/details.jsp
"Database details"

[3]: http://www.ncdc.noaa.gov/stormevents/pd01016005curr.pdf
"Storm Data Documentation"
