function (pcCmax,PreyDensHalf,Hq,cM,PreyAb,PnAreas,PropYr,PredAb)

# Function:           B.FO.HollingGen.01
# Description:        Foraging/consumption, Holling general
# Primary attributes: Application of Holling consumption equations based on density of prey (no selectivity added)

# Input parameters:   pcCmax = per capita maximum Consumption per year
#                     PreyDensHalf = density of prey for which half when function=0.5
#                     Hq = Holling q
#                     cM  = vector of coefficients of availability  of prey in polygon
#                     PreyAb   = abundances of prey in each polygon
#                     PnAreas = areas of each prey polygon
#                     PropYr = proportion of year for time period
#                     PredAb = abundance of predators in each prey polygon
#

# Returned            Consumed = vector of amounts of prey consumed in each of the prey polygons

########################################################
#      Signature <- list(
#        ID           =  29004,
#        Name.full    = "Holling General",
#        Name.short   = "HollingGen",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "16 June 2005"
#        ) # end Signature


########################################################
{

PreyDens<-PreyAb/PnAreas
Holling<-(PreyDens^(Hq+1))/(PreyDensHalf^(Hq+1)+(PreyDens/cM+PredAb*pcCmax)^(Hq+1))
Holling*pcCmax*PropYr*PredAb
}

