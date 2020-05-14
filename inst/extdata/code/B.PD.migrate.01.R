function (Element,              # component of Universe$Biota
          PeriodLastDay,        # the last day of the period
          PeriodYearPropn,      # the fraction of the year encompassed by the period
          dSet,                 # dataset to be used with function
          ElementTimeStep,      # the timestep for that taxon
          ElementTimeStepProp,  # the proportion of the timestep taken up in the period
          Universe              # access to universe if needed
          )                     # End input parameters

# Function:           PD.migrate.01
# Version             0.01

# Description:        Population dynamics function - migration version 1

# Notes:              migrate an element across an arena as requested

# Input data:         as above
#                     dSet : required data for function
#                             list of the following
#
#                             Data include
#                                 Pattern   matrix of probabilities of moving from one location to another location
#                                           polygon origins are rows, polygon destinations are columns

# Return data:

########################################################
#      Signature <- list(
#        ID           =  29002,
#        Name.full    = "Migration function - 01",
#        Name.short   = "Migrate01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "12 June 2005"
#        ) # end Signature

#   Elements using this function
#     E. superba    ID = 22001

########################################################

{

Nmatrix<-dSet$Pattern

# move the abundance (specified by dSet$Abund.Units) in each polygon according to the movement matrix in the dataset and
# create change in numbers (which means all immigration is positive and emigration needs to be changed to a
# difference from the original number)

# generate grouping variable for origin polygons

Porigin<-c()
AbUnits<-c()

for (pn in 1:Universe$Biota[[Element]]$Polygons$Polygon.N) {
    Abund.Units<-Universe$Biota[[Element]]$State$StageStrUnits

#   note that the abundances being moved are those nominated for the polygon or origin

    Nmatrix[,pn]<-Nmatrix[,pn]*Universe$Biota[[Element]]$State$Abundance[[Abund.Units]][pn]
    Nmatrix[pn,pn]<-Nmatrix[pn,pn]-Universe$Biota[[Element]]$State$Abundance[[Abund.Units]][pn]

#   if the polygon of destination has different abundance units then the quantities immigrating to those polygons
#   need to be converted to the correct abundance units (corrections not included yet)

#       ??? include conversion code here


    # create vectors for combining into 'change' matrix
    #     reference numbers for polygon of origin to be added to matrix
              Porigin<-c(Porigin,rep(pn,Universe$Biota[[Element]]$Polygons$Polygon.N))
    #     abundance units
              AbUnits<-c(AbUnits,rep(Abund.Units,Universe$Biota[[Element]]$Polygons$Polygon.N))
    } # end pn

# create vectors for combining into 'change' matrix
#     reference numbers for polygon of destination to be added to matrix
        Pdestn<-rep(1:Universe$Biota[[Element]]$Polygons$Polygon.N,Universe$Biota[[Element]]$Polygons$Polygon.N)
#     module number
        ModNum<-rep(1,Universe$Biota[[Element]]$Polygons$Polygon.N^2)
#     element number
        ElNum<-rep(Element,Universe$Biota[[Element]]$Polygons$Polygon.N^2)


Nmatrix<-cbind(Pdestn,Porigin,ModNum,ElNum,AbUnits,as.vector(Nmatrix))

NewChanges<-c()
for (iRow in 1:(Universe$Biota[[Element]]$Polygons$Polygon.N^2)) {

  CombinedMatrix<-as.matrix(data.frame(c(as.list(Nmatrix[iRow,]),
                                       data.frame(Universe$Biota[[Element]]$State$StageStr[Nmatrix[iRow,2]]))))

  dimnames(CombinedMatrix)<-NULL

  NewChanges<-rbind(NewChanges,CombinedMatrix)

} # end iRow


Universe$Biota[[Element]]$Transition$change<-rbind(Universe$Biota[[Element]]$Transition$change,NewChanges)

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
}

