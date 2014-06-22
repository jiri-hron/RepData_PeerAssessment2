## Auxillary function for storing the code for making plots for health damage
plotEconomical = function(top.economical) {
    # ensure ggplot2 is present
    # ensure ggplot2 and reshape2 are present
    if(!(require("ggplot2") * require("reshape2"))) {
        stop(paste("the ggplot2 and reshape2 package need to be installed",
                   "in order to run this"));
    }
    
    # melt for plotting
    melted.economic = melt(top.economic,
                         id.vars = "type", 
                         measure.vars= c("prop.dmg",
                                         "crop.dmg"));
    melted.economic$type = factor(melted.economic$type,
                                  levels = top.economic$type);
    
    # make a plot    
    ggplot(melted.economic, aes(x=type, y=value / 1e6, fill = variable)) + 
        geom_bar(stat = "identity") +
        xlab("Weather event") +
        ylab("Economic damages caused in millions of $") +
        ggtitle("Total economical damage caused by weather events over years") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
        scale_fill_discrete(name  ="Type of damage",
                            breaks=c("prop.dmg", "crop.dmg"),
                            label=c("Damage on Property", "Damage on Crops")) +
        coord_flip();
}