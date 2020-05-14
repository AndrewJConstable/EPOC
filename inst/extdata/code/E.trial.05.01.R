function ()

# Function:           E.trial.05.01
# Description:        Environment of parameters for a trial
# Primary attributes:
#

# Input parameters:

# Returned            list of universe

########################################################
#      Signature <- list(
#        ID           =  12002,
#        Name.full    = "Trial.parameters 01",
#        Name.short   = "Trial.par01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "31 May 2005"
#        ) # end Signature


########################################################

{
    Trial.par<-new.env()

#   Signature is a unique identifier for this element
#         number applicable to Euphausia superba where 2000 series
#         is approximately second trophic level and numbers within are
#         identification numbers of the elements - all elements within a single
#         model should be unique (although the same number may be used in different versions
#         of this element

Trial.par$Signature <- list(
      ID           = 12002,
      Name.full    = "Trial - test 01",
      Name.short   = "Trial01",
      Version      = "01",
      Authors      = "A.Constable",
      last.edit    = "31 May 2005"
      ) # end Signature

Trial.par$TrialsN<-1

Trial.par$YearStart<-1995
Trial.par$YearEnd<-2020
Trial.par$YearsN<-Trial.par$YearEnd-Trial.par$YearStart+1


Trial.par
}

