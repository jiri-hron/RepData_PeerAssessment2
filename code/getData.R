## Checks if the data exists in "data" folder under current working directory
## created by a previous run of the code, if not starts a download and saves
## the file for later use. In both cases returns a path to existing csv file
## containing the original data.
getData = function() {
    # check if the data were already downloaded
    data.dir = file.path(getwd(), "data");
    zipped = file.path(data.dir, "StormData.csv.bz2");
    if(file.exists(zipped)) {
        return(zipped);       
    }
    
    # load the httr library for file-download
    if(require(httr)) {
               
        message("starting download, this may take a while ...");     
        file = content(GET(paste0("https://d396qusza40orc.",
                                  "cloudfront.net/repdata%2Fdata",
                                  "%2FStormData.csv.bz2")));
        
        message(paste("time downloaded:", date()));
        data.dir = file.path(getwd(), "data");
        dir.create(data.dir, recursive = T, showWarnings = F);
        zipped = file.path(data.dir, "StormData.csv.bz2");
        file.create(zipped, showWarnings = F);
        writeBin(file, zipped);
        
        message("unzipping file");
        unzip(zipfile=zipped,exdir=data.dir);
        ret = file.path(data.dir,
                        "StormData.csv");
    }
    else {
        stop("cannot access the httr library to download it instead");
    }
    
    ## return
    ret;
}