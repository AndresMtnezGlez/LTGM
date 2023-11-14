library(data.table)

myUrl <- "https://www.imf.org/-/media/Files/Publications/WEO/WEO-Database/2023/WEOOct2023all.ashx"
WEO <- read.table(file=myUrl, 
                  sep="\t", 
                  header=TRUE, 
                  fill = TRUE,
                  na.strings = "n/a")


select(WEO, "X1980":"X2028") %>%
  mutate_if(is.character,as.numeric) -> AUX

names(AUX) <- 1980:2028

WEO <- cbind(WEO[c(1:8)], AUX)

sapply(WEO, mode)

WEO <- melt(setDT(WEO), id.vars = 1:8, variable.name = "year")

sapply(WEO, mode)


save(WEO, file = "C:/Users/andre/Downloads/weo.RData", compress = "xz")
