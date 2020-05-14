function (Element,              # component of Universe$Biota
          PeriodLastDay,        # the last day of the period
          PeriodYearPropn,      # the fraction of the year encompassed by the period
          dSet,                 # dataset to be used with function
          ElementTimeStep,      # the timestep for that taxon
          ElementTimeStepProp,  # the proportion of the timestep taken up in the period
          Universe              # access to universe if needed
          )                     # end input parameters

# Function:           B.PD.reproduce.01
# Version             0.01

# Description:        Population dynamics function - reproduction version 1

# Primary attributes: produce offspring

# Input data:         as above
#                     dSet : required data for function
#                             list of the following
#                             individual parameter sets in a list (number is indicated in dSet.N)
#                             that may be applied in different polygons
#                             Each parameter set has
#                                 inherit.offspring       [ID - reference to element in Universe$Biota]
#                                 maturity                [vector of maturity ogive specific to age structure]
#                                 spawner.recruit.fn      [function to determine offspring]
#                                 spawner.recruit.params  [parameters for function]
#                                 offspring.distn         [matrix of proportions from origin (cols) to destination (rows)]

#                          dSet.N = 1,                    [number of datasets]
#                                                         [dataset from which to take appropriate parameters in the respective polygons]
#                          UseMaturity                        [maturity]
#                          UseSpawnerRec                      [spawner-recruit function & params]
#                          UseOffspringDistn                  [distribution of offspring pattern]


# Return data:        none at present - added directly to Transition

########################################################
#      Signature <- list(
#        ID           =  29001,
#        Name.full    = "Reproduction - function 01",
#        Name.short   = "Reprod01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "12 June 2005"
#        ) # end Signature

#   Elements using this function
#     E. superba    ID = 22001

########################################################

{

# estimate density of spawning biomass in each polygon

    SBdens<-vector("numeric",length=Universe$Biota[[Element]]$Polygons$Polygon.N)
    Young<-SBdens

for (pn in 1:Universe$Biota[[Element]]$Polygons$Polygon.N) {

    AgeVector<-Universe$Biota[[Element]]$State$StageStr[[pn]][,2]*  # stage structure
               Universe$Biota[[Element]]$State$Abundance$num.ind[pn]/
               Universe$Biota[[Element]]$Polygons$Polygon.Areas[pn]* # density of individuals
               Universe$Biota[[Element]]$State$Cond.R[[Universe$Biota[[Element]]$State$Cond.R$UseMaturity[pn]]]$maturity # maturity at age
    SBdens[pn]<-sum(AgeVector*Universe$Biota[[Element]]$State$Cond.S[[pn]]) # sum of mature size at age
} # end pn

# estimate density of offspring from function for each polygon and convert to total offspring using area of polygon

for (i in 1:Universe$Biota[[Element]]$Polygons$Polygon.N) {
    Young[i]<-Universe$Biota[[Element]]$Polygons$Polygon.Areas[i]*
                  dSet[[dSet$UseSpawnerRec[i]]]$spawner.recruit.fn(
                             SBdens[i],
                             dSet[[dSet$UseSpawnerRec[i]]]$spawner.recruit.params$Rh,     # steepness
                             dSet[[dSet$UseSpawnerRec[i]]]$spawner.recruit.params$Rcv,     # CV of recruit density at a given spawning biomass density
                             dSet[[dSet$UseSpawnerRec[i]]]$spawner.recruit.params$RbarMaxDens,  # maximum mean density of recruits for maximum density of spawning biomass
                             dSet[[dSet$UseSpawnerRec[i]]]$spawner.recruit.params$SSBlimDens) # density of spawning biomass for which the ratio of current SSB/SSBlimDens = 1
    } # end i

# distribute offspring to first stage of the element inheriting the offspring in the appropriate polygons

    YoungDistn<-matrix(0,nrow=Universe$Biota[[Element]]$Polygons$Polygon.N,ncol=Universe$Biota[[Element]]$Polygons$Polygon.N)

for (i in 1:Universe$Biota[[Element]]$Polygons$Polygon.N) {
    YoungDistn[,i]<-Young[i]*dSet[[dSet$UseOffspringDistn[i]]]$offspring.distn[,i]
    } # end i

# update appropriate transition environment

for (i in 1:Universe$Biota[[Element]]$Polygons$Polygon.N) {
    Young[i]<-sum(YoungDistn[i,])
#   at this point, the quantity will need to be converted to the appropriate quantity of abundance used in the polygon
#   not done at this stage ????
   } # end i

Universe$Biota[[Element]]$Transition$accumulate$offspring<-Universe$Biota[[Element]]$Transition$accumulate$offspring+Young

#   ############################################################################
#   return
#   ############################################################################

}

