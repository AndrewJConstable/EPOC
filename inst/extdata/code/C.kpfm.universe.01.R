function ()

# Function:           C.kpfm.universe.01
# Description:        Definition of the universe - kpfm simulation
#

# Input parameters:

# Returned            list of universe

########################################################
#      Signature <- list(
#        ID           =  11002,
#        Name.full    = "Linkages 01",
#        Name.short   = "Links01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "6 July 2005"
#        ) # end Signature


########################################################

{

    Environment <- list(
                    Env_var = E.G_.env_variability.01.01()
                   )
      Environment<- c(Environment,list(Environment.N = length(Environment)))

    Biota <- list(
                    Krill  = B.MI.kpfm_Krill.01()
#                  ,Seals  = B.AB.kpfm_Seal01.01()
#                  ,Pengs  = B.AB.kpfm_Peng01.01()
#                  ,Whales = B.AB.kpfm_Whale1.01()
#                  ,Fish   = B.MP.kpfm_Fish01.01()
#                  ,M0     = B.G_.pred_unknown.01.01()
                  )
      Biota<- c(Biota,list(Biota.N = length(Biota)))


#    Activities  <- list(
#                    Krill_fishery = A.FI.Krill.01.01
#                    )
#      Activities<- c(Activities,list(Activities.N = length(Activities)))

#    Management  <- list(
#                    Krill_fishery_measures = M.FC.Krill.Fishery.Measures.01
#                    )

#      Management<- c(Management,list(Management.N = length(Management)))

#    Outputs  <- list(

#                    )

#      Outputs<- c(Outputs,list(Outputs.N = length(Outputs)))

#    Presentation  <- list(NULL)

#      Presentation<- c(Presentation,list(Presentation.N = length(Presentation)))

# only list those parts that have definitions.  NULL values for others will be used in setup

  list(
        Environment  = Environment
       ,Biota        = Biota
#       ,Activities   = Activities
#       ,Management   = Management
#       ,Output       = Output
#       ,Presentation = Presentation
       )

}

