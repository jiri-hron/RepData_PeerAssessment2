## Auxillary function for storing the code for making plots for health damage
plotHealth = function(top.health) {
    # ensure ggplot2 is present
    if(!require("ggplot2")) {
        stop("the ggplot2 package needs to be installed in order to run this");
    }
    
    # melt for plotting
    melted.health = melt(top.health,
                         id.vars = "type", 
                         measure.vars= c("injuries",
                                         "fatalities"));
    # do the adjustment of importance of fatal over non-fatal injuries
    melted.health[melted.health$variable == "fatalities",]$value =
        melted.health[melted.health$variable == "fatalities",]$value * 2;
    melted.health$type = factor(melted.health$type);
    
    # make a plot    
    ggplot(melted.health, aes(x=type, y=value, fill = variable)) + 
        geom_bar(stat = "identity") +
        xlab("Weather event") +
        ylab("Health damage caused") +
        ggtitle("Total health damage caused by weather events over years") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1));
}