function (PolygonsN)  # number of polygons in the element

# Function:           B.PD.init_Trans_change.01
# Version             0.01

# Description:        Population dynamics function - initialise Transition$change lists for an element in Biota
#                     Aim is to have a null list, one for each polygon

# Primary attributes:

# Input data:         as above


# Return data:        Transition$change list

########################################################
#      Signature <- list(
#        ID           =  29007,
#        Name.full    = "Initialise Transition$change in Biota element",
#        Name.short   = "Init Trans.change",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "12 June 2005"
#        ) # end Signature


########################################################

{

TClist<-list()

for (pn in 1:PolygonsN) {
  TClist<-c(TClist,list(list()))
} # end loop

#   ############################################################################
#   return
#   ############################################################################

TClist

}

