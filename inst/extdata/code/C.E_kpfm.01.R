function (Nyrs=2,MonUnits=1,Plot.by.area=FALSE)
# Function:           C.E_kpfm.01
# Description:        EPOC simulation of KPFM (Watters etal 2005)

# Primary attributes: the primary function for running the ecosystem model

{


#   ################################################################################
#   epoc - create new environment & note details of routine
#   ################################################################################

    epoc<-new.env()

    epoc$Signature <- list(
      ID           =  11001,
      Name.full    = "EPOC simulation of KPFM",
      Name.short   = "EPOC-KPFM",
      Version      = "01",
      Authors      = "A.Constable",
      last.edit    = "6 July 2005"
      ) # end Signature


#   ################################################################################
#   establish universe and trial conditions - inputs
#   ################################################################################

#   Specify the universe for the epoc scenario

    Universe<-C.kpfm.universe.01()

#   set trial state variables in an environment

    Trial.State<-C.kpfm.trial.01()

#   ################################################################################
#   establish an annual Calendar of periods in which actions take place
#   ################################################################################

    Calendar<-C.Cal.01.01(Universe)


#   ################################################################################
#   setup the universe, including
#      replacing ID numbers with references to elements in the universe
#      generate transition matrices necessary for the actions in each period
#   ################################################################################


    C.SE.Setup.universe.01(Universe,Calendar)

#   ################################################################################
#   set up transition and feedback systems for updating the Universe during a period
#   ################################################################################

#   Specify transition environments that are used to save changes to each components State
#   until the end of the period when the State of each component is updated

    C.SE.Transition.01(Universe, Calendar)

#   ################################################################################
#   output diagnostic files from setup

    C.Cal.01.output.01(Universe,Calendar)

#   ################################################################################
#   Go
#   ################################################################################

KrillAb       <-c(1,0,sum(Universe$Biota[[1]]$State$Abundance[[MonUnits]]))
 AFSpupab     <-c(1,0,sum(Universe$Biota[[3]]$State$Abundance[[MonUnits]]))
 AFSjuveab    <-c(1,0,sum(Universe$Biota[[4]]$State$Abundance[[MonUnits]]))
 AFSnonrepab  <-c(1,0,sum(Universe$Biota[[5]]$State$Abundance[[MonUnits]]))
 AFSrepab     <-c(1,0,sum(Universe$Biota[[6]]$State$Abundance[[MonUnits]]))
 KrillArea<-c()

Kmax<-KrillAb[3]*3
Apmax<-AFSpupab[3]*5
Ajmax<-AFSjuveab[3]*5
Anmax<-AFSnonrepab[3]*5
Armax<-AFSrepab[3]*5
KrAreaMax<-Kmax/8

    for (yr in 1:(Nyrs+1)) {
      for (pe in 1:Calendar$Period.N) {

print(paste("Year: ",as.character(yr),",  Period: ",as.character(pe)),sep="")
        Trial.State$Period<-pe

        C.PJ.Period.01(Universe,yr,pe,Calendar[[pe]],Trial.State)
if(pe==1) {
 KrillAb    <-rbind(KrillAb,    c(yr,((yr+Calendar[[pe]]$Day/365)-1),sum(Universe$Biota[[1]]$State$Abundance[[MonUnits]])))
 AFSpupab   <-rbind(AFSpupab  , c(yr,((yr+Calendar[[pe]]$Day/365)-1),sum(Universe$Biota[[3]]$State$Abundance[[MonUnits]])))
 AFSjuveab  <-rbind(AFSjuveab  ,c(yr,((yr+Calendar[[pe]]$Day/365)-1),sum(Universe$Biota[[4]]$State$Abundance[[MonUnits]])))
 AFSnonrepab<-rbind(AFSnonrepab,c(yr,((yr+Calendar[[pe]]$Day/365)-1),sum(Universe$Biota[[5]]$State$Abundance[[MonUnits]])))
 AFSrepab   <-rbind(AFSrepab  , c(yr,((yr+Calendar[[pe]]$Day/365)-1),sum(Universe$Biota[[6]]$State$Abundance[[MonUnits]])))
 KrillArea<-rbind(KrillArea,c(((yr+Calendar[[pe]]$Day/365)-1),Universe$Biota[[1]]$State$Abundance[[MonUnits]]))

if(!Plot.by.area){
frame()
par(mfcol=c(2,4)) # plot by column - rows by cols
par(mfg=c(1,1))
plot(KrillAb[,2],KrillAb[,3],xlab="Years",ylab="Krill Abundance",lab=c(20,20,1),xlim=c(0,Nyrs+1),ylim=c(0,Kmax))
par(mfg=c(2,1))
plot(AFSpupab[,2],AFSpupab[,3],xlab="Years",ylab="AFS pup Abundance",lab=c(20,20,1),xlim=c(0,Nyrs+1),ylim=c(0,Apmax))
par(mfg=c(2,2))
plot(AFSjuveab[,2],AFSjuveab[,3],xlab="Years",ylab="AFS juv Abundance",lab=c(20,20,1),xlim=c(0,Nyrs+1),ylim=c(0,Ajmax))
par(mfg=c(2,3))
plot(AFSnonrepab[,2],AFSnonrepab[,3],xlab="Years",ylab="AFS nonrep Abundance",lab=c(20,20,1),xlim=c(0,Nyrs+1),ylim=c(0,Anmax))
par(mfg=c(2,4))
plot(AFSrepab[,2],AFSrepab[,3],xlab="Years",ylab="AFS rep Abundance",lab=c(20,20,1),xlim=c(0,Nyrs+1),ylim=c(0,Armax))
}

if(Plot.by.area) {
frame()
par(mfcol=c(2,4)) # plot by column - rows by cols
par(mfg=c(1,1))
plot(KrillArea[,1],KrillArea[,2],xlab="Years",ylab="Krill Abundance",lab=c(20,20,1),xlim=c(0,Nyrs+1),ylim=c(0,KrAreaMax))
par(mfg=c(1,2))
plot(KrillArea[,1],KrillArea[,3],xlab="Years",ylab="Krill Abundance",lab=c(20,20,1),xlim=c(0,Nyrs+1),ylim=c(0,KrAreaMax))
par(mfg=c(1,3))
plot(KrillArea[,1],KrillArea[,4],xlab="Years",ylab="Krill Abundance",lab=c(20,20,1),xlim=c(0,Nyrs+1),ylim=c(0,KrAreaMax))
par(mfg=c(1,4))
plot(KrillArea[,1],KrillArea[,5],xlab="Years",ylab="Krill Abundance",lab=c(20,20,1),xlim=c(0,Nyrs+1),ylim=c(0,KrAreaMax))
par(mfg=c(2,1))
plot(KrillArea[,1],KrillArea[,6],xlab="Years",ylab="Krill Abundance",lab=c(20,20,1),xlim=c(0,Nyrs+1),ylim=c(0,KrAreaMax))
par(mfg=c(2,2))
plot(KrillArea[,1],KrillArea[,7],xlab="Years",ylab="Krill Abundance",lab=c(20,20,1),xlim=c(0,Nyrs+1),ylim=c(0,KrAreaMax))
par(mfg=c(2,3))
plot(KrillArea[,1],KrillArea[,8],xlab="Years",ylab="Krill Abundance",lab=c(20,20,1),xlim=c(0,Nyrs+1),ylim=c(0,KrAreaMax))
par(mfg=c(2,4))
plot(KrillArea[,1],KrillArea[,9],xlab="Years",ylab="Krill Abundance",lab=c(20,20,1),xlim=c(0,Nyrs+1),ylim=c(0,KrAreaMax))
}
}
     } # end period


    } # end yr

#    epoc$reproduction<-Biota[[1]]$TimeSteps[[2]]$actions[[1]]$Update.fn(Biota[[1]],Biota)
#    epoc$migration<-Biota[[1]]$TimeSteps[[2]]$actions[[2]]$Update.fn()
#    epoc
# c(Universe,Transition)

# KrillAb
}

