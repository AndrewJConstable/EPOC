function (Element,              # component of Universe$Biota
          PeriodLastDay,        # the last day of the period
          PeriodYearPropn,      # the fraction of the year encompassed by the period
          dSet,                 # dataset to be used with function
          ElementTimeStep,      # the timestep for that taxon
          ElementTimeStepProp,  # the proportion of the timestep taken up in the period
          Universe              # access to universe if needed
          )                     # end input parameters


# Function:           B.PD.reproduce.AFS.01
# Version             0.01

# Description:        Population dynamics function - reproduction version Ant Fur seals 1 - based on per capita reproductive condition

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
#        ID           =  29013,
#        Name.full    = "Reproduction - function fur seals 01",
#        Name.short   = "ReprodAFS01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "22 June 2005"
#        ) # end Signature

#   Elements using this function
#

########################################################

{

# estimate density of spawning biomass in polygon of element

#    SBdens<-vector("numeric",length=Universe$Biota[[Element]]$Polygons$Polygon.N)
#Elementprime<-Element

#Element<-1 # to link to krill

#SBdens<-0
#    Young<-SBdens
#
# for (pn in 1:Universe$Biota[[Element]]$Polygons$Polygon.N) {
#
#    AgeVector<-Universe$Biota[[Element]]$State$StageStr[[pn]][,2]*  # stage structure
##               Universe$Biota[[Element]]$State$Abundance$num.ind[pn]/
#               Universe$Biota[[Element]]$Polygons$Polygon.Areas[pn]* # density of individuals
#               Universe$Biota[[Element]]$State$Cond.R[[Universe$Biota[[Element]]$State$Cond.R$UseMaturity[pn]]]$maturity # maturity at age
#    SBdens<-SBden+sum(AgeVector*Universe$Biota[[Element]]$State$Cond.S[[pn]])*Universe$Biota[[Element]]$Polygons$Polygon.Area[pn] # sum of mature size at age
# } # end pn
# SBdens<-SBdens/16 # recorrection from this cobbled code

# estimate density of offspring from function for each polygon and convert to total offspring using area of polygon

# for (i in 1:Universe$Biota[[Element]]$Polygons$Polygon.N) {
#    Young<-
#                  dSet[[dSet$UseSpawnerRec[pn]]]$spawner.recruit.fn(
#                             SBdens,
#                             dSet[[dSet$UseSpawnerRec[1]]]$spawner.recruit.params$Rh,     # steepness
#                             dSet[[dSet$UseSpawnerRec[1]]]$spawner.recruit.params$Rcv,     # CV of recruit density at a given spawning biomass density
#                             dSet[[dSet$UseSpawnerRec[1]]]$spawner.recruit.params$RbarMaxDens,  # maximum mean density of recruits for maximum density of spawning biomass
#                             dSet[[dSet$UseSpawnerRec[1]]]$spawner.recruit.params$SSBlimDens) # density of spawning biomass for which the ratio of current SSB/SSBlimDens = 1
#    } # end i

# multiply young by number of seals ?????????

# calculate young from per capita reproductive condition by number of reproductive individuals

Young<-Universe$Biota[[Element]]$State$Cond.R[[1]]*Universe$Biota[[Element]]$State$Abundance$num.ind[1]

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

#?? note that this needs to be made general

Universe$Biota[[dSet[[1]]$inherit.offspring]]$Transition$accumulate$offspring<-Universe$Biota[[dSet[[1]]$inherit.offspring]]$Transition$accumulate$offspring+Young

#   ############################################################################
#   return
#   ############################################################################

}

