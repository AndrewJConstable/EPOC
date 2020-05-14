function ()

# Function:           B.AB.Afurseal.SGW.01.juv.01
# Description:        Biological Element, Group Air-breathers, Antarctic Fur Seal - South Georgia - juvenile
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
      ID           = 25002,
      Name.full    = "Ant.Fur.Seal juvenile - South Georgia West",
      Name.short   = "Afurseal juv SGW",
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
               AP     = c(1,6),      # Antarctic Peninsula
               EI     = c(7,12),     # Elephant Island
               SOI    = c(13,18),    # South Orkney Islands
               SGI    = c(19,24),    # South Georgia Island
               NthWed = c(22,23),    # North Weddell Sea
               SthWed = c(16,21),    # South Weddell Sea
               CenWed = c(17),       # Central Weddell Sea
               EAP    = c(11)        # East Antarctic Peninsula
               ))

#   number of polygons

    Taxon$Polygons<-c(Taxon$Polygons,list(Polygon.N = length(Taxon$Polygons$Coords)))

#   Polygon areas (only if needed e.g. for estimating densities)

    Taxon$Polygons<-c(Taxon$Polygons,list(Polygon.Areas = c(2,2,2,2,2,2,1,1)))

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

    NatMort <- 0.357 # natural mortality rate


#   ############################################################################
#   Stage structure of element

#   list of life stages to be monitored in State

    Life.stages<-list(Stage.names=c("0","1","2","3"),Stage.ages = c(0,1,2,3))

#   number of age classes

    StageN<-length(Life.stages$Stage.ages)


#   #############################################################
#   Taxon$change.element

#   change of juveniles to non-reproductives

          AntFurSealNonReprod <- 25003 # ID number of element to which pups go to juveniles

#     new.element               [ID - reference to element in Universe$Biota]
#     prop.to.change            [list for each polygon, vector of proportions for each stage class in element
#                                     to change from this element to next
#     new.element.stage.classes [nested - list for each polygon of old element,
#                                     list for each stage class, array -
#                                     col 1 = new element polygon,
#                                     col 2 = stage class of new element,
#                                     col 3 = proportion of old stage class going to new element

# pups from this element go into 4th element of juvenile relating to grid cells 19 & 24

    Change.element.data.01<-list(
                  new.element = AntFurSealNonReprod,
                  prop.to.change = list(
               AP     = c(0,0,0,1),      # Antarctic Peninsula
               EI     = c(0,0,0,1),     # Elephant Island
               SOI    = c(0,0,0,1),    # South Orkney Islands
               SGI    = c(0,0,0,1),    # South Georgia Island
               NthWed = c(0,0,0,1),    # North Weddell Sea
               SthWed = c(0,0,0,1),    # South Weddell Sea
               CenWed = c(0,0,0,1),       # Central Weddell Sea
               EAP    = c(0,0,0,1)        # East Antarctic Peninsula
                            ), # end prop.to.change
        new.element.stage.classes=list(
               AP     = list(        # Antarctic Peninsula
                          S1 = matrix(c(1,1,0),nrow=1,ncol=3),
                          S2 = matrix(c(1,1,0),nrow=1,ncol=3),
                          S3 = matrix(c(1,1,0),nrow=1,ncol=3),
                          S4 = matrix(c(1,1,1),nrow=1,ncol=3)),
               EI     = list(      # Elephant Island
                          S1 = matrix(c(2,1,0),nrow=1,ncol=3),
                          S2 = matrix(c(2,1,0),nrow=1,ncol=3),
                          S3 = matrix(c(2,1,0),nrow=1,ncol=3),
                          S4 = matrix(c(2,1,1),nrow=1,ncol=3)),
               SOI    = list(     # South Orkney Islands
                          S1 = matrix(c(3,1,0),nrow=1,ncol=3),
                          S2 = matrix(c(3,1,0),nrow=1,ncol=3),
                          S3 = matrix(c(3,1,0),nrow=1,ncol=3),
                          S4 = matrix(c(3,1,1),nrow=1,ncol=3)),
               SGI    = list(     # South Georgia Island
                          S1 = matrix(c(4,1,0),nrow=1,ncol=3),
                          S2 = matrix(c(4,1,0),nrow=1,ncol=3),
                          S3 = matrix(c(4,1,0),nrow=1,ncol=3),
                          S4 = matrix(c(4,1,1),nrow=1,ncol=3)),
               NthWed = list(     # North Weddell Sea
                          S1 = matrix(c(5,1,0),nrow=1,ncol=3),
                          S2 = matrix(c(5,1,0),nrow=1,ncol=3),
                          S3 = matrix(c(5,1,0),nrow=1,ncol=3),
                          S4 = matrix(c(5,1,1),nrow=1,ncol=3)),
               SthWed = list(     # South Weddell Sea
                          S1 = matrix(c(6,1,0),nrow=1,ncol=3),
                          S2 = matrix(c(6,1,0),nrow=1,ncol=3),
                          S3 = matrix(c(6,1,0),nrow=1,ncol=3),
                          S4 = matrix(c(6,1,1),nrow=1,ncol=3)),
               CenWed = list(        # Central Weddell Sea
                          S1 = matrix(c(7,1,0),nrow=1,ncol=3),
                          S2 = matrix(c(7,1,0),nrow=1,ncol=3),
                          S3 = matrix(c(7,1,0),nrow=1,ncol=3),
                          S4 = matrix(c(7,1,1),nrow=1,ncol=3)),
               EAP    = list(         # East Antarctic Peninsula
                          S1 = matrix(c(8,1,0),nrow=1,ncol=3),
                          S2 = matrix(c(8,1,0),nrow=1,ncol=3),
                          S3 = matrix(c(8,1,0),nrow=1,ncol=3),
                          S4 = matrix(c(8,1,1),nrow=1,ncol=3))
               )
                 ) # end list

