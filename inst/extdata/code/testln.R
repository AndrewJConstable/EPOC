function (MeanNat,CVnat,Nrnd)
# B0 median test
# Test rule that B0 median is the same as the biomass derived from mean recruitment and the mortality function
# test whether this applies also to spawning biomass

{

# Input parameters:   Npop     = number of populations to use in estimating median
#                     FirstAge = first age class
#                     LastAge  = last age class as a plus class
#                     MeanNat  = Mean of log normal distribution in natural domain
#                     CVnat    = CV of log normal distribution in natural domain
#                     NatMort  = M

    SDlog   <- sqrt(log(1+CVnat^2))
    MeanLog<- log(MeanNat)-SDlog^2/2

  Vals<-rlnorm(Nrnd, meanlog = MeanLog, sdlog = SDlog)
ValMean<-mean(Vals)
ValSD<-sd(Vals)
c(ValMean,ValSD/ValMean)

}

