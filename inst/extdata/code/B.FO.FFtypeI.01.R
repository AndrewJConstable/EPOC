function (consRate,cM,Ab)
# Function:           B.FO.FFtypeI.01
# Description:        Foraging/consumption, Holling Type I 01
# Primary attributes: Application of Holling Type I consumption based on natural mortality rate

# Input parameters:   consRate = consumption rate over the period
#                     cM  = vector of coefficients of availability  of prey in polygon
#                     Ab   = abundances of prey in each polygon

# Returned            Consumed = vector of amounts of prey consumed in each of the prey polygons

########################################################
#      Signature <- list(
#        ID           =  29004,
#        Name.full    = "Holling Type I - M",
#        Name.short   = "H Type I - M",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "16 June 2005"
#        ) # end Signature


########################################################
{
Ab*cM*consRate
}

