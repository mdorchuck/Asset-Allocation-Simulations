setwd("N:/Portfolio Strategy and Risk Management/Shared Programming/R/Asset-Allocation-Simulations/sims")

#------------------------------------------------------------
# createArray function
#
# reads csv files from the working directory and compiles them all into one 
# 3-dimensional matrix, assuming they are forecast out for an equivalent 
# number of time periods and have an equivalent number of simulations
# per asset class
#------------------------------------------------------------

  
  # read files
  
  temp = list.files(pattern="*.csv")
  
  dfs <- lapply(temp, read.csv, header = FALSE)
  
  
  #---to create individual data frames in the global environment------------
  
  # for (i in 1:length(temp)) {
  #   assign(strsplit(temp[i], "\\." )[[1]][1], read.csv(temp[i], header = FALSE)) 
  # }
  
  #-------------------------------------------------------------------------
  #initialze variables
  numSims = 5000;numTimePeriods = 10;numAssetClasses = 60
  
  
  num.sims = numSims # number of simulations
  num.periods = numTimePeriods  # number of time periods (10 years -> 10, 500 days -> 500, etc.)
  num.classes = numAssetClasses  # number of asset classes for which there are data
  


  data.array <- array(numeric(0), dim = c(num.sims, num.periods, num.classes), 
                      dimnames = c("Simulations", "t", "Asset Classes")) #make array to read data into
  #loop data into the array we just made
  for (i in 1:num.classes) {
    
    d = dfs[[i]]  
    d = d[, 1:numTimePeriods]
    data.array[, ,i] = as.matrix(d)
  }
  
#finished reading in HEK data    
#####-----------------------------------------------------------######################
#Read in GRS liability and benefit payment data
### switch wd to read in GRS data

setwd("N:/Portfolio Strategy and Risk Management/Shared Programming/R/Asset-Allocation-Simulations")

# read in GRS payments
pmts.dt = read.csv("GRSnetpmts.csv")
pmts = as.matrix(pmts.dt[,2])
rownames(pmts) = pmts.dt[,1]
pmts = t(pmts)

#read in GRS Liabilities
liab.dt = read.csv("GRSLiab.csv")
liab = as.matrix(liab.dt[,2])
rownames(liab) = liab.dt[,1]
liab = t(liab)
