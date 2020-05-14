function (Element,              # component of Universe$Biota
          PeriodLastDay,        # the last day of the period
          PeriodYearPropn,      # the fraction of the year encompassed by the period
          dSet,                 # dataset to be used with function
          ElementTimeStep,      # the timestep for that taxon
          ElementTimeStepProp,  # the proportion of the timestep taken up in the period
          Universe              # access to universe if needed
          )                     # end input parameters

# Function:           B.PD.update_age.01
# Version             0.01

# Description:        Update the ages of the taxon, including adding offspring to the youngest stage

# Notes               No dataset is required for this function
#                     This function is written for consecutive ages in the age structure

# Input data:         as above
#                     dSet : currently an empty list


# Return data:        none at present

########################################################
#      Signature <- list(
#        ID           =  29010,
#        Name.full    = "Update age",
#        Name.short   = "Update age",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "13 June 2005"
#        ) # end Signature

#   Elements using this function
#     E. superba    ID = 22001

########################################################

{


# update age structure in each polygon

for (pn in 1:Universe$Biota[[Element]]$Polygons$Polygon.N) {

#   establish new age structure
      if(Universe$Biota[[Element]]$State$StageStrUnits==1) { # if abundances in Number

          Nages<-Universe$Biota[[Element]]$State$StageN

          AgeStr<-Universe$Biota[[Element]]$State$Abundance[[1]][pn]*Universe$Biota[[Element]]$State$StageStr[[pn]][,2]

          NewAgeStr<-rep(0,Nages)
          if(Nages>1) {
            NewAgeStr[2:Nages]<-AgeStr[1:(Nages-1)]
            NewAgeStr[Nages]<-NewAgeStr[Nages]+AgeStr[Nages]
          } # end Nages>1
          NewAgeStr[1]<-NewAgeStr[1]+Universe$Biota[[Element]]$Transition$accumulate$offspring[pn]

#         reset offspring to zero for accumulation until next update.age
          Universe$Biota[[Element]]$Transition$accumulate$offspring[pn]<-0

          SumNewAgeStr<-sum(NewAgeStr)
          Universe$Biota[[Element]]$State$Abundance[[1]][pn]<-SumNewAgeStr

      TempStageStr<-rep(1/Universe$Biota[[Element]]$State$StageN,Universe$Biota[[Element]]$State$StageN)
      if(SumNewAgeStr!=0) TempStageStr<-NewAgeStr/SumNewAgeStr


          Universe$Biota[[Element]]$State$StageStr[[pn]][,2]<-TempStageStr

#         Update biomass given the new age structure (makes no sense to downgrade numbers below if the units are biomass)
#         do this by updating with size condition
          Universe$Biota[[Element]]$State$Abundance[[2]][pn]<-sum(NewAgeStr*Universe$Biota[[Element]]$State$Cond.S[[pn]])
      } # end N

      if(Universe$Biota[[Element]]$State$StageStrUnits==2) { # if abundances in Biomass
          Nages<-Universe$Biota[[Element]]$State$StageN
          AgeStr<-Universe$Biota[[Element]]$State$Abundance[[2]][pn]*Universe$Biota[[Element]]$State$StageStr[[pn]][,2]
          NewAgeStr<-rep(0,Nages)
          if(Nages>1) {
            NewAgeStr[2:Nages]<-AgeStr[1:(Nages-1)]
            NewAgeStr[Nages]<-NewAgeStr[Nages]+AgeStr[Nages]
          } # end Nages>1

          NewAgeStr[1]<-NewAgeStr[1]+Universe$Biota[[Element]]$Transition$accumulate$offspring[pn]

#         reset offspring to zero for accumulation until next update.age
          Universe$Biota[[Element]]$Transition$accumulate$offspring[pn]<-0

          Universe$Biota[[Element]]$State$Abundance[[2]][pn]<-sum(NewAgeStr)
          Universe$Biota[[Element]]$State$StageStr[[pn]][,2]<-NewAgeStr/Universe$Biota[[Element]]$State$Abundance[[1]][pn]

      } # end B

} # end pn


#   ############################################################################
#   return
#   ############################################################################

}

