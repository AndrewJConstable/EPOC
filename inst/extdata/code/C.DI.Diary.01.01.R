function (Universe)
# Function:           C.DI.Diary.01.01
# Description:        General controller for determining the diary of events for a year
# Primary attributes: Determine diary of events by comparing across all parts of the ecosystem
#                     Error check to ensure all actions can be accommodated

# Input parameters:   Universe - list including one or more of
#                               (Biota, Environment, Activities, Management, Output, Presentation)

# Returned            Diary of events

########################################################
#      Signature <- list(
#        ID           =  11004,
#        Name.full    = "Ecosystem Diary 01",
#        Name.short   = "Diary01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "29 May 2005"
#        ) # end Signature


########################################################

# Rules for each ecosystem component:
#   i)   The last time step must be 365 days - if not the first time step will use the remainder from the last timestep to 365
#   ii)  The actions nominated at a time step occur over the period from the previous time step to the current
#   iii) The actions are currently modelled as occurring at a constant rate over the time step
#   iv)  The actions are considered to appropriately act according to the state of the ecosystem at the beginning of the time step
#           unless changes to other components of the ecosystem have occurred that impact on the element,
#           such as the starting or stopping of predation by a competitor during a foraging timestep, or a predator during reproduction.

{


# ********************************************************************************************
# NOT PURSUED AT THIS TIME
# In order not to update every component at every event in the diary,

# For each component, create a modified set of timesteps of when other components begin and end affecting it
# then determine in which actual time step these fall and how much of the actual time steps have occurred within
# the smaller time steps.  Importantly the process will be to determine when the start of a time step for a compoment
# requires an update of the status of other components and when the end of a time step for a component requires other
# components to have an update
# *********************************************************************************************



# Create a vector of all the unique timesteps in calendar days - Day 1 is 1 January, Day 365 is 31 December

# establish null vector for accumulating prey ID from a predator

  TimeStepsDays<-c()


# Biota - loop through for time steps

if(!is.null(Universe$Biota)) {
  for (bn in 1:Universe$Biota$Biota.N){

      for (tn in 1:Universe$Biota[[bn]]$TimeSteps.N){
            TimeStepsDays<-c(TimeStepsDays,Universe$Biota[[bn]]$TimeSteps[[tn]]$calday)
      } # end j
   } # end bn
} # end if biota

# Environment - loop through for time steps

# Activities - loop through for time steps

#  Establish time series of periods

   TimeStepsDays<-sort(unique(TimeStepsDays))

   PeriodN<-length(TimeStepsDays) # number of periods in the year starting at 1 Jan and ending on 31 Dec

#  Calculate the proportion of the year taken up by each timestep, noting that the records in TimeStepsDays reflect
#   the end of the period at midnight of the nominated day prior to entering the next day.

    PropYear<-cbind(TimeStepsDays,rep(NA,PeriodN))
    pe<-c(2:PeriodN)
    PropYear[1,2]<-PropYear[1,1]/365
    PropYear[pe,2]<-(PropYear[pe,1]-TimeStepsDays[pe-1])/365

# the first time step in each element may overlap the 1 January, requiring another period to finish off the year
    if(TimeStepsDays[PeriodN]!=365) {
      PropYear<-rbind(PropYear,c(365,((365-TimeStepsDays[PeriodN])/365)))
      PeriodN<-PeriodN+1
    } # end if

# Loop through each ecosystem component to
# create a list of each period in the diary (between unique timesteps) that indicates the ecosystem components and
# the timestep for that component that is occurring in the diary period and the proportion of the timestep that will
# be accounted for by the period.  Also include a column of the number (in sequence) of the periods in the timestep

# NB at present all components will be updated at each time step

# initialise diary

      Diary<-list()

      for (eTSD in 1:PeriodN) {
        Period<-list( Day = PropYear[eTSD,1], YearPropn = PropYear[eTSD,2])
        if(!is.null(Universe$Biota))       Period<-c(Period,list(Biota       = matrix(NA,ncol=3,nrow=Universe$Biota$Biota.N)))
        if(!is.null(Universe$Environment)) Period<-c(Period,list(Environment = matrix(NA,ncol=3,nrow=Universe$Environment$Environment.N)))
        if(!is.null(Universe$Activities))  Period<-c(Period,list(Activities  = matrix(NA,ncol=3,nrow=Universe$Activities$Activities.N)))
        if(!is.null(Universe$Management))  Period<-c(Period,list(Management  = matrix(NA,ncol=3,nrow=Universe$Management$Management.N)))
        if(!is.null(Universe$Output))      Period<-c(Period,list(Output      = matrix(NA,ncol=3,nrow=Universe$Output$Output.N)))
        Diary<-c(Diary,list(Period))
      } # end etSD

# fill Diary with relevant data

      Diary<-c(Diary,list(Period.N = PeriodN))

# Step Bioata

if(!is.null(Universe$Biota)) {

        for (bn in 1:Universe$Biota$Biota.N){

#         number of taxon time steps
          TS.taxon.N<-Universe$Biota[[bn]]$TimeSteps.N

          eTSDlast<-0   # the calendar day at the end of the last timestep
          TS.current<-1 # the current time step for the element
          TS.current.days<-Universe$Biota[[bn]]$TimeSteps[[TS.current]]$calday # the last day in the current time step
          Period.step<-0 # the number (in sequence) of the period within the timestep

#         estimate proportion of year carrying out functions of time step.  If the last time step is not on
#         the last day of the year (365) then time step corresponds to period to end the year plus the period
#         at the beginning

          TS.current.prop.year<-(TS.current.days+365-Universe$Biota[[bn]]$TimeSteps[[TS.taxon.N]]$calday)/365.0
          TS.period1.prop.year<-TS.current.prop.year

          for (eTSD in 1:PeriodN) {
            Days<-PropYear[eTSD,1]
            Prop.year<-(Days-eTSDlast)/365
            Period.step<-Period.step+1

#           if Days is greater than the current time step and there are more time steps
            if ((Days > TS.current.days)&(TS.current<TS.taxon.N)) {
                  TS.current<-TS.current+1
                  Period.step<-1
                  TS.old.days<-TS.current.days
                  TS.current.days<-Universe$Biota[[bn]]$TimeSteps[[TS.current]]$calday
                  TS.current.prop.year<-(Universe$Biota[[bn]]$TimeSteps[[TS.current]]$calday-TS.old.days)/365
            } # end if use next time period if one exists

#           if Days is greater than the current time step but there are no more time steps
#           the special case where the end of the year applies to the first time step
            if ((Days > TS.current.days)&(TS.current==TS.taxon.N)) {
              TS.current<-1
              TS.current.days<-365.0
              TS.current.prop.year<-TS.period1.prop.year
              eTSD.start.first.timestep<-eTSD
              Period.step<-1
            } # end if use next time period but one does not exist

#           save the characteristics of the time step for that taxon
            Diary[[eTSD]]$Biota[bn,1]<-TS.current                      # the number of the timestep for that element in the period
            Diary[[eTSD]]$Biota[bn,2]<-Prop.year/TS.current.prop.year  # the proportion of the time step within the period
            Diary[[eTSD]]$Biota[bn,3]<-Period.step                     # the number ofthe period in sequence within the timestep of that element

            eTSDlast<-Days
          } # end eTSD

#           in the case where the first timestep starts at the end of the year and is the first timestep to end in the new year
#           need to advance the Period.steps in the early part of the year to form a sequence from the latter part
#           - add the last value used in "Period.step" to the values in the rest of the timestep in the early part of the year

            for (eTSD in 1:(eTSD.start.first.timestep-1)) {
              if (Diary[[eTSD]]$Biota[bn,1]==1) Diary[[eTSD]]$Biota[bn,3]<-Diary[[eTSD]]$Biota[bn,3]+Period.step
            }
        } # end bn
} # end  StepBioata

# Step environment
if(!is.null(Universe$Environment)) {
} # end  Step environment

# Step Activities
if(!is.null(Universe$Activities)) {
} # end  Step Activities

# Step Management
if(!is.null(Universe$Management)) {
} # end  Step Management

# Step Output
if(!is.null(Universe$Output)) {
} # end  Step Output



# return the diary

  Diary
}

