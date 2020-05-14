function (Universe, Calendar)
# Function:           C.Cal.01.output.01
# Description:        General function for outputting calendar of events for a year to file

# Input parameters:   Universe - list including one or more of
#                               (Biota, Environment, Activities, Management, Output, Presentation)

# Returned

########################################################
#      Signature <- list(
#        ID           =  11012,
#        Name.full    = "Ecosystem Calendar ouptut 01",
#        Name.short   = "CalOut01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "5 July 2005"
#        ) # end Signature


########################################################

{

# output Calendar to file

Fsim <- file("E_cal.epc","w")

cat(c("Period,Day,YearPropn,Module,Element,Actions",
                  '\n'), file = Fsim, sep = "")

for (pe in 1:Calendar$Period.N) {
  if(!is.null(Universe$Biota)) {
      for (bn in 1:Universe$Biota$Biota.N){
         if(Universe$Biota[[bn]]$TimeSteps[[pe]]$actions.N>0) {
            action.names<-attributes(Universe$Biota[[bn]]$TimeSteps[[pe]]$actions)$names
            cat(c(pe,Universe$Biota[[bn]]$TimeSteps[[pe]]$calday,
                  Calendar[[pe]]$YearPropn,
                  1,
                  bn,
                  action.names,
                  '\n'), file = Fsim, sep = ",")
        } # end if actions.N >0
      } # end biota

  } # end if biota
  if(!is.null(Universe$Environment)) Period<-c(Period,list(Environment = matrix(NA,ncol=3,nrow=Universe$Environment$Environment.N)))
  if(!is.null(Universe$Activities))  Period<-c(Period,list(Activities  = matrix(NA,ncol=3,nrow=Universe$Activities$Activities.N)))
  if(!is.null(Universe$Management))  Period<-c(Period,list(Management  = matrix(NA,ncol=3,nrow=Universe$Management$Management.N)))
  if(!is.null(Universe$Output))      Period<-c(Period,list(Output      = matrix(NA,ncol=3,nrow=Universe$Output$Output.N)))


} # end pe loop


close(Fsim)

} # end function

