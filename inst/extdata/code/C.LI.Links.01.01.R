function (Universe,Diary)

# Function:           C.LI.Links.01.01
# Description:        General controller of identifying all linkages
# Primary attributes: Determine linkages at the beginning of the simulation
#                       1. all linkages for output and for determining errors
#                       2. linkages in each time step to help save time
#

# Input parameters:   Universe - list including one or more of
#                               (Biota, Environment, Activities, Management, Output, Presentation)
#                     Diary

# Returned            Lists of linkages for each period in the diary
#                     Current linkages saved are:
#                     * consumers of each prey

########################################################
#      Signature <- list(
#        ID           =  11003,
#        Name.full    = "Linkages 01",
#        Name.short   = "Links01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "11 June 2005"
#        ) # end Signature


########################################################

{


##############################################################################################
# For each period,
# Generate lists of linkages for each impacted component e.g. for each prey, list of predators
##############################################################################################

# loop through each element and add to its environment the necessary linkages concerning which
#   elements that this element
#   i) impacts on, or is
#   ii) impacted by

for (pe in 1:length(Diary)){

################################################
if(!is.null(Universe$Biota)) {

# Predator-prey linkages
     Links.Pred_Prey<-C.LI.Effects.sumry.01(C.LI.FW_period.01.01(Universe$Biota,Diary[[pe]]$Biota))

# Taxon-environment linkages


# Taxon-activities linkages


# Number of elements in Biota

  BiotaN <- Universe$Biota$Biota.N

  for (i in 1:BiotaN){

    Links<-list()
      Links<-c(Links,list(
#       add line for each of the interactions
#       mortality includes consumption, activities & environmental impacts
#         (movement is a source of mortality in a polygon - it is a part of the process but not included here)
#         source = the list are sources of mortality of this element
#         cause  = the cause of mortality in the list of other elements

        mortality.source = vector("integer",length=0),

        mortality.cause = vector("integer",length=0),

#       vector of elements that are parents to be considered in estimating spawning biomass
#       the list pertains to the dominant element while the rest do not reproduce
        parents   = vector("integer",length=0)
        ))

} # end i

# Links is included with each item of the list representing successive periods
Universe$Biota[[i]]$Links<-Links

} # end Biota


################################################


} # end pe

}

