function (Element,              # component of Universe$Biota
          PeriodLastDay,        # the last day of the period
          PeriodYearPropn,      # the fraction of the year encompassed by the period
          dSet,                 # dataset to be used with function
          ElementTimeStep,      # the timestep for that taxon
          ElementTimeStepProp,  # the proportion of the timestep taken up in the period
          Universe              # access to universe if needed
          )                     # End input parameters

# Function:           B.FO.Predation.02.01
# Description:        Predation in a time step using Holling General

# Notes:

# Input data:         as above
#                     dSet : required data for function
#                             list of the following
#
#                             Data include
#                                     Prey = Prey.list      : list of reference pointers of all elements that could be exploited
#                                                             note - names in list should be identical to names in datasets (these are used as pointers)
#                                     Prey.N = Prey.N       : number of prey in list
#                                     Prey.data = FnFeed.01 : list
#                                         one list per prey type used in period (names of each list item must match those in Prey list
#                                             FnFeed        : function of feeding relationship with prey,
#                                             FnFeedParams  : list of parameters for function
#                                                             e.g. list(ConsumeRatePerAnnum = vector (one for each polygon)
#                                                             Scale.vector = list one for each polygon
#                                                             (matrices of coefficients in prey polygons - col 1 = prey polygon, col 2 = coeffs),
#                                                             PreyAbundUnit = 1))

# Return data:


########################################################
#      Signature <- list(
#        ID           =  29005,
#        Name.full    = "Predation function 02",
#        Name.short   = "Predation02",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "14 June 2005"
#        ) # end Signature

#   Elements using this function
#     General predator    ID = 28001

########################################################


