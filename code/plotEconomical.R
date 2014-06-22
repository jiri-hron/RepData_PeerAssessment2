## Auxillary function for storing the code for making plots for health damage
plotEconomical = function(top.economical) {
    # ensure ggplot2 is present
    if(!require("ggplot2")) {
        stop("the ggplot2 package needs to be installed in order to run this");
    }
    
    # melt for plotting
    melted.economical = melt(top.economical,
                         id.vars = "type", 
                         measure.vars= c("prop.dmg",
                                         "crop.dmg"));
    melted.economical$type = factor(melted.economical$type);
    
    # make a plot
    ggplot(melted.economical, aes(x = type, 
                               y = economical.dmg / 1e6, 
                               fill = type)) +
        geom_bar(position="dodge",stat="identity") +
        xlab("Year") +
        ylab("Economical damage caused in millions of $") + 
        ggtitle("Total economical damage caused by weather events over years") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1));
    
    ggplot(melted.economical, aes(x=type, y=value / 1e6, fill = variable)) + 
        geom_bar(stat = "identity") +
        xlab("Weather event") +
        ylab("Economical damage caused in millions of $") +
        ggtitle("Total economical damage caused by weather events over years") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1));
}