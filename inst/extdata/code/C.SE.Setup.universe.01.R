function (Universe, Calendar)
# Function:           C.SE.Setup.universe.01
# Description:        Setup the universe that may have generic functions but also need to invoke the setup functions
#                     in each component to facilitate establishing the component that may need relationships with other
#                     components
# Primary attributes: Establish the universe ready for simulations
#

# Input parameters:   Universe
#                     Calendar of events

# Returned            Linkages = the variety of linkage matrices that might be formed (for reporting)

# NB test to see that Universe is updated without having to return it.

########################################################
#      Signature <- list(
#        ID           =  11011,
#        Name.full    = "Setup universe 01",
#        Name.short   = "Setup01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "3 June 2005"
#        ) # end Signature


########################################################

{

################################################################################
################################################################################
# Biota
################################################################################

ElementID<-c()# col 1 = Module, 2 = ID, col 3 = reference number in module
ElementNames<-c()

if(!is.null(Universe$Biota)) {
  for (i in 1:Universe$Biota$Biota.N){
    ElementID<-rbind(ElementID,c(1,Universe$Biota[[i]]$Signature$ID,i))
    ElementNames<-c(ElementNames,Universe$Biota[[i]]$Signature$Name.short)
  }
} # end biota

if(!is.null(Universe$Environment)) {
  for (i in 1:Universe$Environment$Environment.N){
    ElementID<-rbind(ElementID,c(2,Universe$Environment[[i]]$Signature$ID,i))
    ElementNames<-c(ElementNames,Universe$Environment[[i]]$Signature$Name.short)
  }
} # end Environment

if(!is.null(Universe$Activities)) {
  for (i in 1:Universe$Activities$Activities.N){
    ElementID<-rbind(ElementID,c(3,Universe$Activities[[i]]$Signature$ID,i))
    ElementNames<-c(ElementNames,Universe$Activities[[i]]$Signature$Name.short)
  }
} # end Activities

if(!is.null(Universe$Management)) {
  for (i in 1:Universe$Management$Management.N){
    ElementID<-rbind(ElementID,c(2,Universe$Management[[i]]$Signature$ID,i))
    ElementNames<-c(ElementNames,Universe$Management[[i]]$Signature$Name.short)
  }
} # end Management

if(!is.null(Universe$Output)) {
  for (i in 1:Universe$Output$Output.N){
    ElementID<-rbind(ElementID,c(2,Universe$Output[[i]]$Signature$ID,i))
    ElementNames<-c(ElementNames,Universe$Output[[i]]$Signature$Name.short)
  }
} # end Output



################################################################################
  if(length(ElementID[,1])!=length(unique(ElementID[,1]))) {
    ElementID
    stop ("Duplicate IDs in Element functions - review list above (col 1 = ID, col 2 = Reference in declaration)")
  }

################################################################################
# loop through biota to invoke the necessary setup functions should they exist

if(!is.null(Universe$Biota)) {

  for (bn in 1:Universe$Biota$Biota.N){
      print (append("setting up taxon ",as.character(bn)))
    if(!is.null(Universe$Biota[[bn]]$Ancillary.fns$setup)) {
      Universe$Biota[[bn]]$Ancillary.fns$setup(Universe$Biota[[bn]],bn,Universe,ElementID,ElementNames,Calendar)
    } # end if biota element setup function exists
      print ("completed ")
  } # end biota loop


} # end biota

}
