plotCounts = function(weather) {
    # ensure reshape2 is present
    if(!(require("reshape2") & require("ggplot"))) {
        stop("the reshape2 package needs to be installed in order to run this");
    }
    
    g = ggplot(weather, aes(factor(EVTYPE)))
    g + e
}