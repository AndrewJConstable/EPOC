function ()

# Function:           B.AB.Afurseal.SGW.01.pup.01
# Description:        Biological Element, Group Air-breathers, Antarctic Fur Seal - South Georgia - pup
# Primary attributes: Pup is for part of the year before it joins juveniles
#                     Health is updated based on consumption of prey and health of reproductive life stage
#                     Growth can occur during the life of the pup before it goes to sea using a look-up table
#                     No migration
#

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
      ID           = 25001,
      Name.full    = "Ant.Fur.Seal pup - South Georgia West",
      Name.short   = "Afurseal pup SGW",
      Morph        = "01",
      Version      = "01",
      Authors      = "A.Constable",
      last.edit    = "19 June 2005"
      ) # end Signature


#   ############################################################################
#   Taxon$Polygons - definition
#   ############################################################################

    Taxon$Polygons<-list(
      Coords = list(
               SGI    = c(19)    # west South Georgia Island
               ))

#   number of polygons

    Taxon$Polygons<-c(Taxon$Polygons,list(Polygon.N = length(Taxon$Polygons$Coords)))

#   Polygon areas (only if needed e.g. for estimating densities)

    Taxon$Polygons<-c(Taxon$Polygons,list(Polygon.Areas = c(1)))

#   ############################################################################
#   Taxon$Birthday - point of origin for updating age and for growth parameters etc.
#   ############################################################################
#   update age on calendar date (birthday) [in this case, used for generating
#     growth increments]

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

    NatMort <- 0.4 # natural mortality rate

#   ############################################################################
#   State structure of element

#   list of life stages to be monitored in State
#

    Life.stages<-list(Stage.names=c("Pup"),Stage.ages = c(0))

#   number of stage classes

    StageN<-length(Life.stages$Stage.ages)


#   #############################################################
#   Taxon$change.stage

#   change of pups to juveniles

          AntFurSealjuvenile <- 25002 # ID number of element to which pups go to juveniles

    Change.stage.data.01<-list(new.stage = AntFurSealjuvenile)
#   i.   elements to which new offspring are accumulated

#   #############################################################
#   Taxon$Space - characteristics of spatial pattern of the element in each polygon

#   Funtions to update spatial pattern parameters if needed are:

#       Name              Input requirements to be included in data

#       B.PD.space.01     to be determined

#
#   Coefficients of variation in each polygon
    Space.data.01<-list(
        CV = c(0.1)
         ) # # end Space.data.01


#   #############################################################
#   Individual size condition in each polygon

#   not activate at present except as a size at weekly age

        YrIntervals <- 52 # number of months including zero

Birth.weight<-4 #kg - birth weight is contingent on health of mother, which is affected by consumption

Growth.rate <- 0.15 #kg/week contingent on consumption of food over the previous week by mother

Growth.interval<-1/YrIntervals # interval of growth is over one week


        # specify matrix

        size.at.age01<-matrix(0,ncol=YrIntervals,nrow=StageN)

# note that this size at age matrix is relative to the birthday and not the 1 January

      for (i in 1:StageN) {
        for (j in 1:YrIntervals) {
          size.at.age01[i,j]<-Birth.weight+(j-1)*Growth.rate
        } # end j
      } # end i


    Cond.S.data.01<-list(
#                       data sets to be used in different polygons
                        dSet1 = list(
                                size.at.age = size.at.age01
                                ), # end Set01
                        dSet.N = 1, # number of individual datasets
#                       specify which dataset to use in each polygon
                        UseSize        = c(1)   #     size at age
                    ) # # end Cond.S.data.01


#   #############################################################
#   Health condition in each polygon

#   Funtions to update spatial pattern parameters if needed are:

#       Name              Input requirements to be included in data

#       B.CO.health.01     to be determined

#
#   Parameters used for updating health condition in each polygon

#   i.  health - should be updated on the basis of growth history (mother's food consumption)

        health01<-c(1)

    Cond.H.data.01<-list(
#                       data sets to be used in different polygons
                        dSet1 = list(
                                health = health01
                                ), # end Set01

#                       specify which dataset to use in each polygon
                        UseHealth        = c(1)   #     maturity
                    ) # # end Cond.R.data.01


