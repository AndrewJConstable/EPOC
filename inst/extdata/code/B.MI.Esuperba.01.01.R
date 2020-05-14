function ()

# Function:           B.MI.Esuperba.01.01
# Description:        Biological Element, Group Zooplankton, Euphausia superba
# Primary attributes: Element incorporates all life stages of taxon
#                     Age structure included in status

#                     Trial of some routines

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
      ID           = 22001,
      Name.full    = "Euphausia superba (Antarctic krill)",
      Name.short   = "E. superba",
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
    Cmonth<-9

    Taxon$Birthday<-U.ST.DayFromDate.01(Cday,Cmonth)/365

#   ############################################################################
#   Data sets for specifying environment
#   ############################################################################

#   #############################################################
#   Parameters used to initialise environment but may be altered
#   in the Setup function and/or may not be representative of
#   the Universe e.g. natural mortality rate

#    NatMort <- 0.47 # natural mortality rate
    NatMort <- 0.398 # natural mortality rate

    NatMort.prerecruit <- 0.7 # natural mortality rate prior to recruitment to first stage of this element
#                             # used in setting up initial density of first stage derived from maximum output
#                             # of offspring density in reproduction

#   ############################################################################
#   State structure of element

#   list of life stages to be monitored in State

    Life.stages<-list(Stage.names=c("0","1","2","3","4","5","6","7"),Stage.ages = c(0,1,2,3,4,5,6,7))

#   number of age classes

    StageN<-length(Life.stages$Stage.ages)


#   #############################################################
#   Taxon$Reproduction

#   i.   elements to which new offspring are accumulated

          inherit.offspring <- 22001 # ID number of element to which offspring go
                                    # offspring will be placed in first age class of element
                                    # inherit back to this element

#   ii. spawner-recruitment relationship parameters - Beverton & Holt

         spawner.recruit01<-list(
           Rh             = 0.95,     # steepness
#??
           Rcv            = 1.1,     # CV of recruit density at a given spawning biomass density

           RbarMaxDens    = 1.0E12,  # maximum mean density of recruits for maximum density of spawning biomass
#??

           SSBlimDens     = 2.E6) # density of spawning biomass for which the ratio of current SSB/SSBlimDens = 1

#   iii.  distribution of offspring

#          matrix of proportions of offspring from an area going to other areas

           offspring.distn01<-matrix(c(

#           Origin (data are filled rows by columns)
#            1    2    3    4    5    6    7    8
#           AP  ,EI  ,SOI ,SGI ,NWed,SWed,CWed,EAP
#                                                      # Destination
            1.0 ,0.0 ,0.0 ,0.0 ,0.0 ,0.0 ,0.0 ,0.0 ,   # AP
            0.0 ,1.0 ,0.0 ,0.0 ,0.0 ,0.0 ,0.0 ,0.0 ,   # EI
            0.0 ,0.0 ,1.0 ,0.0 ,0.0 ,0.0 ,0.0 ,0.0 ,   # SOI
            0.0 ,0.0 ,0.0 ,1.0 ,0.0 ,0.0 ,0.0 ,0.0 ,   # SGI
            0.0 ,0.0 ,0.0 ,0.0 ,1.0 ,0.0 ,0.0 ,0.0 ,   # NWed
            0.0 ,0.0 ,0.0 ,0.0 ,0.0 ,1.0 ,0.0 ,0.0 ,   # SWed
            0.0 ,0.0 ,0.0 ,0.0 ,0.0 ,0.0 ,1.0 ,0.0 ,   # CWed
            0.0 ,0.0 ,0.0 ,0.0 ,0.0 ,0.0 ,0.0 ,1.0 ),  # EAP
            nrow=Taxon$Polygons$Polygon.N,ncol=Taxon$Polygons$Polygon.N)

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
                        UseSpawnerRec      = c(1,1,1,1,1,1,1,1),   #     spawner-recruit function & params
                        UseOffspringDistn  = c(1,1,1,1,1,1,1,1)    #     distribution of offspring pattern
                    ) # end Set01



#   #############################################################
#   Taxon$Evolve

#   not included here because taxon is contained within one element



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
#   Reproductive condition in each polygon

#   Funtions to update spatial pattern parameters if needed are:

#       Name              Input requirements to be included in data

#       B.CO.reproduction.01     to be determined

#
#   Parameters used for updating reproductive condition in each polygon

#   i.  maturity - function as proportion at age mature

        maturity01<-c(0,0,0,0,1,1,1,1)

    Cond.R.data.01<-list(
#                       data sets to be used in different polygons
                        dSet1 = list(
                                maturity = maturity01
                                ), # end Set01

#                       specify which dataset to use in each polygon
                        UseMaturity        = c(1,1,1,1,1,1,1,1)   #     maturity
                    ) # # end Cond.R.data.01

#   #############################################################
#   Individual size condition in each polygon

#   Funtions to update spatial pattern parameters if needed are:

#       Name              Input requirements to be included in data

#       B.CO.size.01     to be determined

#
#   Parameters used for updating reproductive condition in each polygon

#   i.  size - delivered as a vector of weights in each of 0 to 12 months for each stage class
#               matrix of stage (rows) by month (cols)

        YrIntervals <- 52 # number of months including zero

