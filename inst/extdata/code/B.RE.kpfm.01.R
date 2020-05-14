function (De,Alpha,Beta,EnvFn)
# Function:           B.RE.kpfm.01
# Description:        KPFM recruitment function with spatial and temporal variability
#                     determined by environment

# Input parameters:   De          = density of adults
#                     Alpha       = max density of recruits
#                     Beta        = density of adults which gives 0.5 max recruit density
#                     EnvFn       = name of environment function to give variability

########################################################
#      Signature <- list(
#        ID           =  22003,
#        Name.full    = "KPFM recruitment",
#        Name.short   = "KPFM_recruits",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "6 July 2005"
#        ) # end Signature


########################################################
{
EnvVar<-1
if(!is.null(EnvFn)) EnvVar<-EnvFn
Alpha*EnvVar*De/(Beta+De)
}

