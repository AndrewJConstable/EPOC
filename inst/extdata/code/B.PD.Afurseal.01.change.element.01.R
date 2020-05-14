function (Element,              # component of Universe$Biota
          PeriodLastDay,        # the last day of the period
          PeriodYearPropn,      # the fraction of the year encompassed by the period
          dSet,                 # dataset to be used with function
          ElementTimeStep,      # the timestep for that taxon
          ElementTimeStepProp,  # the proportion of the timestep taken up in the period
          Universe              # access to universe if needed
          )                     # end input parameters

# Function:           B.AB.Afurseal.SGW.01.pup.change.stage.01
# Version             0.01

# Description:        Marine mammal & bird population dynamics function - change.stage version 1

# Primary attributes: transfer pups to juveniles

# Input data:         as above
#                     dSet : required data for function
#                             list of the following
#                             individual parameter sets in a list (number is indicated in dSet.N)
#                             that may be applied in different polygons
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

  # convert the current element's State to the new.element's State

  # create matrices for new element of attributes to be transferred to each Stage (rows) in each polygon (cols)

  old.abund.at.stage<-matrix(rep(0,Universe$Biota[[Element]]$State$StageN*Universe$Biota[[Element]]$Polygons$Polygon.N)
                      ,nrow = Universe$Biota[[Element]]$State$StageN
                      ,ncol=Universe$Biota[[Element]]$Polygons$Polygon.N)

  new.abund.at.stage<-matrix(rep(0,Universe$Biota[[dSet$new.element]]$State$StageN*Universe$Biota[[dSet$new.element]]$Polygons$Polygon.N)
                      ,nrow = Universe$Biota[[dSet$new.element]]$State$StageN
                      ,ncol=Universe$Biota[[dSet$new.element]]$Polygons$Polygon.N)
  new.size.at.stage<-matrix(rep(0,Universe$Biota[[dSet$new.element]]$State$StageN*Universe$Biota[[dSet$new.element]]$Polygons$Polygon.N)
                      ,nrow = Universe$Biota[[dSet$new.element]]$State$StageN
                      ,ncol=Universe$Biota[[dSet$new.element]]$Polygons$Polygon.N)
  new.health.at.stage<-matrix(rep(1,Universe$Biota[[dSet$new.element]]$State$StageN*Universe$Biota[[dSet$new.element]]$Polygons$Polygon.N)
                      ,nrow = Universe$Biota[[dSet$new.element]]$State$StageN
                      ,ncol=Universe$Biota[[dSet$new.element]]$Polygons$Polygon.N)

# for setting up the $change data below
  old.stage.str<-old.abund.at.stage

  # loop through polygons by stages of current element to fill matrix as appropriate (adding the new data into matrix)

#                                 prop.to.change            [list for each polygon, vector of proportions for each stage class in element to change from this element to next
#                                 new.element.stage.classes [nested - list for each polygon of old element,
#                                                                 list for each stage class, array -
#                                                                 col 1 = new element polygon,
#                                                                 col 2 = stage class of new element,
#                                                                 col 3 = proportion of old stage class in prop.to.change going to new element

  for (pn in 1:Universe$Biota[[Element]]$Polygons$Polygon.N){
    for (st in 1:Universe$Biota[[Element]]$State$StageN){
      old.abund.at.stage[st,pn]<-
          dSet$prop.to.change[[pn]][st]*
          Universe$Biota[[Element]]$State$Abundance[[Universe$Biota[[Element]]$State$StageStrUnits]][pn]*
          Universe$Biota[[Element]]$State$StageStr[[pn]][st,2]

#print(paste("polygon ",as.character(pn)," : stage ",as.character(st)," :  prop to change ",as.character(dSet$prop.to.change[[pn]][st])," :  poly abund ",
#          as.character(Universe$Biota[[Element]]$State$Abundance[[Universe$Biota[[Element]]$State$StageStrUnits]][pn])," :  stageprop ",
#          as.character(Universe$Biota[[Element]]$State$StageStr[[pn]][st,2]),sep=""))

      for (ne in 1:nrow(dSet$new.element.stage.classes[[pn]][[st]])) {
      new.abund.at.stage[dSet$new.element.stage.classes[[pn]][[st]][ne,2],dSet$new.element.stage.classes[[pn]][[st]][ne,1]]<-
          new.abund.at.stage[dSet$new.element.stage.classes[[pn]][[st]][ne,2],dSet$new.element.stage.classes[[pn]][[st]][ne,1]]+
          dSet$new.element.stage.classes[[pn]][[st]][ne,3]*old.abund.at.stage[st,pn]

# ????need to do an averaging routine i.e. sum the sizes and monitor the number added to each cell.  Then divide at end

#      new.size.at.stage[dSet$new.element.stage.classes[[pn]][[st]][ne,2],dSet$new.element.stage.classes[[pn]][[st]][ne,1]]<-
#          Universe$Biota[[Element]]$State$Cond.S[[pn]][st]
#      new.health.at.stage[dSet$new.element.stage.classes[[pn]][[st]][ne,2],dSet$new.element.stage.classes[[pn]][[st]][ne,1]]<-
#          Universe$Biota[[Element]]$State$Cond.H[[pn]][st]
          } # end ne
    } # end st
  } # end pn

