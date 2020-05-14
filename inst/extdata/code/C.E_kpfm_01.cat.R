function ()
# Function:           catalogue for EPOC in local directory - task-specific files for E_kpfm.01

{

#   C. = Controllers (last assigned ID = 11002)
#
#           C.E_kpfm.01              ID = 11001
#           C.kpfm.trial.01          ID = 11002
#
#   B. = Biota
#
#       20000  - help
#       21000  - PP - primary production
#       22000  - MI - mesopelagic invertebrates, not including squid
#       23000  - BI - benthic invertebrates
#       24000  - MP - fish and squid
#       25000  - AB - (air-breathers) birds and marine mammals
#       26000  -  (last assigned ID = )
#       27000  - (last assigned ID = )
#       28000  - G_ - general groups
#
#     B.MI  : Mesopelagic invertebrates (last assigned ID = 22002)
#           B.MI.kpfm_Krill.01       #  ID = 22001  Antarctic krill - Euphausia superba
#           B.MI.kpfm_Krill.setup.01 #  ID = 22002  Antarctic krill - setup function
#           B.RE.kpfm.01             #  ID = 22003  recruitment of krill
#
#     B.MP - fish and squid (last assigned ID = 24002)
#
#           B.MP.kpfm_Fish01.01       #  ID = 24001  KPFM simulation - Fish
#           B.MP.kpfm_Fish01.setup.01 #  ID = 24002  KPFM simulation - Fish - setup function
#
#     B.AB  : air-breathers - birds & marine mammals (last assigned ID = 25006)
#           B.AB.kpfm_Seal01.01       #  ID = 25001  KPFM simulation - Seal
#           B.AB.kpfm_Seal01.setup.01 #  ID = 25002  KPFM simulation - Seal - setup function
#           B.AB.kpfm_Peng01.01       #  ID = 25003  KPFM simulation - Penguin
#           B.AB.kpfm_Peng01.setup.01 #  ID = 25004  KPFM simulation - Penguin - setup function
#           B.AB.kpfm_Whale1.01       #  ID = 25005  KPFM simulation - Whale
#           B.AB.kpfm_Whale1.setup.01 #  ID = 25006  KPFM simulation - Whale - setup function
#
#     B.G_  : General biota (last assigned ID = 28002)
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
#   E. = Environment
#
#       30000  - help (last assigned ID = )
#       31000  - (last assigned ID = )
#       39000  - supporting functions (last assigned ID = )
#
#     E.G_  : general environment (last assigned ID = )
#           E.G_.env_variability.01.01       #ID = 28001  Environmental variability
#           E.KPFM_var.01                    #ID = 28003  Function for determining condition in a given year
#
#   A. = Activities
#
#       40000  - help (last assigned ID = )
#       41000  - FI - Fisheries
#       49000  - supporting functions (last assigned ID = )
#
#     A.FI  : general environment (last assigned ID = 41001)
#           A.FI.Krill.01.01        #ID = 41001  Krill fishery
#           A.FI.Krill.01.setup.01  #ID = 41002  Krill fishery - setupfunction
#
#   M. = Management
#
#       50000  - help (last assigned ID = )
#       51000  - FC - Fisheries Control Measures
#       59000  - supporting functions (last assigned ID = )
#
#     M.FC  : Fisheries Control Measures (last assigned ID = 51002)
#           M.FC.Krill.Fishery.Measures.01           #ID = 51001  Krill fishery management
#           M.FC.Krill.Fishery.Measures.01.setup.01  #ID = 51002  Krill fishery management - setupfunction
#
#   O. = Outputs
#
#       60000  - help (last assigned ID = )
#       61000  - (last assigned ID = )
#       69000  - supporting functions (last assigned ID = )
#





}