#   ############################################################################
#   Taxon$State - initial characteristics
#   ############################################################################

# set up stage structure as at 1 January (noting that birthday may be different)

               AbN<- c(1)

#               project to 1 January from birthday if needed (need to preserve AbN for below when developing age structure)
               AbN<-AbN*exp(-NatMort*PropYrFromBday)

               Taxon.AgeStructure.Default<-cbind(Life.stages$Stage.ages,as.vector(AbN))

#   Estimate abundances for each polygon at 1 January

    Init.abund<-vector("numeric",length=Taxon$Polygons$Polygon.N)
      Init.dens.rec<-1000

    for (i in 1:Taxon$Polygons$Polygon.N){
      # initial age structure at birthday,which was not converted to age composition, is needed here
      Init.dens<-Init.dens.rec*AbN
      Init.abund[i]<-sum(Init.dens)*Taxon$Polygons$Polygon.Areas[i]
    } # end i

# estimating weight at age for 1 January
#       estimate integer of interval in size at age matrix rounded down to the nearest integer
#         estimated from
#           prop of year since birthday (above) - PropYrFromBday - and
#           number of intervals in the year less the origin i.e. YrIntervals-1

        RefInt<-floor(PropYrFromBday*(YrIntervals-1))

# size at age is at 1 January
        Taxon.Weight.at.age.Default <- size.at.age01[,1]

# estimate biomass

MeanWtInd<-sum(Taxon.Weight.at.age.Default*Taxon.AgeStructure.Default[,2])

Init.biomass<-MeanWtInd*Init.abund

# declare State

    Taxon$State<-list(
       Abundance      = list(num.ind  = Init.abund,
                             mass     = Init.biomass,
                             mass.unit = "t",
                             mass.multiplier = 1),
       StageN         = StageN,
       StageStrUnits  = 1,                # reference to which abundance units are used by each age structure
                                                           # 1 = number, 2 = biomass
       StageStr = list(
               SGW    = Taxon.AgeStructure.Default
               ), # end ageStr list
       StageNames = Life.stages$Stage.names,
       Space    = Space.data.01,
       Cond.R   = Cond.R.data.01,
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

       Summer_1     = list(calday=U.ST.DayFromDate.01(1,1),actions.N=1,actions=list(

                      update.size = list(Update.fn = B.PD.update_size.01,# function to be used
                                         dSet      = Cond.S.data.01)       # pattern for input to function
          ) # end actions list
        ) # end time step Summer

       , Summer_2     = list(calday=U.ST.DayFromDate.01(1,2),actions.N=1,actions=list(

                      update.size = list(Update.fn = B.PD.update_size.01,# function to be used
                                         dSet      = Cond.S.data.01)       # pattern for input to function
          ) # end actions list
        ) # end time step Summer

       , Summer_3     = list(calday=U.ST.DayFromDate.01(1,3),actions.N=1,actions=list(

                      update.size = list(Update.fn = B.PD.update_size.01,# function to be used
                                         dSet      = Cond.S.data.01)       # pattern for input to function
          ) # end actions list
        ) # end time step Summer

#       note comma is used to append this to list

       , Depart     = list(calday=U.ST.DayFromDate.01(31,3),actions.N=2,actions=list(

                      update.size = list(Update.fn = B.PD.update_size.01,# function to be used
                                         dSet      = Cond.S.data.01),       # pattern for input to function
                      change.stage = list(Update.fn = B.AB.Afurseal.SGW.01.pup.change.stage.01,# function to be used
                                         dSet      = Change.stage.data.01)       # pattern for input to function

          ) # end actions list
        ) # end time step Depart



       , Spring     = list(calday=U.ST.DayFromDate.01(1,12),actions.N=1,actions=list(

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
        setup         = B.AB.Afurseal.SGW.01.pup.setup.01,
        update.State  = B.AB.Afurseal.SGW.01.pup.update.state.01)

#   return Taxon environment

      Taxon

} #     end taxon

