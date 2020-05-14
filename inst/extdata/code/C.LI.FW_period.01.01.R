function (Biota,DI.period)
# Function:           C.LI.FW_period.01.01
# Description:        General controller of foodweb linkages - determine for a given period
# Primary attributes: Determine predator prey linkages at the beginning of the simulation for a given period in the diary
#

# Input parameters:   Biota
#                     DI.period : matrix showing which timesteps are used for each taxon (a subset of Diary)

# Returned            Linkages matrix

########################################################
#      Signature <- list(
#        ID           =  11007,
#        Name.full    = "Predator prey Linkages 01",
#        Name.short   = "Foodweb01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "30 May 2005"
#        ) # end Signature


########################################################
{
# Create vectors of names and ID numbers

  ElementID<-vector(mode="integer",length=BiotaN)
  ElementNames<-vector(mode="character",length=BiotaN)

  for (i in 1:Biota$Biota.N){
    ElementID[i]<-Biota[[i]]$Signature$ID
    ElementNames[i]<-Biota[[i]]$Name.short
  }

# Create matrix of predators (columns) to prey (rows) using "consume.data" with one additional row to count unidentified prey
#         - fill with zeros

  fw1<-matrix(0,nrow=BiotaN+1,ncol=BiotaN)

# loop through biota and each foraging set to compare ID of taxa consumed with ID list and make up foodweb matrix

  for (i in 1:Biota$Biota.N){
#           establish null vector for accumulating prey ID from a predator
            IDsp<-vector(mode="integer",length=0)

#     if foraging occurs in the relevant timestep of the taxon that occurs in this period of the diary then

      if(!is.null(Biota[[i]]$TimeSteps[[DI.period[i,1]]]$actions$consume)) {

##############################?????????????????? change this to reflect the changes in krill - start and end period actions
#                                                also change the reference to dSet which will require changes to structure in the krill predator

#         a) identify the foraging data set used if foraging occurs as an activity
              foraging.data<-Biota[[i]]$TimeSteps[[DI.period[i,1]]]$actions$consume$dSet
#         b) loop through the species ID lists to accumulate vector of prey ID
          for (k in 1:Biota[[i]]$Foraging.data[[foraging.data]]$speciesN){

#           add prey ID to vector
                IDsp<-c(IDsp,Biota[[i]]$Foraging.data[[foraging.data]]$species[[k]])

              } # end k

#         eliminate duplicates of prey ID
          IDsp<-unique(IDsp)

#         create full taxon vector of IDs
          eID<-ElementID

#         make all taxa not identified as prey equal to 0 (for the foodweb matrix)
          eID[!is.element(eID,IDsp)]<-0

#         make all taxa identified as prey equal to 1(for the foodweb matrix)
          eID[is.element(eID,IDsp)]<-1

#         determine how many prey had been identified but are not a recognised taxon in Biota (IDs were incorrect)
#         add this number to the last row as unidentified prey
          eID<-c(eID,(length(IDsp)-sum(eID)))

#         add column to food web
          fw1[,i] <- eID
       } # end if !is.null

  } # end i


# return
#       Matrix of predator-prey relationships

list(fw1)

}

