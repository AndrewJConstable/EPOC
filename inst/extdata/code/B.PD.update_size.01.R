function (Element,              # component of Universe$Biota
          PeriodLastDay,        # the last day of the period
          PeriodYearPropn,      # the fraction of the year encompassed by the period
          dSet,                 # dataset to be used with function
          ElementTimeStep,      # the timestep for that taxon
          ElementTimeStepProp,  # the proportion of the timestep taken up in the period
          Universe              # access to universe if needed
          )                     # end input parameters

# Function:           B.PD.update_size.01
# Version             0.01

# Description:        Update the size condition of the taxon

# Notes               Does not deal with variable growth at present
#                     Currently reads off the nearest size given the time of year (will need to be improved for efficiency)

# Input data:         as above
#                     dSet : required data for function
#                             list of the following
#                             individual parameter sets in a list (number is indicated in dSet.N)
#                             that may be applied in different polygons
#                             Each parameter set has
#                                 size.at.age             [a matrix of size at age with each row representing a Stage
#                                                          and each column the size at the end of each period in the year]

#                          dSet.N = 1,                    [number of datasets]
#                                                         [dataset from which to take appropriate parameters in the respective polygons]
#                          UseSize                            [size]


# Return data:        none at present - added directly to Transition

########################################################
#      Signature <- list(
#        ID           =  29009,
#        Name.full    = "Update size condition",
#        Name.short   = "Update Size",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "13 June 2005"
#        ) # end Signature

#   Elements using this function
#     E. superba    ID = 22001

########################################################

{

# update size at Stage condition in Element by reading off size at time of year

# first alter the times relative to the start of the year to become relative to the birthday (g.origin)

FracYear<-PeriodLastDay/365
g.origin<-Universe$Biota[[Element]]$Birthday

TimeInGrowthYear <- ifelse (FracYear < g.origin,(1-g.origin+FracYear),(FracYear-g.origin))

for (pn in 1:Universe$Biota[[Element]]$Polygons$Polygon.N) {

  # need to develop efficiencies here
  tsteps<-ncol(dSet[[dSet$UseSize[pn]]]$size.at.age)-1

  dSetCol<-floor(tsteps*TimeInGrowthYear)+1

  Universe$Biota[[Element]]$State$Cond.S[[pn]]<-dSet[[dSet$UseSize[pn]]]$size.at.age[,dSetCol]

  # update biomass

  Universe$Biota[[Element]]$State$Abundance[[2]][pn]<-sum(Universe$Biota[[Element]]$State$Abundance[[1]][pn]*
                                                      Universe$Biota[[Element]]$State$StageStr[[pn]][,2]*
                                                      dSet[[dSet$UseSize[pn]]]$size.at.age[,dSetCol])

} # end pn

#   ############################################################################
#   return
#   ############################################################################

}

