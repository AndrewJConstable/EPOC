function ()

# Function:           C.kpfm.trial.01
# Description:        Environment of parameters for a trial - simulation of KPFM
# Primary attributes:
#

# Input parameters:

# Returned            list of universe

########################################################
#      Signature <- list(
#        ID           =  11002,
#        Name.full    = "KPFM Trial.parameters 01",
#        Name.short   = "KPFM Trial.par01",
#        Version      = "01",
#        Authors      = "A.Constable",
#        last.edit    = "6 July 2005"
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

Trial.par$TrialsN<-1

Trial.par$YearStart<-1995
Trial.par$YearEnd<-2020
Trial.par$YearsN<-Trial.par$YearEnd-Trial.par$YearStart+1


Trial.par
}

