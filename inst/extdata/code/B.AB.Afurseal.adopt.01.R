function (Element,              # component of Universe$Biota
          PeriodLastDay,        # the last day of the period
          PeriodYearPropn,      # the fraction of the year encompassed by the period
          dSet,                 # dataset to be used with function
          ElementTimeStep,      # the timestep for that taxon
          ElementTimeStepProp,  # the proportion of the timestep taken up in the period
          Universe              # access to universe if needed
          )                     # end input parameters

# Function:           B.AB.Afurseal.adopt.01
# Version             0.01

# Description:        Marine mammal & bird population dynamics function - adopt version 1

# Primary attributes: adopt pups to juveniles

# Input data:         as above
#                     dSet : no dataset


#                             Each parameter set has
#                                 new.element               [ID - reference to element in Universe$Biota]
#                                 prop.to.change            [list for each polygon, vector of proportions for each stage class in element to change from this element to next
#                                 new.element.stage.classes [nested - list for each polygon of old element,
#                                                                 list for each stage class, array -
#                                                                 col 1 = new element polygon,
#                                                                 col 2 = stage class of new element,
#                                                                 col 3 = proportion of old stage class in prop.to.change going to new element

# currently assumes moving numbers and not biomass


# Return data:        none at present - added directly to Transition

########################################################
#      Signature <- list(
#        ID           =  25006,
#        Name.full    = "Change stage - function 01",
#        Name.short   = "Change.stage.01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "22 June 2005"
#        ) # end Signature

#   Elements using this function
#     B.AB.Afurseal.SGW.01.pup.    ID = 25001

########################################################

{

#?????????????????????/needs substantial revision

Adopted<-Universe$Biota[[Element]]$Transition$adopt


NewState<-Universe$Biota[[Element]]$State

Adopt.events.N<-length(Adopted)

# data in each event are
#       abundance     = new.abund.at.stage, (matrix of stage (row) by polygon (col) of abundances in the selected units)
#       StageStrUnits = Universe$Biota[[Element]]$State$StageStrUnits,
#       Cond.R        = new reproductive condition
#       Cond.S        = new.size.at.stage,
#       Cond.H        = new.health.at.stage)

# ?????????? at this stage, only deal with abundance and StageStrUnits

if (Adopt.events.N>0) { # check for null case

# print(paste("Adopt - Element ",as.character(Element)," abundance before adopt = ",sum(Universe$Biota[[Element]]$State$Abundance[[Universe$Biota[[Element]]$State$StageStrUnits]])))

for (ad in 1:Adopt.events.N) {

# for each polygon

for (pn in 1:Universe$Biota[[Element]]$Polygons$Polygon.N) {

#     check all records are in the correct abundance units as specified by $State$StageStrUnits

#        if (is.null(TchangePn[!is.element(TchangePn[,5],Universe$Biota[[Element]]$State$StageStrUnits),])) {
#          stop ("transition$change records not all in the same units: Element ",as.character(Element)," Polygon ",as.character(pn))
#        } # end check all are in correct units

#     calculate new attributes of State - polygon, stage, N, B

#       initialise vector of abundance in each stage

        Abund<-rep(0,Universe$Biota[[Element]]$State$StageN)

        for (st in 1:Universe$Biota[[Element]]$State$StageN) {

#         calculate abundance of the stage in the current state (abundance of correct units for a polygon * age structure)


          AbStageInitial <- Universe$Biota[[Element]]$State$Abundance[[Adopted[[ad]]$StageStrUnits]][pn]*
                     Universe$Biota[[Element]]$State$StageStr[[pn]][st,2]



#         calculate new abundance based on the changes to the polygon
          AbStage <- AbStageInitial+Adopted[[ad]]$abundance[st,pn]
#          check that sufficient in each stage was available - if not do error routine and make stage & its abundance = 0

#           ?????? needs to be improved

              if (AbStage<0) {
                print(paste("Stage less than zero in update_State: Element ",as.character(Element)," Polygon ",as.character(pn)," Qty ",AbStage/AbStageInitial,sep=""))
                AbStage<-0
              }

           Abund[st]<-AbStage

        } # end st


#     update abundances

      SumAbund<-sum(Abund)
      if(Adopted[[ad]]$StageStrUnits==1) { # if abundances in Number
          NewState$Abundance[[1]][pn]<-SumAbund


          NewState$Abundance[[2]][pn]<-sum(Abund*Universe$Biota[[Element]]$State$Cond.S[[pn]])

      } # end N

      if(Adopted[[ad]]$StageStrUnits==2) { # if abundances in Biomass
          NewState$Abundance[[2]][pn]<-SumAbund
          NewState$Abundance[[1]][pn]<-sum(Abund/Universe$Biota[[Element]]$State$Cond.S[[pn]])
      } # end N

#     update stage structure

      NewState$StageStr[[pn]][,2]<-rep(1/Universe$Biota[[Element]]$State$StageN,Universe$Biota[[Element]]$State$StageN)
      if(SumAbund!=0) NewState$StageStr[[pn]][,2]<-Abund/SumAbund


#print(paste("Element ",as.character(Element),"  polygon ",as.character(pn),"  New stage structure",sep=""))
#print(NewState$StageStr[[pn]])

#     update reproductive condition as averages

#print("start print")
#print(Adopted[[ad]]$Cond.R[[pn]])
#print("mid print")
#print(Universe$Biota[[Element]]$State$Cond.R[[pn]])
#print("end print")

NewState$Cond.R[[pn]]<-(Universe$Biota[[Element]]$State$Abundance[[1]][pn]*Universe$Biota[[Element]]$State$Cond.R[[pn]]+
                 (NewState$Abundance[[1]][pn]-Universe$Biota[[Element]]$State$Abundance[[1]][pn])*Adopted[[ad]]$Cond.R[[pn]])/NewState$Abundance[[1]][pn]

      } #     end polygon
  }# end adooption events

# update State

Universe$Biota[[Element]]$State<-NewState

# reset $Transition$change to null

Universe$Biota[[Element]]$Transition$adopt<-c()

#print(paste("Adopt - Element ",as.character(Element)," abundance after adopt = ",sum(Universe$Biota[[Element]]$State$Abundance[[Universe$Biota[[Element]]$State$StageStrUnits]])))

} # end if adopted events >0


#   ############################################################################
#   return
#   ############################################################################


}

