function ()

# Function:           B.G_.pred_unknown.01.01
# Description:        Biological Element, Group general, unknown predation across whole arena for nominated prey
#
# Primary attributes: Element has only one life stage that does not accumulate mass or number following predation
#                     - biomass lost to the model system
#                     Trial of some routines

{


#   ############################################################################
#   Taxon - create new environment & note details of routine
#   ############################################################################

    Taxon<-new.env()

#   Signature is a unique identifier for this element
#         number applicable to predator of Euphausia superba where 3000 series
#         is approximately third trophic level and numbers within are
#         identification numbers of the elements - all elements within a single
#         model should be unique (although the same number may be used in different versions
#         of this element

    Taxon$Signature <- list(
      ID           = 28001,
      Name.full    = "Predator general - Area 48 - unknown",
      Name.short   = "Pred_unknown_Area_48",
      Morph        = "01",
      Version      = "01",
      Authors      = "A.Constable",
      last.edit    = "14 June 2005"
      ) # end Signature


#   ############################################################################
#   Taxon$Polygons - definition
#   ############################################################################

    Taxon$Polygons<-list(
      Coords = list(
        Area48 = c(1:25)     # whole of Area 48 - southwest Atlantic
        ))

#   number of polygons

    Taxon$Polygons<-c(Taxon$Polygons,list(Polygon.N = length(Taxon$Polygons$Coords)))

#   Polygon areas (only if needed e.g. for estimating densities)

    Taxon$Polygons<-c(Taxon$Polygons,list(Polygon.Areas = c(25)))


#   ############################################################################
#   Taxon$Birthday - point of origin for updating age and for growth parameters etc.
#   ############################################################################
#   update age on calendar date (birthday)
#       end of August

    Cday<-1
    Cmonth<-9

    Taxon$Birthday<-U.ST.DayFromDate.01(Cday,Cmonth)/365

#   ############################################################################
#   Data sets for specifying environment
#   ############################################################################

#   #############################################################
#   Parameters used to initialise environment but may be altered
#   in the Setup function and/or may not be representative of
#   the Universe e.g. natural mortality rate

    NatMort <- 0. # natural mortality rate
    NatMort.prerecruit <- 0. # natural mortality rate prior to recruitment to first stage of this element
#                             # used in setting up initial density of first stage derived from maximum output
#                             # of offspring density in reproduction

#   update age on calendar date (birthday)
#       end of August

    Cday<-1
    Cmonth<-1
    Update.age.date<-U.ST.DayFromDate.01(Cday,Cmonth)

#   ############################################################################
#   State structure of element

#   list of life stages to be monitored in State
#     only need one life stage in this case

    Life.stages<-list(Stage.names=c("1"),Stage.ages = c(0))

#   number of age classes

    StageN<-length(Life.stages$Stage.ages)



#   #############################################################
#   Taxon$consume

#   list of species to be consumed - use Function ID numbers to ensure the correct assignment of functions is used

    Prey.list <- list(Esuperba = 22001,AFSpup = 25001, AFSjuv = 25002, AFSnr = 25003, AFSra = 25004)

    Prey.N <- length(Prey.list)

#   Data sets of Feeding (consumption) functions to be used for each prey taxon
#   NOTE THAT ALL PREY MUST BE PRESENTED IN EACH FN.FEED LIST even though some prey may be assigned zero consumption
#   in a given period

#   ConsumeRate is a per annum rate

    FnFeed.01 <- list(
                      Esuperba = list(FnFeed = B.FO.FFtypeI.01,

                                      FnFeedParams = list(ConsumeRate = c(0.15), # was (0.33)

                                                          Scale.vector = list(matrix(c(c(1:8),c(1,1,1,1,1,1,1,1)),nrow=8,ncol=2)),
                                                          AbundUnit = 1)
                                      ), # end list Esuperba
                      AFSpup = list(FnFeed = B.FO.FFtypeI.01,

                                      FnFeedParams = list(ConsumeRate = c(0.9), # was (0.33)

                                                          Scale.vector = list(matrix(c(c(1),c(1)),nrow=1,ncol=2)),
                                                          AbundUnit = 1)
                                      ), # end list Esuperba
                      AFSjuv = list(FnFeed = B.FO.FFtypeI.01,

                                      FnFeedParams = list(ConsumeRate = c(0.3), # was 0.10

                                                          Scale.vector = list(matrix(c(c(1:8),c(1,1,1,1,1,1,1,1)),nrow=8,ncol=2)),
                                                          AbundUnit = 1)
                                      ), # end list Esuperba
                      AFSnr = list(FnFeed = B.FO.FFtypeI.01,

                                      FnFeedParams = list(ConsumeRate = c(0.15), # was 0.04

                                                          Scale.vector = list(matrix(c(c(1:8),c(1,1,1,1,1,1,1,1)),nrow=8,ncol=2)),
                                                          AbundUnit = 1)
                                      ), # end list Esuperba
                      AFSra = list(FnFeed = B.FO.FFtypeI.01,

                                      FnFeedParams = list(ConsumeRate = c(0.15), # was 0.08

                                                          Scale.vector = list(matrix(c(c(1),c(1)),nrow=1,ncol=2)),
                                                          AbundUnit = 1)
                                      ) # end list Esuperba
                      ) # end FnFeed.01

#       Notes on the different functions
#               Euphausia superba ID 22001
#                   ConsumeRatePerAnnum = vector given for all polygons, for year (will need to be adjusted for each time interval over which consumption occurs)
#                                         could add parameters here for specifying a period of the year to which this rate applies
#                   Scale.vector        = list of matrices of coefficients of consumption rate (col 2) to be applied in each polygon of prey (col 1), one list per polygon of predator
#                   AbundUnit          = the integer pointer to which measure of abundance is being used


    Consume.data.01<-list(Prey = Prey.list, Prey.N = Prey.N, Prey.data = FnFeed.01) # end foraging data


#   ############################################################################
#   Taxon$State - initial characteristics
#   ############################################################################

# set up age structure as at 1 January (noting that birthday may be different)

    PropYrFromBday<-(1-(Update.age.date-1)/365)

#   default is to have all in one age at beginning with no number or mass

    Taxon.AgeStructure.Default<-cbind(as.vector(Life.stages$Stage.ages),c(1))

# declare State

    Taxon$State<-list(
       Abundance      = list(num.ind         = 1,
                             mass            = 1,
                             mass.unit       = "t",
                             mass.multiplier = 1),
       StageN         = StageN,
       StageStrUnits  = 1,                # reference to which abundance units are used by each age structure
                                                           # 1 = number, 2 = biomass
       StageStr       = list(
                            Area48 = Taxon.AgeStructure.Default
                          ), # end ageStr list
       StageNames     = Life.stages$Stage.names,
       ) # end list of State



#   #############################################################
#   Taxon$TimeSteps
#   #############################################################



    Taxon$TimeSteps<-list(
       Consume.01   = list(calday=U.ST.DayFromDate.01(31,7),actions.N=1,actions=list(

                          consume = list(Update.fn = B.FO.Predation.01.01,
                                         dSet      = Consume.data.01)
#       , No.action.01 = list(calday=U.ST.DayFromDate.01(31,3),actions.N=0,actions=list()) # end time step

                        ) # end actions list
                  ) # end time step (note the need for a comma here but not on the last time step


      ) # end list of timesteps


    # number of timesteps

     Taxon$TimeSteps.N<-length(Taxon$TimeSteps)

#   #############################################################
#   Taxon$Ancillary.fns
#   #############################################################
#   function to undertake setup actions such as to change ID linkages to references in the relevant components

    Taxon$Ancillary.fns<-list(
        setup         = B.G_.pred_unknown.01.setup.01)

#   return Taxon environment

      Taxon


} #     end taxon

