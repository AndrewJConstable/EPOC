function (Nrand,MeanNat,CVnat)
# Function:           U.ST.RandLnormNat.01
# Description:        Random numbers from Log Normal distribution using input mean and CV from natural domain
# Primary attributes: Input mean and CV are from natural domain rather than mean and SD from log domain
# Returns:            Vector of random numbers

# Input parameters:   Nrand    = number of random numbers in a vector
#                     MeanNat  = Mean of log normal distribution in natural domain
#                     CVnat    = CV of log normal distribution in natural domain
########################################################
#      Signature <- list(
#        ID           =  81001,
#        Name.full    = "Random deviates - log normal - natural mean & CV",
#        Name.short   = "RndLnNormDevNat",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "28 May 2005"
#        ) # end Signature


########################################################
{
    SDlog   <- sqrt(log(1+CVnat^2))
    MeanLog<- log(MeanNat)-SDlog^2/2
    rlnorm(Nrand, meanlog = MeanLog, sdlog = SDlog)

}

