function (Universe, Year, PerRefNo, Period, Trial.state)

# Function:           C.PJ.Period.01
# Description:        Projection over one period of the calendar
# Primary attributes:

# Input parameters:   Universe - list including one or more of
#                               (Biota, Environment, Activities, Management, Output, Presentation)
#                     PerRefNo - the reference number of the period in the diary
#                     Period - the list of properties of the period in the diary
#                     Trial.state - environment with the state variables of a trial such as year, period etc.

# Returned            List of "component$State" in each main category

########################################################
#      Signature <- list(
#        ID           =  11010,
#        Name.full    = "Projection over period",
#        Name.short   = "PJ_Period01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "14 June 2005"
#        ) # end Signature


########################################################

{ # start function

#    Environment
      if(!is.null(Universe$Environment)) {
        for (en in 1:Universe$Environment$Environment.N){
         if(Universe$Environment[[en]]$TimeSteps[[PerRefNo]]$actions.N>0) {

           for (an in 1:Universe$Environment[[en]]$TimeSteps[[PerRefNo]]$actions.N){
                Universe$Environment[[en]]$TimeSteps[[PerRefNo]]$actions[[an]]$Update.fn(
                    en,                # component of part e.g. element of environment
                    Year,
                    Period$Day,        # the last day of the period
                    Period$YearPropn,  # the fraction of the year encompassed by the period
                    Universe$Environment[[en]]$TimeSteps[[PerRefNo]]$actions[[an]]$dSet, # dataset to be used with function
                    Universe               # access to universe if needed
                    ) #end function call

            }
          }
        }
      }
#   biota environments

#   Beginning of time step

# all consider using linkages other than just in error checking
#       where 'IF's could be taken out by setting up vectors of components to be updated in each time step

      if(!is.null(Universe$Biota)) {
        for (bn in 1:Universe$Biota$Biota.N){

#         each action should have a function and a dataset - the function should be the place where the dataset
#         is managed (not in the action specification)

#         determine if there are any actions in time step

#            if(!is.null(Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions)) {
         if(Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions.N>0) {

          action.names<-attributes(Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions)$names

# print(c(paste("Element: ",as.character(bn),sep=""),paste(action.names,sep="  ")))

           for (an in 1:Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions.N){

#            only undertake actions permissable during timestep (update.age and update.size only occur after update.State)

              if(action.names[an]!="update.age" & action.names[an]!="update.size"
                 & action.names[an]!="change.element" & action.names[an]!="adopt"
                 & action.names[an]!="update.rep.cond") {

#                  call the function for the action sending the part of the universe, the component number,dataset,
#                 the timestep to use, the proportion of the time step that corresponds to the period,
#                 the transition environment & the feedback matrices for updating
#                 return the transition and feedback data as a list

                Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions[[an]]$Update.fn(
                    bn,                # component of part e.g. element of biota
                    Period$Day,        # the last day of the period
                    Period$YearPropn,  # the fraction of the year encompassed by the period
                    Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions[[an]]$dSet, # dataset to be used with function

                    Period$Biota[bn,1], # the timestep for that taxon
                    Period$Biota[bn,2], # the proportion of the timestep taken up in the period
                    Universe               # access to universe if needed
                    ) #end function call
              } # end if action.names

            } # end actions in period


           } # end if actions


        } # end bn

      } # end if biota

#    Activities

#    Management

#    Output

#    Presentation

################################################################################################
# Update the State of the Environments
#       including some actions that only occur at this time
#             update.age
#             update.size
#             change.state
################################################################################################

      if(!is.null(Universe$Biota)) {
        for (bn in 1:Universe$Biota$Biota.N){



      if(!is.null(Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions$update.rep.cond)) {
                Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions$update.rep.cond$Update.fn(
                    bn,                # component of part e.g. element of biota
                    Period$Day,        # the last day of the period
                    Period$YearPropn,  # the fraction of the year encompassed by the period
                    Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions$update.rep.cond$dSet, # dataset to be used with function

                    Period$Biota[bn,1], # the timestep for that taxon
                    Period$Biota[bn,2], # the proportion of the timestep taken up in the period
                    Universe               # access to universe if needed
                    ) #end function call
      } # end update.rep.cond

#         update State at end of period

            if(!is.null(Universe$Biota[[bn]]$Transition$change)) {

                Universe$Biota[[bn]]$Ancillary.fns$update.State(
                    bn,                 # component of part e.g. element of biota
                    Period$Day,         # the last day of the period
                    Period$YearPropn,   # the fraction of the year encompassed by the period
                    list(),             # dataset to be used with function - none needed here
                    Period$Biota[bn,1], # the timestep for that taxon
                    Period$Biota[bn,2], # the proportion of the timestep taken up in the period
                    Universe               # access to universe if needed
                    )#end function call
              } # end update state


#     undertake actions permissable only after State is updated - in this order

      if(!is.null(Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions$update.size)) {
                Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions$update.size$Update.fn(
                    bn,                # component of part e.g. element of biota
                    Period$Day,        # the last day of the period
                    Period$YearPropn,  # the fraction of the year encompassed by the period
                    Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions$update.size$dSet, # dataset to be used with function

                    Period$Biota[bn,1], # the timestep for that taxon
                    Period$Biota[bn,2], # the proportion of the timestep taken up in the period
                    Universe               # access to universe if needed
                    ) #end function call


      } # end update size

      if(!is.null(Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions$update.age)) {
                Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions$update.age$Update.fn(
                    bn,                # component of part e.g. element of biota
                    Period$Day,        # the last day of the period
                    Period$YearPropn,  # the fraction of the year encompassed by the period
                    list(), # dataset to be used with function

                    Period$Biota[bn,1], # the timestep for that taxon
                    Period$Biota[bn,2], # the proportion of the timestep taken up in the period
                    Universe               # access to universe if needed
                    ) #end function call


      } # end update age


      if(!is.null(Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions$change.element)) {

      print(paste("Element ",as.character(bn)," Timestep ",PerRefNo," - change element",sep=""))

#         step 1 - determine changes to be made
                Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions$change.element$Update.fn(
                    bn,                # component of part e.g. element of biota
                    Period$Day,        # the last day of the period
                    Period$YearPropn,  # the fraction of the year encompassed by the period
                    Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions$change.element$dSet, # dataset to be used with function

                    Period$Biota[bn,1], # the timestep for that taxon
                    Period$Biota[bn,2], # the proportion of the timestep taken up in the period
                    Universe               # access to universe if needed
                    ) #end function call
#         step 2 - re-update element to complete the transfer
            if(!is.null(Universe$Biota[[bn]]$Transition$change)) {

                Universe$Biota[[bn]]$Ancillary.fns$update.State(
                    bn,                 # component of part e.g. element of biota
                    Period$Day,         # the last day of the period
                    Period$YearPropn,   # the fraction of the year encompassed by the period
                    list(),             # dataset to be used with function - none needed here
                    Period$Biota[bn,1], # the timestep for that taxon
                    Period$Biota[bn,2], # the proportion of the timestep taken up in the period
                    Universe               # access to universe if needed
                    )#end function call
              } # end update state

      print("end change element")

      } # end change.element


      if(!is.null(Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions$adopt)) {

      print(paste("Element ",as.character(bn)," Timestep ",PerRefNo," - adopt",sep=""))

                Universe$Biota[[bn]]$TimeSteps[[PerRefNo]]$actions$adopt$Update.fn(
                    bn,                # component of part e.g. element of biota
                    Period$Day,        # the last day of the period
                    Period$YearPropn,  # the fraction of the year encompassed by the period
                    list(), # dataset to be used with function

                    Period$Biota[bn,1], # the timestep for that taxon
                    Period$Biota[bn,2], # the proportion of the timestep taken up in the period
                    Universe               # access to universe if needed
                    ) #end function call

      print("end adopt")

      } # end adopt

    } # end bn

  } # end if biota

#    Environment

#    Activities

#    Management

#    Output

#    Presentation


} # end function

