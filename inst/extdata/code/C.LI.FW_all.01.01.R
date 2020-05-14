function (Biota)
# Function:           C.LI.FW_all.01.01
# Description:        General controller of foodweb linkages - across all timesteps
# Primary attributes: Determine predator prey linkages at the beginning of the simulation
#                     Error check to ensure all linkages are valid

# Input parameters:   Ecosystem

# Returned            Linkages matrix

########################################################
#      Signature <- list(
#        ID           =  11006,
#        Name.full    = "Predator prey Linkages 01",
#        Name.short   = "Foodweb01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "29 May 2005"
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

#     loop through each foraging data set and the species ID lists to accumulate vector of prey ID
      for (j in 1:Biota[[i]]$Foraging.data$N.foraging.sets){
        for (k in 1:Biota[[i]]$Foraging.data[[j+1]]$speciesN){

#           add prey ID to vector
            IDsp<-c(IDsp,Biota[[i]]$Foraging.data[[j+1]]$species[[k]])

        } # end k
      } # end j


#     eliminate duplicates of prey ID
      IDsp<-unique(IDsp)

#     create full taxon vector of IDs
      eID<-ElementID

#     make all taxa not identified as prey equal to 0 (for the foodweb matrix)
      eID[!is.element(eID,IDsp)]<-0

#     make all taxa identified as prey equal to 1(for the foodweb matrix)
      eID[is.element(eID,IDsp)]<-1

#     determine how many prey had been identified but are not a recognised taxon in Biota (IDs were incorrect)
#     add this number to the last row as unidentified prey and generate error flag
      eID<-c(eID,(length(IDsp)-sum(eID)))
      if (eID[BiotaN+1]>0) FWerror01<-TRUE

#     add column to food web
      fw1[,i] <- eID

  } # end i


# return
#       1. 2 column matrix of Names and ID numbers
#       2. Matrix of predator-prey relationships
#       3. Error flag

list(ElementID,ElementNames,fw1,FWerror01)

}

