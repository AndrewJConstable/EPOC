function (Universe, Calendar)

# Function:           C.SE.Transition.01
# Description:        General setup of transition environments
# Primary attributes: From each component's environment, add "component$State" to the transition list
#                     to save data from a period.  This will be used to update the "component$State"
#                     at the end of the period

# Input parameters:   Universe - list including one or more of
#                               (Biota, Environment, Activities, Management, Output, Presentation)
#                     Calendar of periods

# Returned            List of "component$State" in each main category as well as feedbacks and linkages as needed

########################################################
#      Signature <- list(
#        ID           =  11008,
#        Name.full    = "Transition environment setup 01",
#        Name.short   = "Transition01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "22 June 2005"
#        ) # end Signature


########################################################

{

#   ################################################################################
#   Links - setup linkages and other parameters within each component
#
#   ################################################################################

# ?? not used at present

# C.LI.Links.01.01(Universe, Calendar)

#   ################################################################################
#   Create a Transition State in each element
#     - used to update the State as impacted by other elements during a period
#     - leaves the original State as the reference State for use by other elements
#     - the Transition state is then copied to the State at the end of the period
#       after checking errors etc.
#   ################################################################################

#   biota environments

      if(!is.null(Universe$Biota)) {
        for (i in 1:Universe$Biota$Biota.N){


          Universe$Biota[[i]]$Transition<-list(
              change = c(),
#                         $change is a matrix with the following columns
#                         1.  subject polygon (e.g. destination polygon in migrate; prey polygon in foodweb)
#                         2.  origin polygon  (e.g. origin polygon in migrate; predator polygon in foodweb)
#                         3.  module          (e.g. Biota = 1)
#                         4.  element         (e.g. ref ID for migrate element or predator ref ID in foodweb)
#                         5.  units of qnty   (e.g. 1 = number, 2 = biomass)
#                         6.  quantity        (total quantity of change ie. + or -; NB this column is not to be summed as it needs to be multiplied by stagestructure)
#                         7.  stage age       (the age given to the stage)
#                         8.  stage proportn  (the proportion of the total quantity given to the stage)

              accumulate = list(
                            offspring = rep(0,Universe$Biota[[i]]$Polygons$Polygon.N),   # for accumulating offspring from reproduction in each polygon of the element
                            consumption = c()),
#                         $consumption saves the consumption of the different elements
#                         $consumption is a matrix with the following columns
#                         1.  subject polygon (e.g. predator polygon in foodweb)
#                         2.  origin polygon  (e.g. prey polygon in foodweb)
#                         3.  element         (e.g. prey ref ID in foodweb)
#                         4.  units of qnty   (e.g. 1 = number, 2 = biomass)
#                         5.  quantity        (total quantity of change ie. + or -; NB this column is not to be summed as it needs to be multiplied by stagestructure)
#                         6.  stage age       (the age given to the stage)
#                         7.  stage proportn  (the proportion of the total quantity given to the stage)
#                         8.  calendar year
#                         9.  proportion of year

              adopt = list()
#                         list of adoption events.  For each event, list of each polygon of an element, new additions to be adopted from other elements
#                         for each polygon, receive the State of the incoming additions

              ) # end transition list
        } # end i
      } # end biota

#    Environment
      if(!is.null(Universe$Environment)) {
        for (i in 1:Universe$Environment$Environment.N){
          Universe$Environment[[i]]$Transition$State<-Universe$Environment[[i]]$State
        } # end i
      } # end Environment

#    Activities
      if(!is.null(Universe$Activities)) {
        for (i in 1:Universe$Activities$Activities.N){
          Universe$Activities[[i]]$Transition$State<-Universe$Activities[[i]]$State
        } # end i
      } # end Activities

#    Management
      if(!is.null(Universe$Management)) {
        for (i in 1:Universe$Management$Management.N){
          Universe$Management[[i]]$Transition$State<-Universe$Management[[i]]$State
        } # end i
      } # end Management

#    Output
      if(!is.null(Universe$Output)) {
        for (i in 1:Universe$Output$Output.N){
          Universe$Output[[i]]$Transition$State<-Universe$Output[[i]]$State
        } # end i
      } # end Management

} # end function

