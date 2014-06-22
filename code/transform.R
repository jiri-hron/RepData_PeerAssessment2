## Auxillary method for storing code used during weather data set transformation
transform.data = function(weather) {
    # add measure for total health damage
    weather$HEALTH_DMG = weather$FATALITIES*2 + weather$INJURIES*1;
    
    # add measure for total economical damage
    weather$TOTAL_DMG = weather$PROPDMG + weather$CROPDMG;
    
    # add year column    
    if(!require(lubridate)) {
        stop("you need to install lubridate package to run this code");
    }
    weather$YEAR = year(as.Date(weather$BGN_DATE, "%m/%d/%Y %H:%M:%S"));
  
    # get the statistics of damage per year per event
    damage.by.event.year = aggregate(
        list(health.dmg = weather$HEALTH_DMG,
             total.dmg = weather$TOTAL_DMG),
        by = list(type = weather$EVTYPE,
                  year = weather$YEAR),
        sum);
}