#   #############################################################
#   Taxon$Migration - initial spatial movement patterns

#   Funtions to update migration are:

#       Name              Input requirements to be included in data

#       PD.migrate.01     matrix of probabilities of moving from one location to another

#       The data assignment below could have different movement patterns for different timesteps
#       or could have a movement pattern that is updated routinely, such as a pattern resulting from an
#       existing pattern combined with the densities of relevant elements in the respective areas


#       NB: the migration probabilities are probabilities of moving over the course of one year
#           should these wish to be used for smaller time steps then the probabilities will need to be adjusted

    Migration.data.01<-list(
        Pattern = matrix(c(

#                      matrix of probabilities of moving from one location to another location
#                      polygon origins are columns, polygon destinations are rows

#                            Origin (data are filled rows by columns)
#                             1    2    3    4    5    6    7    8
#                            AP  ,EI  ,SOI ,SGI ,NWed,SWed,CWed,EAP
#                                                                       # Destination
                             0.55,0.0 ,0.0 ,0.0 ,0.0 ,0.0 ,0.0 ,0.3 ,   # AP
                             0.3 ,0.6 ,0.0 ,0.0 ,0.0 ,0.0 ,0.0 ,0.4 ,   # EI
                             0.05,0.3 ,0.4 ,0.0 ,0.0 ,0.0 ,0.0 ,0.0 ,   # SOI
                             0.0 ,0.0 ,0.4 ,0.8 ,0.1 ,0.0 ,0.0 ,0.0 ,   # SGI
                             0.0 ,0.0 ,0.1 ,0.2 ,0.4 ,0.1 ,0.3 ,0.0 ,   # NWed
                             0.05,0.05,0.0 ,0.0 ,0.4 ,0.4 ,0.2 ,0.1 ,   # SWed
                             0.0 ,0.05,0.1 ,0.0 ,0.1 ,0.1 ,0.4 ,0.1 ,   # CWed
                             0.05,0.0 ,0.0 ,0.0 ,0.0 ,0.4 ,0.1 ,0.1),   # EAP
                             nrow=Taxon$Polygons$Polygon.N,ncol=Taxon$Polygons$Polygon.N)
         ) # # end Migration.data.01

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

# maximum consumption per kilogram per day by predator (used below for reproductive condition)

