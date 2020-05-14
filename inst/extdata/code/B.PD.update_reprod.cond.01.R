function (Element,              # component of Universe$Biota
          PeriodLastDay,        # the last day of the period
          PeriodYearPropn,      # the fraction of the year encompassed by the period
          dSet,                 # dataset to be used with function
          ElementTimeStep,      # the timestep for that taxon
          ElementTimeStepProp,  # the proportion of the timestep taken up in the period
          Universe              # access to universe if needed
          )                     # end input parameters

# Function:           B.PD.update_reprod.cond.01
# Version             0.01

# Description:        Population dynamics function - update reproductive condition based on consumption over a period


# Input data:         as above

# Return data:        none at present

########################################################
#      Signature <- list(
#        ID           =  29015,
#        Name.full    = "Update reproductive condition",
#        Name.short   = "Update reprod cond",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "13 June 2005"
#        ) # end Signature

#   Elements using this function
#     AFS

########################################################

{


Food<-Universe$Biota[[Element]]$Transition$accumulate$consumption

#                 $consumption is a matrix with the following columns
#                 1.  subject polygon (e.g. predator polygon in foodweb)
#                 2.  origin polygon  (e.g. prey polygon in foodweb)
#                 3.  element         (e.g. prey ref ID in foodweb)
#                 4.  units of qnty   (e.g. 1 = number, 2 = biomass)
#                 5.  quantity        (total quantity of change ie. + or -; NB this column is not to be summed as it needs to be multiplied by stagestructure)
#                 6.  proportion of year
#                 7.  ratio of food consumed/maximum that could have been consumed

#  not included at present - will need to include it if the units of qnty are the wrong units for estimating condition
#                 6.  stage age       (the age given to the stage)
#                 7.  stage proportn  (the proportion of the total quantity given to the stage)
#                 8.  calendar year


# Parameters in data set

#    Cond.R.data.01<-list(
#                       data sets to be used in different polygons
#                        dSet1 = list(
#                                   pcCmax        = pcCmax, # 1 kg per day per kilogram of predator
#                                   PredAbundUnit = PredAbundUnit,
#                                   ShapeA        = 2
#                                ), # end Set01
#                        dSet.N = 1, # number of individual datasets
#                       specify which dataset to use in each polygon
#                        UseSize        = c(1,1,1,1,1,1,1,1)   #     size at age
#                    ) # # end Cond.S.data.01


# for each polygon

# for (pn in 1:Universe$Biota[[Element]]$Polygons$Polygon.N) {


# reproductive condition is estimated as the ratio of the total amount consumed divided by the max that could
# have been consumed raised to a power (ShapeA)
# IT IS AVERAGED OVER ALL POLYGONS AT PRESENT
#
#     extract data just for the polygon of interest
        dSetPn<-dSet[[dSet$UseSize[pn]]]
#        FoodPn<-Food[is.element(Food[,1],pn),]
#        R.cond[pn]<-sum(FoodPn[,5])/sum(FoodPn[,5]/FoodPn[,7])
        R.cond<-rep((sum(Food[,5])/sum(Food[,5]/Food[,7]))^dSetPn$ShapeA,Universe$Biota[[Element]]$Polygons$Polygon.N)

#      } #     end polygon



# update State

Universe$Biota[[Element]]$State$Cond.R<-as.list(R.cond)

# reset $Transition$accumulate$consumption to null

Universe$Biota[[Element]]$Transition$accumulate$consumption<-c()


#   ############################################################################
#   return
#   ############################################################################

}

