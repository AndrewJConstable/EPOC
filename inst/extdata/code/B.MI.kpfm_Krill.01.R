function ()

# Function:           B.MI.kpfm_Krill.01
# Description:        Biological Element, Group Zooplankton, Euphausia superba
# Primary attributes: Element incorporates all life stages of taxon
#                     Age structure included in status but only active to save recruits
#                     Number=biomass

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
      Name.full    = "KPFM - Krill",
      Name.short   = "KPFM-Krill",
      Morph        = "01",
      Version      = "01",
      Authors      = "A.Constable",
      last.edit    = "6 July 2005"
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

#   ############################################################################
#   State structure of element

#   list of life stages to be monitored in State
#   ages are not used - first age classes are for storing recruitments to allow
#   reproduction at age zero and for recruitment to occur at nominated age

    Life.stages<-list(Stage.names=c("0","1","A"),Stage.ages = c(0,1,4))

#   number of age classes

    StageN<-length(Life.stages$Stage.ages)


#   #############################################################
#   Taxon$Reproduction

#   i.   elements to which new offspring are accumulated

          inherit.offspring <- 22001 # ID number of element to which offspring go
                                    # offspring will be placed in first age class of element
                                    # inherit back to this element

# SSMU-specific spawner recruit parameters - Equations 3 & 4

    # maximum recruitment density (biomass)
           Ralpha<-0.95
    # adult density for which recruitment density is half maximum
           Rbeta          = 0.6*Ralpha

# recruitment variability driven by environment

         recruit.variability<-28001 # ID number of environment element to deliver variability

#   ii. spawner-recruitment relationship parameters

         spawner.recruit01<-list(
           Ralpha         = Ralpha,     # max recruitment density (biomass) (adjusted by using environment variability - space x time)
           Rbeta          = Rbeta  # adult density for which recruitment density is half maximum
           ) #

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
                                recruit.variability    = recruit.variability,
                                spawner.recruit.fn     = B.RE.kpfm.01,
                                spawner.recruit.params = spawner.recruit01,
                                offspring.distn        = offspring.distn01),
#                       add more data sets for different polygons here as needed

                        dSet.N = 1,                                # number of datasets
                                                                   # dataset from which to take appropriate parameters in the respective polygons
                        UseSpawnerRec      = c(1,1,1,1,1,1,1,1),   #     spawner-recruit function & params
                        UseOffspringDistn  = c(1,1,1,1,1,1,1,1)    #     distribution of offspring pattern
                    ) # end Set01

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

#                      matrix of annual probabilities of moving from one location to another location
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

#   ############################################################################
#   Taxon$State - initial characteristics
#   ############################################################################

# set up age structure as at 1 January
# recruitment is fixed for age of recruitment - do not need to correct for mortality
# starting biomass is fixed
# only numbers are used in model simulation

# Initial densities of adult krill in each area

  Ninitdens <-c(30,10,10,20,40,50,60,30)

#  Recruits<-Reproduce.data.01
#   AbN[1]<-Reproduce.data.01[[<-list(
   #                       data sets to be used in different polygons
#                           dSet1 = list(
#                                   inherit.offspring      = inherit.offspring,
#                                   recruit.variability    = recruit.variability,
#                                   spawner.recruit.fn     = B.RE.kpfm.01,
##                                   spawner.recruit.params = spawner.recruit01,
#                                   offspring.distn        = offspring.distn01),
   #                       add more data sets for different polygons here as needed


#               Taxon.AgeStructure.Default<-cbind(Life.stages$Stage.ages,as.vector(AbN/sum(AbN)))

#   Estimate abundances for each polygon at 1 January

#    Init.abund<-vector("numeric",length=Taxon$Polygons$Polygon.N)
#      Init.dens.rec<-Reproduce.data.01[[Reproduce.data.01$UseSpawnerRec[i]]]$spawner.recruit.params$RbarMaxDens*exp(-NatMort.prerecruit*Taxon.AgeStructure.Default[1,1])

#    for (i in 1:Taxon$Polygons$Polygon.N){
      # initial age structure at birthday,which was not converted to age composition, is needed here
#      Init.dens<-Init.dens.rec*AbN
#      Init.abund[i]<-sum(Init.dens)*Taxon$Polygons$Polygon.Areas[i]
#    } # end i

# estimating weight at age for 1 January
#       estimate integer of interval in size at age matrix rounded down to the nearest integer
#         estimated from
#           prop of year since birthday (above) - PropYrFromBday - and
#           number of intervals in the year less the origin i.e. YrIntervals-1

#        RefInt<-floor(PropYrFromBday*(YrIntervals-1))

# size at age is at 1 January
#        Taxon.Weight.at.age.Default <- size.at.age01[,RefInt]

# estimate biomass

#MeanWtInd<-sum(Taxon.Weight.at.age.Default*Taxon.AgeStructure.Default[,2])

#Init.biomass<-MeanWtInd*Init.abund

# declare State

    Taxon$State<-list(
       Abundance      = list(num.ind  = 0,
                             mass     = 0,
                             mass.unit = "t",
                             mass.multiplier = 1),
       StageN         = StageN,
       StageStrUnits  = 1,                # reference to which abundance units are used by each age structure
                                                           # 1 = number, 2 = biomass
       StageStr = list(
               AP     = 0,
               EI     = 0,
               SOI    = 0,
               SGI    = 0,
               NthWed = 0,
               SthWed = 0,
               CenWed = 0,
               EAP    = 0
               ), # end ageStr list
       StageNames = Life.stages$Stage.names,
       Space    = Space.data.01,
       Cond.R   = 1,
       Cond.S   = 1, # end Cond.S list
       Cond.H   = 1
       ) # end list of State


#   #############################################################
#   Taxon$TimeSteps
#   #############################################################

#   the characteristics of a time step between the previous time and the specified time (in days)
#   is given in a list(days in calendar year, number of functions to be carried out, list of named functions)
#   knife-edge functions can be included by repeating the same day

    Taxon$TimeSteps<-list(

       Annual     = list(calday=(Taxon$Birthday*365),actions.N=4,actions=list(

                      reproduce   = list(Update.fn = B.PD.reproduce.01,  # function to be used - based on Beverton & Holt relationship
                                         dSet      = Reproduce.data.01), # end reproduce
                      migrate     = list(Update.fn = B.PD.migrate.01,    # function to be used
                                         dSet      = Migration.data.01), # pattern for input to function
                      update.age  = list(Update.fn = B.PD.update_age.01, # function to be used
                                         dSet      = list())        # pattern for input to function
          ) # end actions list
        ) # end time step Spawn

      ) # end list of timesteps

    # number of timesteps

     Taxon$TimeSteps.N<-length(Taxon$TimeSteps)

#   #############################################################
#   Taxon$Ancillary.fns
#   #############################################################
#   function to undertake setup actions such as to change ID linkages to references in the relevant components

    Taxon$Ancillary.fns<-list(
        setup         = B.MI.kpfm_Krill.setup.01,
        update.State  = B.PD.update_State.01)

#   return Taxon environment

      Taxon

} #     end taxon

