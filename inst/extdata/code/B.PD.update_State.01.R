function (Element,              # component of Universe$Biota
          PeriodLastDay,        # the last day of the period
          PeriodYearPropn,      # the fraction of the year encompassed by the period
          dSet,                 # dataset to be used with function
          ElementTimeStep,      # the timestep for that taxon
          ElementTimeStepProp,  # the proportion of the timestep taken up in the period
          Universe              # access to universe if needed
          )                     # end input parameters

# Function:           B.PD.update_State.01
# Version             0.01

# Description:        Population dynamics function - update the State of the element in each polygon
#                     based on the Transition$change part of the environment
#                     If there is insufficient abundance then an error routine is invoked to make the
#                     abundance equal to zero and to modify the amounts taken out of the polygon such as
#                     predator consumption amongst other corrections (migration corrections are not included at present)


# Notes               all $change records should be in the abundance units relevant to the specific polygon
#                         it is assumed that conversion from one unit to another has been achieved elsewhere
#                         an error will be recorded if this is not the case
#                     have not taken account of potentially different size conditions in different polygons and how
#                         these will combine to give an appropriate value for B/N.

# Input data:         as above

# Return data:        none at present

########################################################
#      Signature <- list(
#        ID           =  29008,
#        Name.full    = "Update state of the environment",
#        Name.short   = "Update State",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "13 June 2005"
#        ) # end Signature

#   Elements using this function
#     E. superba    ID = 22001

########################################################

{

Tchange<-Universe$Biota[[Element]]$Transition$change

#   columns in Change matrix
#         1.  subject polygon (e.g. destination polygon in migrate; prey polygon in foodweb)
#         2.  origin polygon  (e.g. origin polygon in migrate; predator polygon in foodweb)
#         3.  module          (module from which element came that caused change e.g. Biota = 1 if predator)
#         4.  element         (element in module that caused change e.g. ref ID for migrate element or predator ref ID in foodweb)
#         5.  units of qnty   (e.g. 1 = number, 2 = biomass)
#         6.  quantity        (total quantity of change ie. + or -; NB this column is not to be summed as it needs to be multiplied by stagestructure)
#         7.  stage age       (the age given to the stage)
#         8.  stage proportn  (the proportion of the total quantity given to the stage)


NewState<-Universe$Biota[[Element]]$State

# for each polygon

for (pn in 1:Universe$Biota[[Element]]$Polygons$Polygon.N) {

#     extract data just for the polygon of interest

        TchangePn<-Tchange[is.element(Tchange[,1],pn),]

#         extraction of TchangePn will produce a vector rather than matrix if only one row is found thus...

          if (!is.matrix(TchangePn)) TchangePn<-matrix(TchangePn,nrow=1)

#     estimate total changes in each of the stage structure elements (prop in stage(col8) x abundance(col6))

        TchangePn<-cbind(TchangePn,TchangePn[,6]*TchangePn[,8]) # column 9

#     check all records are in the correct abundance units as specified by $State$StageStrUnits

        if (is.null(TchangePn[!is.element(TchangePn[,5],Universe$Biota[[Element]]$State$StageStrUnits),])) {
          stop ("transition$change records not all in the same units: Element ",as.character(Element)," Polygon ",as.character(pn))
        } # end check all are in correct units

#     calculate new attributes of State - polygon, stage, N, B

#       initialise vector of abundance in each stage

        Abund<-rep(0,Universe$Biota[[Element]]$State$StageN)

        for (st in 1:Universe$Biota[[Element]]$State$StageN) {

#         calculate abundance of the stage in the current state (abundance of correct units for a polygon * age structure)


          AbStageInitial <- Universe$Biota[[Element]]$State$Abundance[[Universe$Biota[[Element]]$State$StageStrUnits]][pn]*
                     Universe$Biota[[Element]]$State$StageStr[[pn]][st,2]



#         calculate new abundance based on the changes to the polygon
          AbStage <- AbStageInitial+sum(TchangePn[is.element(TchangePn[,7],Universe$Biota[[Element]]$State$StageStr[[pn]][st,1]),9])
#          check that sufficient in each stage was available - if not do error routine and make stage & its abundance = 0

#           ?????? needs to be improved

#print(paste("Element ",as.character(Element)," Stage ",as.character(st),
#            " prop at stage ",as.character(Universe$Biota[[Element]]$State$StageStr[[pn]][st,2]),
#            "  Quantity = ",as.character(AbStage),sep=""))
#print(c(AbStage,AbStageInitial,sum(TchangePn[is.element(TchangePn[,7],Universe$Biota[[Element]]$State$StageStr[[pn]][st,1]),9])))
              if (AbStage<0) {
#                print(paste("Stage<0 in update : Element ",as.character(Element)," Polygon ",as.character(pn)," Stage ref ",as.character(st)," Qty ",AbStage,sep=""))
#                print(paste("initial abundance ",as.character(AbStageInitial)))
#                print (TchangePn[is.element(TchangePn[,7],Universe$Biota[[Element]]$State$StageStr[[pn]][st,1]),9])
                AbStage<-0
              }

           Abund[st]<-AbStage

        } # end st


#     update abundances for polygon

      SumAbund<-sum(Abund)
      if(Universe$Biota[[Element]]$State$StageStrUnits==1) { # if abundances in Number
          NewState$Abundance[[1]][pn]<-SumAbund


          NewState$Abundance[[2]][pn]<-sum(Abund*Universe$Biota[[Element]]$State$Cond.S[[pn]])

      } # end N

      if(Universe$Biota[[Element]]$State$StageStrUnits==2) { # if abundances in Biomass
          NewState$Abundance[[2]][pn]<-SumAbund
          NewState$Abundance[[1]][pn]<-sum(Abund/Universe$Biota[[Element]]$State$Cond.S[[pn]])
      } # end N

#     update stage structure

      NewState$StageStr[[pn]][,2]<-rep(1/Universe$Biota[[Element]]$State$StageN,Universe$Biota[[Element]]$State$StageN)
      if(SumAbund!=0) NewState$StageStr[[pn]][,2]<-Abund/SumAbund


#if(Element==1) print(list(Element = Element, Polygon = pn,Abund_vector=Abund,SumAbund = SumAbund,OldAgeStr = Universe$Biota[[Element]]$State$StageStr[[pn]],
#    NewAgeStr= NewState$StageStr[[pn]]))


      } #     end polygon



# update State

Universe$Biota[[Element]]$State<-NewState

# reset $Transition$change to null

Universe$Biota[[Element]]$Transition$change<-c()


#   ############################################################################
#   return
#   ############################################################################

}

