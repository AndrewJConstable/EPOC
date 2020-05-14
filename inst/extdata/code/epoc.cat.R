function ()
# Function:           epoc.cat
# Description:        Catalogue of functions in the model - details of the catalogue and codes
#                     also is used to turn mtrace() on for functions that need debugging

# Primary attributes: help

{


########################################################
#      Signature <- list(
#        ID           =  10002,
#        Name.full    = "Help - structure - catalogue and codes",
#        Name.short   = "Catalogue",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "28 May 2005"
#        ) # end Signature


########################################################
#     Nomenclature for function names (including numeric identifiers)
#
#
#
#   C. = Controller

#       10000  - help and descriptions (last assigned ID = 10002)
#       11000  - controller (last assigned ID = 11011 - reassign 11012)
#       12000  - universes to be simulated (last assigned ID = 12001)
#

#     C.00: Development functions

#     C.01: Main controller
#     mtrace(C.01.epoc.05.01)          #  ID = 11001  Primary controller - EPOC - system 01 2005


#           C.LI                                    Functions for determining linkages between components
#           C.LI.Links.01.01          #  ID = 11003  Determine foodweb linkages
#           C.LI.FW_all.01.01         #  ID = 11006  Determine foodweb linkages (inc. error check)
#           C.LI.FW_period.01.01      #  ID = 11007  Determine foodweb linkages for a given period
#           C.LI.Effects.sumry.01     #  ID = 11005  Lists of predators (by reference to place in BIOTA) for each prey

#           C.                                  Functions for determining calendar of periods in the year
#           C.Cal.01.01               #  ID = 11004  Generating the calendar of events for the year
#           C.Cal.01.output.01        #  ID = 11012 Output calendar to file

#           C.SE                                    Functions for generally setting up epoc
#           C.SE.Transition.01        #  ID = 11008  establish a list of Transition environments including only $State from each component
#           C.SE.Feedback.01          #  ID = 11009  establish null matrices used for remembering feedbacks during a period
#           C.SE.Setup.universe.05.01    #  ID = 11011  call setup functions in each component to establish parameters, linkages etc.
#                                                       dependent on other aspects of the universe
#

#           C.PJ                                    Functions for undertaking projections
#     mtrace(C.PJ.Period.01)           #  ID = 11010  Project universe over one time step

#           E.universe.05.01          #  ID = 12001  Define the universe - system 01 2005

#           E.trial.05.01             #  ID = 12002  Parameters for the trial

#
#
#   H. = Help
#
#     H.D_  : Descriptions of routines and program
#           H.D_.purpose              #  ID = 10001  Purpose of the EPOC program
#
#
#     H.ST  : Structure of the function library
#           H.ST.catalogue            #  ID = 10002  Catalogue and codes of the function library
#
#   B. = Biota
#
#       20000  - help (last assigned ID = )
#       21000  - PP - primary production (last assigned ID = )
#       22000  - MI - mesopelagic invertebrates, not including squid (last assigned ID = 22002)
#       23000  - BI - benthic invertebrates (last assigned ID = )
#       24000  - MP - fish and squid (last assigned ID = )
#       25000  - AB - (air-breathers) birds and marine mammals (last assigned ID = 25007)
#       26000  -  (last assigned ID = )
#       27000  - (last assigned ID = )
#       28000  - G_ - general groups (last assigned ID = 28002)
#       29000  - supporting functions (last assigned ID = 29015)

#     B.MI  : Mesopelagic invertebrates
#           B.MI.Esuperba.01.01       #  ID = 22001  Antarctic krill - Euphausia superba
#           B.MI.Esuperba.01.setup.01 #  ID = 22002  Antarctic krill - setup function
#
#     B.AB  : air-breathers - birds & marine mammals
#    mtrace(B.AB.Afurseal.SGW.01.pup.01)      #ID = 25001  Antarctic fur seal - pup - South Georgia
#    mtrace(B.AB.Afurseal.SGW.01.pup.setup.01)#ID = 25005  setup
#    mtrace(B.AB.Afurseal.SGW.01.juv.01)      #ID = 25002  Antarctic fur seal - juvenile - South Georgia
#    mtrace(B.AB.Afurseal.SGW.01.juv.setup.01)#ID = 25006
#    mtrace(B.AB.Afurseal.SGW.01.nonrep.01)   #ID = 25003  Antarctic fur seal - nonreproductive - South Georgia
#    mtrace(B.AB.Afurseal.SGW.01.nonrep.setup.01)#ID = 25007
#    mtrace(B.AB.Afurseal.SGW.01.rep.01)      #ID = 25004  Antarctic fur seal - reproductive - South Georgia
#    mtrace(B.AB.Afurseal.SGW.01.rep.setup.01)#      ID = 25008  Antarctic fur seal - reproductive - South Georgia


#     B.G_  : General biota (groups that do not fit neatly in the taxonomic groups above)
#           B.G_.pred_unknown.01.01       #ID = 28001  Nominated mortality of elements lost to the system - number 1
#           B.G_.pred_unknown.01.setup.01 #ID = 28002  Unknown predator 1 - setupfunction

#
#     B.PD  : Population dynamics general routines
#           B.PD.reproduce.01           #ID = 29001  Reproduction based on Beverton & Holt relationship
#           B.PD.migrate.01             #ID = 29002  Migration
#           B.PD.rec_BH.01              #ID = 29003  Beverton & Holt recruitment function
#           B.PD.vB_general.01          #ID = 29006  von Bertalanffy growth in part of the year (e.g. krill) with weight-length
#   ???     B.PD.init_Trans_change.01   #ID = 29007  Initialise Transition.change lists
#           B.PD.update_State.01        #ID = 29008  update the State of the element's environment
#           B.PD.update_size.01         #ID = 29009  update size condition
#           B.PD.update_age.01          #ID = 29010  update age including offspring added to youngest stage
#           B.PD.update_reprod.cond.01  #ID = 29015  update size condition
#
#           B.PD.Afurseal.01.change.element.01  #ID = 29011  setup
#           B.AB.Afurseal.adopt.01      #ID = 29012
#           B.PD.reproduce.AFS.01       #ID = 29013

#     B.FO  : Foraging/consumption general routines
#           B.FO.Predation.01.01        #ID = 29005  General predation using FFtypeI for managing a time step
#           B.FO.FFtypeI.01             #ID = 29004  Holling Type I feeding response - based on M
#           B.FO.HollingGen.01          #ID = 29014  Holling General
#           B.FO.Predation.02.01        #ID = 29005  General predation using HollingGen routine

#
#   E. = Environment
#
#       30000  - help (last assigned ID = )
#       31000  - (last assigned ID = )
#       39000  - supporting functions (last assigned ID = )
#
#
#   A. = Activities
#
#       40000  - help (last assigned ID = )
#       41000  - (last assigned ID = )
#       49000  - supporting functions (last assigned ID = )
#
#
#   M. = Management
#
#       50000  - help (last assigned ID = )
#       51000  - (last assigned ID = )
#       59000  - supporting functions (last assigned ID = )
#
#
#   O. = Outputs
#
#       60000  - help (last assigned ID = )
#       61000  - (last assigned ID = )
#       69000  - supporting functions (last assigned ID = )
#
#
#   P. = Presentation
#
#       70000  - help (last assigned ID = )
#       71000  - (last assigned ID = )
#       79000  - supporting functions (last assigned ID = )
#
#
#   U. = Utilities
#
#       80000  - help (last assigned ID = )
#       81000  - (last assigned ID = 81003)
#
#     U.ST  : Statistical utilities
#           U.ST.RandLnormNat.01        #ID = 81001  Generate vector of random log-normal deviates based on natural domain mean, CV
#           U.ST.DayFromDate.01         #ID = 81002  Generate calendar day in year from date (day,month)
#           U.element.ref.in.list.01    #ID = 81003  Generate reference number of an element (name) in list





}