{

# loop through prey in Prey.data (noting that not all prey in Prey list might be listed for a given time step

pnPreyNames<-attributes(dSet$Prey.data)$names

for (prey in 1:length(pnPreyNames)) {

# identify name of prey and get reference pointer from Prey list using name
PreyRefID     <- dSet$Prey[[pnPreyNames[prey]]]
PreyAbundUnit <- dSet$Prey.data[[prey]]$FnFeedParams$PreyAbundUnit
PredAbundUnit <- dSet$Prey.data[[prey]]$FnFeedParams$PredAbundUnit

# loop through the different polygons of predator

  for (pnPred in 1: Universe$Biota[[Element]]$Polygons$Polygon.N){

#     loop through the different polygons of prey
      for (pnPrey in 1: Universe$Biota[[PreyRefID]]$Polygons$Polygon.N){

#       only consume in the prey polygon if the scale vector has a value greater than zero for this polygon
#       and that there is prey to consume

        if (dSet$Prey.data[[prey]]$FnFeedParams$Scale.vector[[pnPred]][pnPrey,2]>0 &
            Universe$Biota[[PreyRefID]]$State$Abundance[[1]][pnPrey]>0) {

#             get abundance (based on nominated unit for prey by predator) of prey and use functional feeding relationship to determine consumption
              PreyAbund<-Universe$Biota[[PreyRefID]]$State$Abundance[[PreyAbundUnit]][pnPrey]

#             parse age and proportion of Stage Structure to feeding function

                PreyStageStr<-Universe$Biota[[PreyRefID]]$State$StageStr[[pnPrey]]

#                   if using agestructure in selection then will need to convert agestructure to the measure of abundance if
#                   age structure is given for the other measure of abundance

      # ?? note this will fall over if PreyStageStr has only one row - it will not be a matrix

      if (PreyAbundUnit != Universe$Biota[[PreyRefID]]$State$StageStrUnits) {

                      # if need biomass from ind.num structure then multiply StageStr * ind.num * SizeCondition
                      #       then divide by sum of the result to give new structure

                        if (PreyAbundUnit==2) {
                           PreyStageStr[,2]<-Universe$Biota[[PreyRefID]]$State$Abundance[[1]][pnPrey]*PreyStageStr[,2]*
                                             Universe$Biota[[PreyRefID]]$State$Cond.S[[pnPrey]]
                           PreyStageStr[,2]<-PreyStageStr[,2]/sum(PreyStageStr[,2])

                        } # end convert to biomass

                      # if need ind.num from biomass structure then multiply StageStr * Biomass / SizeCondition
                      #       then divide by sum of the result to give new structure

                         if (PreyAbundUnit==1) {
                           PreyStageStr[,2]<-Universe$Biota[[PreyRefID]]$State$Abundance[[2]][pnPrey]*PreyStageStr[,2]/
                                             Universe$Biota[[PreyRefID]]$State$Cond.S[[pnPrey]]
                           PreyStageStr[,2]<-PreyStageStr[,2]/sum(PreyStageStr[,2])

                        } # end convert to number
                     } # end convert age structure

#             call feeding function to get consumption and stage structure of consumed prey
#             in this case, no stage structure is used - therefore StageStructure is as it was before

         pData<-dSet$Prey.data[[prey]]$FnFeedParams
          PreyConsumed<-dSet$Prey.data[[prey]]$FnFeed(
                             pData$pcCmax,
                             pData$PreyDensHalf,
                             pData$Hq,
                             dSet$Prey.data[[prey]]$FnFeedParams$Scale.vector[[pnPred]][pnPrey,2], #scale vector
                             PreyAbund,
                             Universe$Biota[[PreyRefID]]$Polygons$Polygon.Areas[pnPrey],
                             PeriodYearPropn,
                             Universe$Biota[[Element]]$State$Abundance[[PredAbundUnit]][pnPred])

#             as a vector is returned - just accept the first value

                preyC<-PreyConsumed[1]


#######################################################################################################
#             update $Transition$accumulate$consumption


#               check to see that prey have been consumed before invoking this routine

                if(preyC>0) {

# ????NB this does not include variables 6-9 below

#                NewConsumption<-as.matrix(data.frame(c(list(pnPred,pnPrey,PreyRefID,PreyAbundUnit,preyC),list(PreyStageStr))))

                NewConsumption<-c(pnPred,pnPrey,PreyRefID,PreyAbundUnit,preyC,PeriodYearPropn,
                                  preyC/(pData$pcCmax*Universe$Biota[[Element]]$State$Abundance[[PredAbundUnit]][pnPred]*PeriodYearPropn))
                dimnames(NewConsumption)<-NULL
                Universe$Biota[[Element]]$Transition$accumulate$consumption<-rbind(Universe$Biota[[Element]]$Transition$accumulate$consumption,NewConsumption)

#                 $consumption is a matrix with the following columns
#                 1.  subject polygon (e.g. predator polygon in foodweb)
#                 2.  origin polygon  (e.g. prey polygon in foodweb)
#                 3.  element         (e.g. prey ref ID in foodweb)
#                 4.  units of qnty   (e.g. 1 = number, 2 = biomass)
#                 5.  quantity        (total quantity of change ie. + or -; NB this column is not to be summed as it needs to be multiplied by stagestructure)
#                 6.  proportion of year # not included at present
#                 7.  ratio of quantity/max that could have been consumed

#    ??? excluded at present
#                 6.  stage age       (the age given to the stage)
#                 7.  stage proportn  (the proportion of the total quantity given to the stage)
#                 8.  calendar year # not included at present


#             update $Transition$change
#                 convert consumption to correct abundance units for prey if needed

#                   as no agestructure was used in consumption the adjustment to the other abundance is proportional

                    if (PreyAbundUnit != Universe$Biota[[PreyRefID]]$State$StageStrUnits) {

                      # if need ind.num when biomass was consumed

                        if (PreyAbundUnit==2) {
                          preyC<-preyC/PreyAbund*Universe$Biota[[PreyRefID]]$State$Abundance[[1]][pnPrey]
                        } # end convert from biomass to number

                      # if need biomass when ind.num was consumed

                         if (PreyAbundUnit==1) {
                          preyC<-preyC/PreyAbund*Universe$Biota[[PreyRefID]]$State$Abundance[[2]][pnPrey]
                        } # end convert from number to biomass
                     } # end convert age structure


#                 if no requirement for selectivity then return the StageStr of the prey as the stage composition consumed
#                 otherwise return the selected proportions

#               note that the change in abundance through consumption is negative
                preyC <- (-preyC)
                NewChange<-as.matrix(data.frame(c(list(pnPrey,pnPred,1,Element,Universe$Biota[[PreyRefID]]$State$StageStrUnits,
                              preyC),list(PreyStageStr))))
                dimnames(NewChange)<-NULL

                Universe$Biota[[PreyRefID]]$Transition$change<-rbind(Universe$Biota[[PreyRefID]]$Transition$change,NewChange)

#                  columns in Change matrix
#                        1.  subject polygon (e.g. destination polygon in migrate; prey polygon in foodweb)
#                        2.  origin polygon  (e.g. origin polygon in migrate; predator polygon in foodweb)
#                        3.  module          (e.g. Biota = 1)
#                        4.  element         (e.g. ref ID for migrate element or predator ref ID in foodweb)
#                        5.  units of qnty   (e.g. 1 = number, 2 = biomass)
#                        6.  quantity        (total quantity of change ie. + or -; NB this column is not to be summed as it needs to be multiplied by stagestructure)
#                        7.  stage age       (the age given to the stage)
#                        8.  stage proportn  (the proportion of the total quantity given to the stage)

#   ############################################################################
        } # if prey consumed

      } # end if scale.vector[pnPrey]>0
    } # end loop through prey polgyons

  } #     end loop through predator polgyons

} # end loop through prey


}