pcCmax<-200
PredAbundUnit<-2 # units for which max consumption refers to


    FnFeed.01 <- list(Esuperba = list(FnFeed = B.FO.HollingGen.01,

                                      FnFeedParams = list(
                                                       pcCmax       = pcCmax, # 1 kg per day per kilogram of predator
                                                       PreyDensHalf = 1.0E7,
                                                       Hq           = 2,
                                                       Scale.vector = list(
                                                                      AP     = matrix(c(c(1:8),c(1,0,0,0,0,0,0,0)),nrow=8,ncol=2),      # Antarctic Peninsula
                                                                      EI     = matrix(c(c(1:8),c(0,1,0,0,0,0,0,0)),nrow=8,ncol=2),     # Elephant Island
                                                                      SOI    = matrix(c(c(1:8),c(0,0,1,0,0,0,0,0)),nrow=8,ncol=2),    # South Orkney Islands
                                                                      SGI    = matrix(c(c(1:8),c(0,0,0,1,0,0,0,0)),nrow=8,ncol=2),    # South Georgia Island
                                                                      NthWed = matrix(c(c(1:8),c(0,0,0,0,1,0,0,0)),nrow=8,ncol=2),    # North Weddell Sea
                                                                      SthWed = matrix(c(c(1:8),c(0,0,0,0,0,1,0,0)),nrow=8,ncol=2),    # South Weddell Sea
                                                                      CenWed = matrix(c(c(1:8),c(0,0,0,0,0,0,1,0)),nrow=8,ncol=2),       # Central Weddell Sea
                                                                      EAP    = matrix(c(c(1:8),c(0,0,0,0,0,0,0,1)),nrow=8,ncol=2)),        # East Antarctic Peninsula
                                                       PreyAbundUnit = 2,
                                                       PredAbundUnit = PredAbundUnit)
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

#   not activate at present except as a size at weekly age

        YrIntervals <- 52 # number of months including zero
        PupDeparture<-floor(5/12*YrIntervals) # last interval in year before pup joins juveniles

Birth.weight<-4 #kg - birth weight of pup is contingent on health of mother, which is affected by consumption

Growth.rate.pup <- 0.15 #kg/week contingent on consumption of food over the previous week by mother

Growth.rate.juv <- 0.28 #kg/week contingent on consumption of food over the previous week

Growth.interval<-1/YrIntervals # interval of growth is over one week


        # specify matrix

        size.at.age01<-matrix(0,ncol=YrIntervals,nrow=StageN)

# note that this size at age matrix is relative to the birthday and not the 1 January

      for (i in 1:StageN) {
        for (j in 1:YrIntervals) {
          size.at.age01[i,j]<-ifelse (i==1 & j<=PupDeparture,Birth.weight+(j-1)*Growth.rate.pup,
                                      size.at.age01[1,PupDeparture]+Growth.rate.juv*((i-1)*YrIntervals+j-PupDeparture))
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

    Stage.first.age<-Life.stages$Stage.ages[2] # this is to allow new natural mortality to apply in the absence of
                                                # age 0 in the latter part of year

#              default is to apply the same deterministic age structure in all areas (no plus class)
#              create age structure here and assign to a matrix
               AbN        <- exp((Life.stages$Stage.ages-Stage.first.age)*(-NatMort))


#               project to 1 January from birthday if needed (need to preserve AbN for below when developing age structure)
               AbN<-AbN*exp(-NatMort*PropYrFromBday)

#               make age class zero = 0

                AbN[1]<-0

               Taxon.AgeStructure.Default<-cbind(Life.stages$Stage.ages,as.vector(AbN/sum(AbN)))

#   Estimate abundances for each polygon at 1 January

    Init.abund<-vector("numeric",length=Taxon$Polygons$Polygon.N)

    # abundance per polygon - distribute evenly to seed the trial

    Juveniles.age.1<-10000*exp(-2.303*0.4-0.6*0.357)/Taxon$Polygons$Polygon.N

    for (i in 1:Taxon$Polygons$Polygon.N){
      # initial age structure at birthday,which was not converted to age composition, is needed here
      Init.ab<-Juveniles.age.1*AbN
      Init.abund[i]<-sum(Init.ab)
    } # end i

# estimating weight at age for 1 January
#       estimate integer of interval in size at age matrix rounded down to the nearest integer
#         estimated from
#           prop of year since birthday (above) - PropYrFromBday - and
#           number of intervals in the year less the origin i.e. YrIntervals-1

        RefInt<-floor(PropYrFromBday*(YrIntervals-1))

# size at age is at 1 January
        Taxon.Weight.at.age.Default <- size.at.age01[,RefInt]

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
               AP     = Taxon.AgeStructure.Default,
               EI     = Taxon.AgeStructure.Default,
               SOI    = Taxon.AgeStructure.Default,
               SGI    = Taxon.AgeStructure.Default,
               NthWed = Taxon.AgeStructure.Default,
               SthWed = Taxon.AgeStructure.Default,
               CenWed = Taxon.AgeStructure.Default,
               EAP    = Taxon.AgeStructure.Default
               ), # end ageStr list
       StageNames = Life.stages$Stage.names,
       Space    = Space.data.01,
       Cond.R   = list(
               AP     = 0,
               EI     = 0,
               SOI    = 0,
               SGI    = 0,
               NthWed = 0,
               SthWed = 0,
               CenWed = 0,
               EAP    = 0
                ),
       Cond.S   = list(
               AP     = Taxon.Weight.at.age.Default,
               EI     = Taxon.Weight.at.age.Default,
               SOI    = Taxon.Weight.at.age.Default,
               SGI    = Taxon.Weight.at.age.Default,
               NthWed = Taxon.Weight.at.age.Default,
               SthWed = Taxon.Weight.at.age.Default,
               CenWed = Taxon.Weight.at.age.Default,
               EAP    = Taxon.Weight.at.age.Default
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

       Summer_1     = list(calday=U.ST.DayFromDate.01(7,1),actions.N=3,actions=list(

                          consume = list(Update.fn = B.FO.Predation.02.01,
                                         dSet      = Consume.data.01),
                      migrate     = list(Update.fn = B.PD.migrate.01,    # function to be used
                                         dSet      = Migration.data.01), # pattern for input to function
                      update.size = list(Update.fn = B.PD.update_size.01,# function to be used
                                         dSet      = Cond.S.data.01)       # pattern for input to function
          ) # end actions list
        ) # end time step Summer1

#       note comma is used to append this to list

       , Adopt.pup     = list(calday=U.ST.DayFromDate.01(1,4),actions.N=4,actions=list(
                          consume = list(Update.fn = B.FO.Predation.02.01,
                                         dSet      = Consume.data.01),
                      migrate     = list(Update.fn = B.PD.migrate.01,    # function to be used
                                         dSet      = Migration.data.01), # pattern for input to function
                      update.size = list(Update.fn = B.PD.update_size.01,# function to be used
                                         dSet      = Cond.S.data.01),       # pattern for input to function
                      adopt = list(Update.fn = B.AB.Afurseal.adopt.01,# function to be used
                                         dSet      = list())       # pattern for input to function
          ) # end actions list
        ) # end time step Depart

       , Depart     = list(calday=U.ST.DayFromDate.01(24,9),actions.N=4,actions=list(
                          consume = list(Update.fn = B.FO.Predation.02.01,
                                         dSet      = Consume.data.01),

                      migrate     = list(Update.fn = B.PD.migrate.01,    # function to be used
                                         dSet      = Migration.data.01), # pattern for input to function
                      update.size = list(Update.fn = B.PD.update_size.01,# function to be used
                                         dSet      = Cond.S.data.01),       # pattern for input to function
                      change.element = list(Update.fn = B.PD.Afurseal.01.change.element.01,# function to be used
                                         dSet      = Change.element.data.01)       # pattern for input to function

          ) # end actions list
        ) # end time step Depart


       , Spring     = list(calday=U.ST.DayFromDate.01(1,12),actions.N=4,actions=list(

                          consume = list(Update.fn = B.FO.Predation.02.01,
                                         dSet      = Consume.data.01),
                      migrate     = list(Update.fn = B.PD.migrate.01,    # function to be used
                                         dSet      = Migration.data.01), # pattern for input to function
                      update.age  = list(Update.fn = B.PD.update_age.01, # receive pups as young of the year
                                         dSet      = list()),        # no need for a dataset
                      update.size = list(Update.fn = B.PD.update_size.01,# function to be used
                                         dSet      = Cond.S.data.01)       # pattern for input to function
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
        setup         = B.AB.Afurseal.SGW.01.juv.setup.01,
        update.State  = B.PD.update_State.01)

#   return Taxon environment

      Taxon

} #     end taxon

