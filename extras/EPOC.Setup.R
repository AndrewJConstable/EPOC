###########################################################
#
#   Setup essential libraries for EPOC-KPFM in R directory
#
###########################################################
#  Authors      A. Constable
#  last edit    25 Feb 2008
###########################################################

############################
# load libraries
# library(libname,lib.loc="lib_location")
if (is.null(getOption("epocmsglevel")) || getOption("epocmsglevel") == "quiet") {
	suppressMessages(require(Rcpp, quietly=TRUE))
	suppressMessages(require(inline, quietly=TRUE))
	suppressMessages(dyn.load("src/EPOC.dll"))
} else {
	library(Rcpp)
	library(inline)
	dyn.load("src/EPOC.dll")
}

################################################################################
# S4 Objects
# 4/2/2009 TR
################################################################################
   
source(file=file.path(getwd(), "base", "Support.R"))
source(file=file.path(getwd(), "base", "Signature.R"))
source(file=file.path(getwd(), "base", "EPOCObject.R"))
#    source(file=file.path(getwd(), "base", "State.R"))
source(file=file.path(getwd(), "base", "Element.R"))
source(file=file.path(getwd(), "base", "Biota.R"))
source(file=file.path(getwd(), "base", "Environment.R"))
source(file=file.path(getwd(), "base", "Activity.R"))
source(file=file.path(getwd(), "base", "Management.R"))
source(file=file.path(getwd(), "base", "Output.R"))
source(file=file.path(getwd(), "base", "Presentation.R"))
source(file=file.path(getwd(), "base", "Spatial.R"))
source(file=file.path(getwd(), "base", "Period.R"))
source(file=file.path(getwd(), "base", "Universe.R"))
source(file=file.path(getwd(), "base", "Calendar.R"))
source(file=file.path(getwd(), "base", "Scenario.R"))

################################################################################
# Controller - C.
################################################################################

source(file=file.path(getwd(), "base", "Controller.R"))
source(file=file.path(getwd(), "base", "EPOC.R"))

################################################################################
# General Utilities
################################################################################

  # Utilities - print fixed field lengths

#    source(file=file.path(getwd(), "code", "U.PR.print_fixed_field_length.01.R"))
#     source(file=file.path(getwd(),"U.ST.Check_Default_Lists.R",sep="Code\\"))
#    source(file=file.path(getwd(), "code", "U.ST.DayFromDate.01.R"))
     
################################################################################




