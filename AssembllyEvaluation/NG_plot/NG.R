#!/psd/biosoft/anaconda/envs/R-3.6.0/bin/Rscript
Args <- commandArgs()
library(ggplot2)
library(reshape)
library("RColorBrewer")

myfilelist <- strsplit(Args[6], ",")
myoutput <- Args[7]
M <- unlist(myfilelist)


list1 <- list()
for(i in 1:length(M)){
    file <- read.table(M[i], quote="\"", comment.char="")
    p <- length(file$V1)
    NA_vector <- rep(NA, 100-p)
    #print (NA_vector)
    h <- as.vector(file$V1)
    NGX_scaffoldlength <- c(h, NA_vector)
    list1[[i]] <- NGX_scaffoldlength
}

l <- as.vector(list1)

X1 <- as.data.frame(l)
NGX_threshold <- c(1:100)
colnames(X1) <- M
xdata <- NGX_threshold
NGXdata <- data.frame(xdata, X1)
xymelt <- melt(NGXdata, id.vars = "xdata")
Color<-unique(c(brewer.pal(12,"Paired")[2:12],brewer.pal(9,"Set1"),brewer.pal(8,"Set2"),brewer.pal(12,"Set3"),brewer.pal(8,"Accent"),brewer.pal(11,"PuOr"),brewer.pal(8,"Dark2"),brewer.pal(11,"RdBu"),brewer.pal(11,"PiYG")))
Color<-Color[1:length(unique(xymelt$variable))]
Color<-rev(Color)


p <- ggplot(xymelt, aes(x = xdata, y = value, color = variable)) +
     theme_bw() +
     geom_line() +
     ylab("scaffold_length (bp)")+
     xlab("NG(X)") +
     scale_x_continuous(breaks = seq(0, 100, by = 10)) +
     scale_color_manual(values=Color)+
     geom_vline(xintercept = 50)
ggsave(myoutput, plot = p)

