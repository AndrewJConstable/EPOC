function (SSB,Rh,Rcv,RbarMax,SSBlimDens)
# Function:           B.PD.rec_BH.01
# Description:        Population dynamics, recruitment function, Beverton & Holt optoin
# Primary attributes: Application of Beverton & Holt with a CV of recruitment on SSB

# Input parameters:   SSB = spawning stock biomass
#                     Rh   = steepness parameter
#                     Rcv  = coefficient of variation (assuming constant CV)
#                     RbarMax = max mean recruitment
#                     SSBlimDens  = maximum biomass

########################################################
#      Signature <- list(
#        ID           =  29003,
#        Name.full    = "Beverton-Holt recruitment",
#        Name.short   = "B-H_recruits",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "14 June 2005"
#        ) # end Signature


########################################################
{
  Rec<-RbarMax
  if (SSBlimDens>0) Rec<-Rec*SSB/SSBlimDens/(1-(5*Rh-1)/(4*Rh)*(1-SSB/SSBlimDens))
  if (Rcv>0) Rec<-  U.ST.RandLnormNat.01(1,Rec,Rcv)[1]
Rec
}

