################################################################################
# EPOC class
#
# Convenience class allowing a first time user to create and run the default 
# EPOC universe that comes with the package.
#
# S4
# Created 27/9/2009 Troy Robertson
################################################################################
setClass("EPOC",
    representation(
		universe 	= "Universe",
        controller  = "Controller"			# Current controller object
    )
)

# Constructor for an EPOC object. 
# This will automatically create a calendar from the universe data and then setup
# the universe and then run simulation.
# Universe data will be sourced from dataPath param or default to ./data/Universe.data.R
setMethod("initialize", "EPOC",
    function(.Object, dataPath=NULL, printCalendar=FALSE, showElapsed=TRUE) {
		# Determine which of current dir, package dir or param dir should be used
		msg <- "EPOC package demo data input file."
		packDataPath <- system.file("extdata", "data", "Universe.data.R", package="EPOC")
		currDataPath <- file.path(getwd(), "data", "Universe.data.R")
		if (file.exists(packDataPath)) uniDataPath <- packDataPath
		if (file.exists(currDataPath)) {
			uniDataPath <- currDataPath
			msg <- paste("data input file found below cwd at: ", currDataPath, ".", sep="")
		}
		if (!is.null(dataPath) && file.exists(dataPath)) {
			uniDataPath <- dataPath
			msg <- paste("data input file at specified path: ", dataPath, ".", sep="")
		} 
		message("Instantiating model universe using ", msg)
		message("Output data files written to: ", file.path(getwd(), "runtime"))
		
		# Load input data
		# Specify the universe for the epoc scenario
		.Object@universe <- new("Universe", dataPath=uniDataPath)
			
		#Start controller
		# this creates/sets up both the universe and calendar
		.Object@controller <- new("Controller", universe=.Object@universe)

		# Display calendar 
		displayCalendar(.Object@controller, toScreen=printCalendar)

		# Start simulation
		if (showElapsed) {
			system.time(runSimulation(.Object@controller), gcFirst = T)
		} else {
			runSimulation(.Object@controller)
		}
		
		return(.Object)
	}
)