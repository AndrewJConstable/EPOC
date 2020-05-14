function ()

# Function:           E.G_.env_variability.01.01
# Description:        Environment Element, General environmental variability
#                     Variation in space and time
# Primary attributes: Element incorporates all life stages of taxon
#                     Age structure included in status but only active to save recruits
#                     Number=biomass

{


#   ############################################################################
#   Taxon - create new environment & note details of routine
#   ############################################################################

    Env<-new.env()

#   Signature is a unique identifier for this element
#         number applicable to Euphausia superba where 2000 series
#         is approximately second trophic level and numbers within are
#         identification numbers of the elements - all elements within a single
#         model should be unique (although the same number may be used in different versions
#         of this element

    Env$Signature <- list(
      ID           = 28001,
      Name.full    = "Environmental variability - KPFM",
      Name.short   = "KPFM-EnvVar",
      Morph        = "01",
      Version      = "01",
      Authors      = "A.Constable",
      last.edit    = "6 July 2005"
      ) # end Signature


#   ############################################################################
#   Taxon$Polygons - definition
#   ############################################################################

    Env$Polygons<-list(
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

    Env$Polygons<-c(Taxon$Polygons,list(Polygon.N = length(Taxon$Polygons$Coords)))

#   Polygon areas (only if needed e.g. for estimating densities)

    Env$Polygons<-c(Taxon$Polygons,list(Polygon.Areas = c(2,2,2,2,2,2,1,1)))

#   ############################################################################
#   Data sets for specifying environment
#   ############################################################################

# area specific environmental differences (not needed at present)

    Area_env<-c(1,1,1,1,1,1,1,1)

# temporal variation characteristics not included at this stage

   Temporal<-c(1)

# area-specific scale parameter of environmental variation

   Rphi<-c(0,0,0,0,0,0,0,0)

# log-normal variability (input as CV) by area

  EnvLnSD<-0.2

  Env.var.data.01<-list(
        Area_env    = Area_env,
        Temporal    = Temporal,
        Rphi        = Rphi,
        EnvLnSD     = EnvLnSD
        ) # end Env.var.data.01


# Initial area conditions

InitialAreaCondition<-c(1,1,1,1,1,1,1,1)

#   ############################################################################
#   declare State
#   ############################################################################

    Env$State<-list(
       Condition      = InitialAreaCondition)  # vector of conditions by area

#   #############################################################
#   Taxon$TimeSteps
#   #############################################################

#   the characteristics of a time step between the previous time and the specified time (in days)
#   is given in a list(days in calendar year, number of functions to be carried out, list of named functions)
#   knife-edge functions can be included by repeating the same day

    Env$TimeSteps<-list(

       Update_cond     = list(calday=U.ST.DayFromDate.01(1,1),actions.N=1,actions=list(

                      update.env.cond = list(Update.fn = E.KPFM_var.01,# function to be used
                                         dSet      = Env.var.data.01)       # pattern for input to function
          ) # end actions list
        ) # end time step Update_cond

      ) # end list of timesteps

    # number of timesteps

     Env$TimeSteps.N<-length(Env$TimeSteps)

#   return Env environment

      Env

} #     end Env