# specify von Bertalanffy parameters (using generalised function)
#                     as vector             vBLinf = L infinity
#                                           vBK    = growth rate
#                                           vBt0   = age when size is zero
#                                           g.origin = proportion of calendar year to day of time origin (time=0.0) on growth curve
#                                           tr     = start of growth period as proportion of year since origin (time=0.0) of growth curve
#                                           tg     = total proportion of the year in which growth occurs
#                                                     (over one continuous period that may overlap with origin)
#                     dWtlen  = parameters for weight length relationship as vector (a,b)


    vBparams = list(Linf = 60,Kappa = 0.45, vBt0 = -0.0,g.origin = Taxon$Birthday, tr = 11/12, tg = 0.33) # mm

    dWtlen   = list(WLa = 1.28E-12, WLb = 3.449) # tonnes

        # specify matrix

        size.at.age01<-matrix(0,ncol=YrIntervals,nrow=StageN)

# note that this size at age matrix is relative to the birthday and not the 1 January

# vBparams$tr needs to be made relative to the birthday
      vBparams$tr<-ifelse (vBparams$tr < vBparams$g.origin, (1-vBparams$g.origin+vBparams$tr),vBparams$tr-vBparams$g.origin)

      for (i in 1:StageN) {
        for (j in 1:YrIntervals) {
          size.at.age01[i,j]<-B.PD.vB_general.01(vBparams,dWtlen,Life.stages$Stage.ages[i],(j-1)/(YrIntervals-1))[2]
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

        health01<-c(1,1,1,1,1,1,1,1)

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

    PropYrFromBday<-(1-Taxon$Birthday)

    Stage.first.age<-Life.stages$Stage.ages[1]

#              default is to apply the same deterministic age structure in all areas
#              create age structure here and assign to a matrix
               AbN        <- exp((Life.stages$Stage.ages-Stage.first.age)*(-NatMort))

               if(NatMort>0) AbN[StageN]<- AbN[StageN]/(exp(NatMort)-1)

#               project to 1 January from birthday if needed (need to preserve AbN for below when developing age structure)
               AbN<-AbN*exp(-NatMort*PropYrFromBday)

               Taxon.AgeStructure.Default<-cbind(Life.stages$Stage.ages,as.vector(AbN/sum(AbN)))

#   Estimate abundances for each polygon at 1 January

    Init.abund<-vector("numeric",length=Taxon$Polygons$Polygon.N)
      Init.dens.rec<-Reproduce.data.01[[Reproduce.data.01$UseSpawnerRec[i]]]$spawner.recruit.params$RbarMaxDens*exp(-NatMort.prerecruit*Taxon.AgeStructure.Default[1,1])

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
        Taxon.Weight.at.age.Default <- size.at.age01[,RefInt]

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
       Cond.R   = Cond.R.data.01,
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

       Grow1     = list(calday=U.ST.DayFromDate.01(31,1),actions.N=1,actions=list(

                      update.size = list(Update.fn = B.PD.update_size.01,# function to be used
                                         dSet      = Cond.S.data.01)       # pattern for input to function
          ) # end actions list
        ) # end time step Grow1

       , Feeding     = list(calday=U.ST.DayFromDate.01(28,2),actions.N=2,actions=list(

                      migrate     = list(Update.fn = B.PD.migrate.01,    # function to be used
                                         dSet      = Migration.data.01), # pattern for input to function
                      update.size = list(Update.fn = B.PD.update_size.01,# function to be used
                                         dSet      = Cond.S.data.01)       # pattern for input to function
          ) # end actions list
        ) # end time step Feeding

#       note comma is used to append this to list

       , Grow2     = list(calday=U.ST.DayFromDate.01(31,3),actions.N=1,actions=list(

                      update.size = list(Update.fn = B.PD.update_size.01,# function to be used
                                         dSet      = Cond.S.data.01)       # pattern for input to function
          ) # end actions list
        ) # end time step Grow2

       , Grow3     = list(calday=U.ST.DayFromDate.01(30,4),actions.N=1,actions=list(

                      update.size = list(Update.fn = B.PD.update_size.01,# function to be used
                                         dSet      = Cond.S.data.01)       # pattern for input to function
          ) # end actions list
        ) # end time step Grow2

       , Spawn     = list(calday=(Taxon$Birthday*365),actions.N=4,actions=list(

                      reproduce   = list(Update.fn = B.PD.reproduce.01,  # function to be used - based on Beverton & Holt relationship
                                         dSet      = Reproduce.data.01), # end reproduce
                      migrate     = list(Update.fn = B.PD.migrate.01,    # function to be used
                                         dSet      = Migration.data.01), # pattern for input to function
                      update.size = list(Update.fn = B.PD.update_size.01,# function to be used
                                         dSet      = Cond.S.data.01),      # pattern for input to function
                      update.age  = list(Update.fn = B.PD.update_age.01, # function to be used
                                         dSet      = list())        # pattern for input to function
          ) # end actions list
        ) # end time step Spawn


#       note comma is used to append this to list
       , Spring     = list(calday=U.ST.DayFromDate.01(30,11),actions.N=2,actions=list(

                      migrate     = list(Update.fn = B.PD.migrate.01,    # function to be used
                                         dSet      = Migration.data.01), # pattern for input to function
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
        setup         = B.MI.Esuperba.01.setup.01,
        update.State  = B.PD.update_State.01)

#   return Taxon environment

      Taxon

} #     end taxon

