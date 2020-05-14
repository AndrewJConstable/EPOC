function (Taxon,Element,Universe,ElementID,ElementNames,Diary)

# Function:           B.AB.Afurseal.SGW.01.juv.setup.01
# Description:        Biological Element, Group Air-breathers, Antarctic Fur Seal - South Georgia - juvenile - setup function
# Primary attributes: Routines to update the taxon environment that requires knowledge of the ecosystem
#                     e.g. the setup routine for this element identifies what other elements (biota, environment etc.)
#                     are used by this element.  it will then check to see the IDs are available in the Universe
#                     and then will change the IDs to relative IDs within the Universe

# Input parameters    Taxon       = the specific element environment
#                     Element     = the relative number of the taxon
#                     Universe    = the entire Universe, in case it is needed for specific Setup functions
#                     ElementID   = matrix of ID given in original signature (column 1) and relative ID within Universe (column 2)
#                     ElementNames = vector of Names for elements if needed.
#                     Diary       = the diary of periods

{


#    Taxon$Signature <- list(
#      ID           = 25006,
#      Name.full    = "Ant fur seal SGW juv setup",
#      Name.short   = "AFS SGW juv",
#      Morph        = "01",
#      Version      = "01",
#      Authors      = "A.Constable",
#      last.edit    = "22 June 2005"
#      ) # end Signature



# ############################################################################
# Change ID
# ############################################################################

# change ID of element to transfer to another element

    for (tn in 1:Taxon$TimeSteps.N) {
      if(!is.null(Taxon$TimeSteps[[tn]]$actions$change.element)) {
            InheritID <- Taxon$TimeSteps[[tn]]$actions$change.element$dSet$new.element
            Taxon$TimeSteps[[tn]]$actions$change.element$dSet$new.element<-ElementID[is.element(ElementID[,1],InheritID),2]
     } # end change.element
    } # end tn

# change ID for each prey element to a reference in Universe$Biota

# loop through each foraging set to change ID of element to reference number in Biota

    for (i in 1:Taxon$TimeSteps.N) {

      if(!is.null(Taxon$TimeSteps[[i]]$actions$consume)) {
          for (k in 1:Taxon$TimeSteps[[i]]$actions$consume$dSet$Prey.N) {
            PreyID <- Taxon$TimeSteps[[i]]$actions$consume$dSet$Prey[k]
            Taxon$TimeSteps[[i]]$actions$consume$dSet$Prey[k]<-ElementID[is.element(ElementID[,1],PreyID),2]
          } # end k
      } # end timestep

    } # end i



# ############################################################################
# Convert timesteps to periods
# ############################################################################

# note rules for translating actions from timesteps to periods in this element

# initialisation

  Tstep.current<-0   # current timestep number
  PtimeSteps<-list() # list to replace timesteps in the Biota[[]] environment

# loop through each period

  for (pe in 1:Diary$Period.N) {

#    need to preserve the actions in the order that they are listed for a given timestep


#    accumulate actions for period in a list

         PtStepActions<-list()
         PtStepAction.N<-0

#     in order to keep the actions in the order recorded for the timestep
#     a matrix saves the reference in the action list in Col 1 and the reference in PtStepActions in Col 2
#           this is sorted at the end by Col 1 and the reference in Col 2 used to build the new list

         PtSAorder<-c()


#    test whether timestep is new - if so change to timestep within period

         if (Diary[[pe]]$Biota[Element,1]!=Tstep.current) {
             Tstep.current<-Diary[[pe]]$Biota[Element,1]
             } # end change timestep

#    test for each type of action in active timestep and setup action in period according to the rules


##################### change.element ##############################################

         if(!is.null(Taxon$TimeSteps[[Tstep.current]]$actions$change.element)) {

#           Rule - it will occur in the last period of the time step

#             if the action should be included then add the action

#             put rule test here if needed

              if (Diary[[pe]]$Day==Taxon$TimeSteps[[Tstep.current]]$calday) {

                  PtStepAction.N<-PtStepAction.N+1

#             1. identify the action number (position in list) corresponding to this action

                  Action.ref<-U.element.ref.in.list.01(Taxon$TimeSteps[[Tstep.current]]$actions,"change.element")

#             2. copy all of timestep action to period action
                  PtSA<-Taxon$TimeSteps[[Tstep.current]]$actions[Action.ref]

#             3. alter timestep details to period details

#             4, add details to temporary list

                  PtStepActions<-c(PtStepActions,PtSA)
                  PtSAorder<-rbind(PtSAorder,c(Action.ref,PtStepAction.N))

#             end rule test here if needed
                  } # end if


          } # end test evolve present


##################### adopt ##############################################

         if(!is.null(Taxon$TimeSteps[[Tstep.current]]$actions$adopt)) {

#           Rule - it will occur in the last period of the time step

#             if the action should be included then add the action

#             put rule test here if needed

              if (Diary[[pe]]$Day==Taxon$TimeSteps[[Tstep.current]]$calday) {

                  PtStepAction.N<-PtStepAction.N+1

#             1. identify the action number (position in list) corresponding to this action

                  Action.ref<-U.element.ref.in.list.01(Taxon$TimeSteps[[Tstep.current]]$actions,"adopt")

#             2. copy all of timestep action to period action
                  PtSA<-Taxon$TimeSteps[[Tstep.current]]$actions[Action.ref]

#             3. alter timestep details to period details

#             4, add details to temporary list

                  PtStepActions<-c(PtStepActions,PtSA)
                  PtSAorder<-rbind(PtSAorder,c(Action.ref,PtStepAction.N))

#             end rule test here if needed
                  } # end if


          } # end test evolve present

##################### update.age ##############################################

         if(!is.null(Taxon$TimeSteps[[Tstep.current]]$actions$update.age)) {

#           Rule - it will occur in the last period of the time step

#             if the action should be included then add the action

#             put rule test here if needed

              if (Diary[[pe]]$Day==Taxon$TimeSteps[[Tstep.current]]$calday) {

                  PtStepAction.N<-PtStepAction.N+1

#             1. identify the action number (position in list) corresponding to this action

                  Action.ref<-U.element.ref.in.list.01(Taxon$TimeSteps[[Tstep.current]]$actions,"update.age")

#             2. copy all of timestep action to period action
                  PtSA<-Taxon$TimeSteps[[Tstep.current]]$actions[Action.ref]

#             3. alter timestep details to period details

#             4, add details to temporary list

                  PtStepActions<-c(PtStepActions,PtSA)
                  PtSAorder<-rbind(PtSAorder,c(Action.ref,PtStepAction.N))

#             end rule test here if needed
                  } # end if

          } # end test update.age present

##################### update.size ##############################################
         if(!is.null(Taxon$TimeSteps[[Tstep.current]]$actions$update.size)) {

#           Rule -  it will occur in the last period of the time step

#             if the action should be included then add the action

#             put rule test here if needed

              if (Diary[[pe]]$Day==Taxon$TimeSteps[[Tstep.current]]$calday) {

                  PtStepAction.N<-PtStepAction.N+1

#             1. identify the action number (position in list) corresponding to this action

                  Action.ref<-U.element.ref.in.list.01(Taxon$TimeSteps[[Tstep.current]]$actions,"update.size")

#             2. copy all of timestep action to period action
                  PtSA<-Taxon$TimeSteps[[Tstep.current]]$actions[Action.ref]

#             3. alter timestep details to period details

#             4, add details to temporary list

                  PtStepActions<-c(PtStepActions,PtSA)
                  PtSAorder<-rbind(PtSAorder,c(Action.ref,PtStepAction.N))
#             end rule test here if needed
                  } # end if

          } # end test update.size present


##################### update.health ##############################################

         if(!is.null(Taxon$TimeSteps[[Tstep.current]]$actions$update.health)) {

#           Rule - it will occur in the last period of the time step

#             if the action should be included then add the action

#             put rule test here if needed

              if (Diary[[pe]]$Day==Taxon$TimeSteps[[Tstep.current]]$calday) {

                  PtStepAction.N<-PtStepAction.N+1

#             1. identify the action number (position in list) corresponding to this action

                  Action.ref<-U.element.ref.in.list.01(Taxon$TimeSteps[[Tstep.current]]$actions,"update.health")

#             2. copy all of timestep action to period action
                  PtSA<-Taxon$TimeSteps[[Tstep.current]]$actions[Action.ref]

#             3. alter timestep details to period details

#             4, add details to temporary list

                  PtStepActions<-c(PtStepActions,PtSA)
                  PtSAorder<-rbind(PtSAorder,c(Action.ref,PtStepAction.N))

#             end rule test here if needed
                  } # end if

          } # end test update.health present

##################### Reproduction ##############################################

         if(!is.null(Taxon$TimeSteps[[Tstep.current]]$actions$reproduce)) {

#           Rule - reproduction occurs in the first period of the timestep based on the SSB at beginning of timestep

#             if the action should be included then add the action

#             put rule test here if needed

              if (Diary[[pe]]$Biota[Element,1]==1) {

                  PtStepAction.N<-PtStepAction.N+1

#             1. identify the action number (position in list) corresponding to this action

                  Action.ref<-U.element.ref.in.list.01(Taxon$TimeSteps[[Tstep.current]]$actions,"reproduce")

#             2. copy all of timestep action to period action
                  PtSA<-Taxon$TimeSteps[[Tstep.current]]$actions[Action.ref]

#             3. alter timestep details to period details

#             4, add details to temporary list

                  PtStepActions<-c(PtStepActions,PtSA)
                  PtSAorder<-rbind(PtSAorder,c(Action.ref,PtStepAction.N))

#             end rule test here if needed
                  } # end if

          } # end test reproduce present


##################### migrate ##############################################

         if(!is.null(Taxon$TimeSteps[[Tstep.current]]$actions$migrate)) {

#           Rule - change migration pattern (given as annual rates) to period so as to
#                  maintain constant rate over the year

#             if the action should be included then add the action

#             put rule test here if needed

                  PtStepAction.N<-PtStepAction.N+1

#             1. identify the action number (position in list) corresponding to this action

                  Action.ref<-U.element.ref.in.list.01(Taxon$TimeSteps[[Tstep.current]]$actions,"migrate")

#             2. copy all of timestep action to period action
                  PtSA<-Taxon$TimeSteps[[Tstep.current]]$actions[Action.ref]

#             3. alter timestep details to period details
#                determine migration pattern for the period, taking account of the proportion of the year of the period

                 PtSA[[1]]$dSet$Pattern<-(1-(1-Taxon$TimeSteps[[Tstep.current]]$actions$migrate$dSet$Pattern)^Diary[[pe]]$YearPropn)

#                 correct the movement for the origin=destination case where the rate should be (1-sum(rest of the destinations))

                  for (od in 1:Taxon$Polygons$Polygon.N) {
                    PtSA[[1]]$dSet$Pattern[od,od]<-(1-(sum(PtSA[[1]]$dSet$Pattern[,od])-PtSA[[1]]$dSet$Pattern[od,od]))
                  } # end od

#             4, add details to temporary list
                  PtStepActions<-c(PtStepActions,PtSA)
                  PtSAorder<-rbind(PtSAorder,c(Action.ref,PtStepAction.N))

#             end rule test here if needed

          } # end test migrate present


##################### consume ##############################################

         if(!is.null(Taxon$TimeSteps[[Tstep.current]]$actions$consume)) {

#           Rule - change consumption rates (given as annual rates) to period so as to
#           maintain constant rate over the year

#             if the action should be included then add the action

#             put rule test here if needed

                  PtStepAction.N<-PtStepAction.N+1

#             1. identify the action number (position in list) corresponding to this action

                  Action.ref<-U.element.ref.in.list.01(Taxon$TimeSteps[[Tstep.current]]$actions,"consume")

#             2. copy all of timestep action to period action
                  PtSA<-Taxon$TimeSteps[[Tstep.current]]$actions[Action.ref]
#             3. alter timestep details to period details

                  for (iPrey in 1:length(PtSA[[1]]$dSet$Prey.data)){
                    PtSA[[1]]$dSet$Prey.data[[iPrey]]$FnFeedParams$ConsumeRate<-
                            (1-(1-PtSA[[1]]$dSet$Prey.data[[iPrey]]$FnFeedParams$ConsumeRate)^Diary[[pe]]$YearPropn)

                    } # end iPrey

#             4, add details to temporary list

                  PtStepActions<-c(PtStepActions,PtSA)
                  PtSAorder<-rbind(PtSAorder,c(Action.ref,PtStepAction.N))

#             end rule test here if needed

          } # end test consume present


#################
# add period actions to list

# ensure actions are in order

#    reset main components of list including last day in period,
#    number of actions (set to 0 until actions added), list of actions (set to null until actions added)

     PtimeSteps<-c(PtimeSteps,list(list(calday=Diary[[pe]]$Day,actions.N=PtStepAction.N,actions=list())))

     if(PtStepAction.N>0) {

#     put actions in correct order then add to period
#       sadly, no matrix sort function in R so the following arcane method is required

#       take column one (action ref in original time step list) and sort this as a vector
          OrigTimeStepOrder<-sort(PtSAorder[,1])

#       loop through the action list
          for (actn in 1:PtStepAction.N) {

#         using sorted vector, extract the reference to the action
            ActnRef<-PtSAorder[is.element(PtSAorder[,1],OrigTimeStepOrder[actn]),2]

#         add the action to the list in its correct position

              PtimeSteps[[pe]]$actions<-c(PtimeSteps[[pe]]$actions,PtStepActions[ActnRef])

          } # end do loop

       } # end if

print(attributes(PtimeSteps[[pe]]$actions)$names)

  } # end period loop

# add list back to environment

Taxon$TimeSteps<-PtimeSteps
Taxon$TimeSteps.N<-Diary$Period.N

# ############################################################################
# Generate lookup tables for datasets in each period
# ############################################################################

# could include size at age


} #     end function

