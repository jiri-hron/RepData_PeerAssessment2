## Auxillary method for storing code used during weather data set transformation
transformData = function(weather) {
    # handle multipliers
    getMultipliers = function(x) {
        # if already numeric, return it
        if(suppressWarnings(!is.na(as.numeric(x)))) {
            x = as.numeric(x);
            # some events with non-zero damage have zero PROP, 0*1=0 anyway
            if(x == 0) {
                return(1);
            }
            return(x);
        }
        
        x = tolower(x);
        if(x == "h") return(100);
        if(x == "k") return(1e3);
        if(x == "m") return(1e6);
        if(x == "b") return(1e9);
        
        # else - best guess for characters '+'/'-'/'?'
        return(1);
    }
    
    # normalize the values to their numeric form
    weather$PROPDMGEXP = sapply(weather$PROPDMGEXP, 
                                getMultipliers,
                                USE.NAMES=F);
    weather$CROPDMGEXP = sapply(weather$CROPDMGEXP,
                                FUN=getMultipliers,
                                USE.NAMES=F);
    
    # add measure for total health damage
    weather$HEALTH_DMG = weather$FATALITIES*2 + weather$INJURIES*1;
    
    # add measure for total economical damage
    property.damage = weather$PROPDMG * weather$PROPDMGEXP;
    crop.damage = weather$CROPDMGEXP * weather$CROPDMG;
    weather$TOTAL_DMG = property.damage + crop.damage;
    
    
    # get the statistics of damage per year per event
    damage.by.event = aggregate(
        list(health.dmg = weather$HEALTH_DMG,
             injuries = weather$INJURIES,
             fatalities = weather$FATALITIES,
             prop.dmg = property.damage,
             crop.dmg = crop.damage,
             economic.dmg = weather$TOTAL_DMG),
        by = list(type = weather$EVTYPE),
        sum);
    
    # take top ten causes of economic damages
    top.economic = damage.by.event[
        order(damage.by.event$economic.dmg, decreasing = T),][1:10,];
    # take top ten causes of health damages
    top.health = damage.by.event[
        order(damage.by.event$health.dmg, decreasing = T),][1:10,];
}