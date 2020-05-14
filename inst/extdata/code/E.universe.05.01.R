function ()

# Function:           E.universe.05.01
# Description:        Definition of the universe - 01 2005
# Primary attributes: Definition of the universe
#

# Input parameters:

# Returned            list of universe

########################################################
#      Signature <- list(
#        ID           =  11003,
#        Name.full    = "Linkages 01",
#        Name.short   = "Links01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "30 May 2005"
#        ) # end Signature


########################################################

{
    Biota <- list(Esuperba = B.MI.Esuperba.01.01(),
                  EsPred   = B.G_.pred_unknown.01.01(),
                  AFSpup   = B.AB.Afurseal.SGW.01.pup.01(),
                  AFSjuv   = B.AB.Afurseal.SGW.01.juv.01(),
                  AFSnr    = B.AB.Afurseal.SGW.01.nonrep.01(),
                  AFSra    = B.AB.Afurseal.SGW.01.rep.01())
      Biota<- c(Biota,list(Biota.N = length(Biota)))

#    Environment <- list(NULL)

#      Environment<- c(Environment,list(Environment.N = length(Environment)))

#    Activities  <- list(NULL)

#      Activities<- c(Activities,list(Activities.N = length(Activities)))

#    Management  <- list(NULL)

#      Management<- c(Management,list(Management.N = length(Management)))

#    Outputs  <- list(NULL)

#      Outputs<- c(Outputs,list(Outputs.N = length(Outputs)))

#    Presentation  <- list(NULL)

#      Presentation<- c(Presentation,list(Presentation.N = length(Presentation)))

# only list those parts that have definitions.  NULL values for others will be used in setup

  list(Biota        = Biota)

#       Environment  = Environment,
#       Activities   = Activities,
#       Management   = Management,
#       Output       = Output,
#       Presentation = Presentation)

}