#print(paste("Element ",as.character(Element)," Abundance ",sum(Universe$Biota[[Element]]$State$Abundance[[Universe$Biota[[Element]]$State$StageStrUnits]])))
#print(old.abund.at.stage)
#print(new.abund.at.stage)
#print(paste("        ",as.character(Element)," old_abund_sum ",sum(old.abund.at.stage)))
#print(paste("        ",as.character(Element)," new_abund_sum ",sum(new.abund.at.stage)))

# NB ?? temporary fix for updating reproductive condition

new.Cond.R<-as.list(rep(Universe$Biota[[Element]]$State$Cond.R[[1]],Universe$Biota[[dSet$new.element]]$Polygons$Polygon.N))

New.adoption<-list(abundance     = new.abund.at.stage,
                   StageStrUnits = Universe$Biota[[Element]]$State$StageStrUnits,
                   Cond.R        = new.Cond.R,
                   Cond.S        = new.size.at.stage,
                   Cond.H        = new.health.at.stage)

Universe$Biota[[dSet$new.element]]$Transition$adopt<-c(Universe$Biota[[dSet$new.element]]$Transition$adopt,list(New.adoption))


  # add to $Transition$change the negative quantities transferred to other elements - such as in movement

    # create total abundances measured here and transform abundance at stage to relative abundance at stage
    # also generate requirements for change matrix below

      # generate grouping variable for origin polygons

      Porigin<-c()
      AbUnits<-c()

  old.abund<-rep(0,Universe$Biota[[Element]]$Polygons$Polygon.N)

#print(paste ("Element ",as.character(Element),"  old abundance at stage",sep=""))
#print(old.abund.at.stage)

  for (pn in 1:Universe$Biota[[Element]]$Polygons$Polygon.N){
    # make the sum of the abundance negative for the change matrix
    old.abund[pn]<- (-sum(old.abund.at.stage[,pn]))
    old.stage.str[,pn]<-rep(1/Universe$Biota[[Element]]$State$StageN,Universe$Biota[[Element]]$State$StageN)
    if(old.abund[pn]!=0) old.stage.str[,pn]<-old.abund.at.stage[,pn]/(-old.abund[pn])


  } # end pn

# create vectors for combining into 'change' matrix

#     reference numbers for polygon of origin to be added to matrix
        Porigin<-c(1:Universe$Biota[[Element]]$Polygons$Polygon.N)
#     reference numbers for polygon of destination to be added to matrix
        Pdestn<-Porigin
#     module number
        ModNum<-rep(1,Universe$Biota[[Element]]$Polygons$Polygon.N)
#     element number
        ElNum<-rep(Element,Universe$Biota[[Element]]$Polygons$Polygon.N)
#     abundance units
        AbUnits<-rep(Universe$Biota[[Element]]$State$StageStrUnits,Universe$Biota[[Element]]$Polygons$Polygon.N)

Nmatrix<-cbind(Pdestn,Porigin,ModNum,ElNum,AbUnits,as.vector(old.abund))
  dimnames(Nmatrix)<-NULL

NewChanges<-c()
for (iRow in 1:Universe$Biota[[Element]]$Polygons$Polygon.N) {
#    for (st in 1:Universe$Biota[[Element]]$State$StageN){
      StageStrMat<-cbind(Universe$Biota[[Element]]$State$StageStr[[iRow]][,1],old.stage.str[,iRow])
      dimnames(StageStrMat)<-NULL
      CombinedMatrix<-as.matrix(data.frame(c(as.list(Nmatrix[iRow,]),data.frame(StageStrMat))))
      dimnames(CombinedMatrix)<-NULL

      NewChanges<-rbind(NewChanges,CombinedMatrix)
#  } # end st
} # end iRow

Universe$Biota[[Element]]$Transition$change<-rbind(Universe$Biota[[Element]]$Transition$change,NewChanges)

#print("Adoption & change")
#print(New.adoption)
#print(NewChanges)
#print (paste("Abundance of Element ",as.character(Element)," - ",sum(Universe$Biota[[Element]]$State$Abundance[[Universe$Biota[[Element]]$State$StageStrUnits]]),sep=""))
#print (paste("For adoption  ",as.character(sum(New.adoption$abundance)),sep=""))
#print (paste("Abund changes  ",as.character(sum(NewChanges[,6]*NewChanges[,8])),sep=""))

#   columns in Change matrix
#         1.  subject polygon (e.g. destination polygon in migrate; prey polygon in foodweb)
#         2.  origin polygon  (e.g. origin polygon in migrate; predator polygon in foodweb)
#         3.  module          (e.g. Biota = 1)
#         4.  element         (e.g. ref ID for migrate element or predator ref ID in foodweb)
#         5.  units of qnty   (e.g. 1 = number, 2 = biomass)
#         6.  quantity        (total quantity of change ie. + or -; NB this column is not to be summed as it needs to be multiplied by stagestructure)
#         7.  stage age       (the age given to the stage)
#         8.  stage proportn  (the proportion of the total quantity given to the stage)


#   ############################################################################
#   return
#   ############################################################################

}

