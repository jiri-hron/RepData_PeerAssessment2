## This is an auxillary method used for reading a data from bzip file passed
## as a parameter. The file included in the referenced bzip archive is extracted
## and returned
readData = function(path) {
    read.csv(bzfile(path),
             header = T,
             sep = ",",
             comment.char = "",
             stringsAsFactors = F);
}