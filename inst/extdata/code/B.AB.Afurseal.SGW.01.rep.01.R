function ()

# Function:            B.AB.Afurseal.SGW.01.rep.01
# Description:        Biological Element, Group Air-breathers, Antarctic Fur Seal - South Georgia - reproductive adults
# Primary attributes: Element incorporates juvenile age classes
#                     Age structure included in status

{


#   ############################################################################
#   Taxon - create new environment & note details of routine
#   ############################################################################

    Taxon<-new.env()

#   Signature is a unique identifier for this element
#         number applicable to Euphausia superba where 2000 series
#         is approximately second trophic level and numbers within are
#         identification numbers of the elements - all elements within a single
#         model should be unique (although the same number may be used in different versions
#         of this element

    Taxon$Signature <- list(
      ID           = 25004,
      Name.full    = "Ant.Fur.Seal reproductive adults - South Georgia West",
      Name.short   = "Afurseal RA SGW",
      Morph        = "01",
      Version      = "01",
      Authors      = "A.Constable",
      last.edit    = "22 June 2005"
      ) # end Signature


#   ############################################################################
#   Taxon$Polygons - definition
#   ############################################################################

    Taxon$Polygons<-list(
      Coords = list(
               SGW    = c(19)    # South Georgia Island West
               ))

#   number of polygons

    Taxon$Polygons<-c(Taxon$Polygons,list(Polygon.N = length(Taxon$Polygons$Coords)))

#   Polygon areas (only if needed e.g. for estimating densities)

    Taxon$Polygons<-c(Taxon$Polygons,list(Polygon.Areas = c(1)))

#   ############################################################################
#   Taxon$Birthday - point of origin for updating age and for growth parameters etc.
#   ############################################################################
#   update age on calendar date (birthday)
#       end of August

    Cday<-1
    Cmonth<-12

    Taxon$Birthday<-U.ST.DayFromDate.01(Cday,Cmonth)/365

#   ############################################################################
#   Data sets for specifying environment
#   ############################################################################

#   #############################################################
#   Parameters used to initialise environment but may be altered
#   in the Setup function and/or may not be representative of
#   the Universe e.g. natural mortality rate

    NatMort <- 0.2 # natural mortality rate


#   ############################################################################
#   Stage structure of element

#   list of life stages to be monitored in State

    Life.stages<-list(Stage.names=c("RA"),Stage.ages = c(7))

#   number of age classes

    StageN<-length(Life.stages$Stage.ages)


#   #############################################################
#   Taxon$Reproduction

#   i.   elements to which new offspring are accumulated

          inherit.offspring <- 25001 # ID number of element to which offspring go
                                    # offspring will be placed in first age class of element
                                    # inherit back to this element

# not used at present
#   ii. spawner-recruitment relationship parameters - Beverton & Holt

         spawner.recruit01<-list(
           Rh             = 0.9,     # steepness
#??
           Rcv            = 0.0,     # CV of recruit density at a given spawning biomass density

           RbarMaxDens    = 1.2,  # maximum mean density of recruits for maximum density of spawning biomass
#??

           SSBlimDens     = 0.8E3) # density of spawning biomass for which the ratio of current SSB/SSBlimDens = 1

#   iii.  distribution of offspring

#          matrix of proportions of offspring from an area going to other areas

           offspring.distn01<-matrix(c(1), nrow=1,ncol=1)

#   input parameters of different functions - could be one for each area or one for assignment to many areas
#   include datasets at the beginning and update the number of dataset (dSet.N) if more than one (1)

          Reproduce.data.01<-list(
#                       data sets to be used in different polygons
                        dSet1 = list(
                                inherit.offspring      = inherit.offspring,
                                spawner.recruit.fn     = B.PD.rec_BH.01,
                                spawner.recruit.params = spawner.recruit01,
                                offspring.distn        = offspring.distn01),
#                       add more data sets for different polygons here as needed

                        dSet.N = 1,                                # number of datasets
                                                                   # dataset from which to take appropriate parameters in the respective polygons
                        UseSpawnerRec      = c(1),   #     spawner-recruit function & params
                        UseOffspringDistn  = c(1)    #     distribution of offspring pattern
                    ) # end Set01



#   #############################################################
#   Taxon$change.element

#   change of reproductive to non-reproductives

          AntFurSealNonReprod <- 25003 # ID number of element to which reproductives go to nonreproductives

#     new.element               [ID - reference to element in Universe$Biota]
#     prop.to.change            [list for each polygon of old element, vector of proportions for each stage class in element
#                                     to change from this element to next
#     new.element.stage.classes [nested - list for each polygon of old element,
#                                     list for each stage class, array -
#                                     col 1 = new element polygon,
#                                     col 2 = stage class of new element,
#                                     col 3 = proportion of that given in prop.to.change from old stage class going to new element

# individuals from this element go into 4th element of juvenile relating to grid cells 19 & 24

    Change.element.data.01<-list(
                  new.element = AntFurSealNonReprod,
                  prop.to.change = list(
               SGI    = c(1)    # South Georgia Island
                           ), # end prop.to.change
        new.element.stage.classes=list(
              SGI    = list(     # South Georgia Island
                          S1 = matrix(c(4,1,1),nrow=1,ncol=3))
               )
                 ) # end list

#   #############################################################
#   Taxon$Space - characteristics of spatial pattern of the element in each polygon

#   Funtions to update spatial pattern parameters if needed are:

#       Name              Input requirements to be included in data

#       B.PD.space.01     to be determined

#
#   Coefficients of variation in each polygon
    Space.data.01<-list(
        CV = c(1,1,1,1,1,1,1,1)
         ) # # end Space.data.01

#   #############################################################
#   Taxon$consume

#   list of species to be consumed - use Function ID numbers to ensure the correct assignment of functions is used

    Prey.list <- list(Esuperba = 22001)

    Prey.N <- length(Prey.list)

#   Data sets of Feeding (consumption) functions to be used for each prey taxon
#   NOTE THAT ALL PREY MUST BE PRESENTED IN EACH FN.FEED LIST even though some prey may be assigned zero consumption
#   in a given period

#   ConsumeRate is a per annum rate

    FnFeed.01 <- list(Esuperba = list(FnFeed = B.FO.HollingGen.01,

                                      FnFeedParams = list(
                                                       pcCmax       = 200, # 1 kg per day per kilogram of predator
                                                       PreyDensHalf = 1.0E7,
                                                       Hq           = 2,
                                                       Scale.vector = list(matrix(c(c(1:8),c(0,0,0,0.5,0,0,0,0)),nrow=8,ncol=2)),
                                                       PreyAbundUnit = 2,
                                                       PredAbundUnit = 2)
                                      ) # end list Esuperba
                      ) # end FnFeed.01

#       Notes on the different functions
#               Euphausia superba ID 22001
#                   Holling Input parameters:
#                       pcCmax          = per abund unit - maximum Consumption per year
#                       PreyDensHalf    = density of prey for which half when function=0.5
#                       Hq              = Holling q
#                   Scale.vector        = list of matrices of coefficients of consumption rate (col 2) to be applied in each polygon of prey (col 1), one list per polygon of predator
#                   AbundUnit           = the integer pointer to which measure of abundance is being used


    Consume.data.01<-list(Prey = Prey.list, Prey.N = Prey.N, Prey.data = FnFeed.01) # end foraging data


#   #############################################################
#   Individual size condition in each polygon


        # specify matrix
        YrIntervals <- 52 # number of months including zero

        size.at.age01<-matrix(0,ncol=YrIntervals,nrow=StageN)

# note that this size at age matrix is relative to the birthday and not the 1 January

      for (i in 1:StageN) {
        for (j in 1:YrIntervals) {
          size.at.age01[i,j]<-40
        } # end j
      } # end i


    Cond.S.data.01<-list(
#                       data sets to be used in different polygons
                        dSet1 = list(
                                size.at.age = size.at.age01
                                ), # end Set01
                        dSet.N = 1, # number of individual datasets
#                       specify which dataset to use in each polygon
                        UseSize        = c(1,1,1,1,1,1,1,1)   #     size at age
                    ) # # end Cond.S.data.01


#   #############################################################
#   Health condition in each polygon

# not used???????

#   Funtions to update spatial pattern parameters if needed are:

#       Name              Input requirements to be included in data

#       B.CO.health.01     to be determined

#
#   Parameters used for updating health condition in each polygon

#   i.  health - function as proportion at age

        health01<-c(1,1,1,1)

    Cond.H.data.01<-list(
#                       data sets to be used in different polygons
                        dSet1 = list(
                                health = health01
                                ), # end Set01

#                       specify which dataset to use in each polygon
                        UseHealth        = c(1,1,1,1,1,1,1,1)   #     maturity
                    ) # # end Cond.R.data.01


#   ############################################################################
#   Taxon$State - initial characteristics
#   ############################################################################

# set up age structure as at 1 January (noting that birthday may be different)
# this means that there are no age 0 in the juveniles until April

    PropYrFromBday<-(1-Taxon$Birthday)


                AbN<-c(1)

               Taxon.AgeStructure.Default<-cbind(c(7),c(1))

#   Estimate abundances for each polygon at 1 January

    Init.abund<-vector("numeric",length=Taxon$Polygons$Polygon.N)


    # abundance per polygon - distribute evenly to seed the trial
    Reproductive<-10000*exp(-2.303*0.4-0.6*0.357)/(exp(0.163)-1)


    # half are breeding at 1 Jan

    Reproductive<-Reproductive/2

    for (i in 1:Taxon$Polygons$Polygon.N){
      # initial age structure at birthday,which was not converted to age composition, is needed here
      Init.ab<-Reproductive*AbN
      Init.abund[i]<-Init.ab
    } # end i

# estimating weight at age for 1 January
#       estimate integer of interval in size at age matrix rounded down to the nearest integer
#         estimated from
#           prop of year since birthday (above) - PropYrFromBday - and
#           number of intervals in the year less the origin i.e. YrIntervals-1


# size at age is at 1 January
        Taxon.Weight.at.age.Default <- c(40) #kg

# estimate biomass

MeanWtInd<-sum(Taxon.Weight.at.age.Default*Taxon.AgeStructure.Default[,2])

Init.biomass<-MeanWtInd*Init.abund


# declare State

    Taxon$State<-list(
       Abundance      = list(num.ind  = Init.abund,
                             mass     = Init.biomass,
                             mass.unit = "kg",
                             mass.multiplier = 1),
       StageN         = StageN,
       StageStrUnits  = 1,                # reference to which abundance units are used by each age structure
                                                           # 1 = number, 2 = biomass
       StageStr = list(
               SGW    = Taxon.AgeStructure.Default
               ), # end ageStr list
       StageNames = Life.stages$Stage.names,
       Space    = Space.data.01,
       Cond.R   = list(
               SGW    = 1
                ),
       Cond.S   = list(
               SGW    = Taxon.Weight.at.age.Default
               ), # end Cond.S list
       Cond.H   = Cond.H.data.01
       ) # end list of State


#   #############################################################
#   Taxon$TimeSteps
#   #############################################################

#   the characteristics of a time step between the previous time and the specified time (in days)
#   is given in a list(days in calendar year, number of functions to be carried out, list of named functions)
#   knife-edge functions can be included by repeating the same day

    Taxon$TimeSteps<-list(

       Summer_1     = list(calday=U.ST.DayFromDate.01(7,1),actions.N=1,actions=list(

                          consume = list(Update.fn = B.FO.Predation.02.01,
                                         dSet      = Consume.data.01)
          ) # end actions list
        ) # end time step Summer1

#       note comma is used to append this to list

       , Depart     = list(calday=U.ST.DayFromDate.01(30,3),actions.N=2,actions=list(
                          consume = list(Update.fn = B.FO.Predation.02.01,
                                         dSet      = Consume.data.01),
                      change.element = list(Update.fn = B.PD.Afurseal.01.change.element.01,# function to be used
                                         dSet      = Change.element.data.01)       # pattern for input to function
          ) # end actions list
        ) # end time step Depart

       , Adopt     = list(calday=U.ST.DayFromDate.01(30,9),actions.N=1,actions=list(
                      adopt = list(Update.fn = B.AB.Afurseal.adopt.01,# function to be used
                                         dSet      = list())       # pattern for input to function

          ) # end actions list
        ) # end time step Depart


       , Reproduce     = list(calday=U.ST.DayFromDate.01(7,10),actions.N=2,actions=list(

                          consume = list(Update.fn = B.FO.Predation.02.01,
                                         dSet      = Consume.data.01),
                      reproduce   = list(Update.fn = B.PD.reproduce.AFS.01,  # function to be used - based on Beverton & Holt relationship
                                         dSet      = Reproduce.data.01) # end reproduce
          ) # end actions list
        ) # end time step Spring
       , Spring     = list(calday=U.ST.DayFromDate.01(1,12),actions.N=1,actions=list(

                          consume = list(Update.fn = B.FO.Predation.02.01,
                                         dSet      = Consume.data.01)
          ) # end actions list
        ) # end time step Spring

      ) # end list of timesteps

    # number of timesteps

     Taxon$TimeSteps.N<-length(Taxon$TimeSteps)

#   #############################################################
#   Taxon$Ancillary.fns
#   #############################################################
#   function to undertake setup actions such as to change ID linkages to references in the relevant components

    Taxon$Ancillary.fns<-list(
        setup         = B.AB.Afurseal.SGW.01.rep.setup.01,
        update.State  = B.PD.update_State.01)

#   return Taxon environment

      Taxon

} #     end taxon

