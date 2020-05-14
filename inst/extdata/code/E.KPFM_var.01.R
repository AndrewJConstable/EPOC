function (Element,              # component of Universe$Environment
          Year,                 # year in the trial
          PeriodLastDay,        # the last day of the period
          PeriodYearPropn,      # the fraction of the year encompassed by the period
          dSet,                 # dataset to be used with function
          Universe              # access to universe if needed
          )                     # end input parameters

# Function:           E.KPFM_var.01
# Version             0.01

# Description:        Environment function - to implement variation in KPFM in Equation 3

# Input data:         as above
#                   Env.var.data =
#                        dSet$Area_env  = vector of indexes giving variation between area
#                        dSet$Temporal  = vector giving mean condition for a year in each area
#                        dSet$Rphi      = scaling parameter for each area
#                        dSet$EnvLnSD     = SD in log domain for environmental variation across arena

# Return data:        none at present

########################################################
#      Signature <- list(
#        ID           =  28003,
#        Name.full    = "Environmental variability",
#        Name.short   = "EnvVar",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "6 July 2005"
#        ) # end Signature


########################################################
{
TrendX<-1 # change when year is implemented
dev<-log(rlnorm(1, meanlog = 0, sdlog = Env.var.data.01$EnvLnSD)[1])
Universe$Environment[[Element]]$State$Condition<-exp(Env.var.data.01$Temporal[TrendX]*Env.var.data.01$Rphi+dev)
}

