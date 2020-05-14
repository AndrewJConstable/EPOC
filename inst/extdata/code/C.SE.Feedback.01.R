function (Universe)

# Function:           C.SE.Feedback.01
# Description:        General setup of feedback matrices
# Primary attributes: During a period, when a component is altered, e.g. mortality of prey by a predator,
#                     the alteration, say amount of a prey taxon consumed, is recorded as necessary
#                     for the causal component to use the information later
#                     such as a predator updating its health, growth and reproduction or remembering its performance
#                     over years at the end of the period

# Input parameters:   Universe - list including one or more of
#                               (Biota, Environment, Activities, Management, Output, Presentation)

# Returned            List of "component$State" in each main category

########################################################
#      Signature <- list(
#        ID           =  11009,
#        Name.full    = "Feedback matrices setup 01",
#        Name.short   = "Feedback01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "31 May 2005"
#        ) # end Signature


########################################################

{

Feedback<-list()

#   biota environments - create predator-prey matrix

      if(!is.null(Universe$Biota)) {
        BiotaFeedback<-list()
        BiotaFeedback<-c(BiotaFeedback,list(Consumed.prey = matrix(0,nrow=Universe$Biota$Biota.N,ncol=Universe$Biota$Biota.N)))

      } # end biota

#    Environment

#    Activities

#    Management

#    Output

#    Presentation


Feedback
}

