################################################################################
# epoc() function
#
# Convenience function allowing a first time user to run the default 
# EPOC universe that comes with the package.
#
# Authors: Troy Robertson (TR), Andrew Constable (AC)

# History
# 20090927 : created (TR)
# 20200519 : corrected output of runtime path to be from the scenario directory (AC)


################################################################################

# This will automatically create a calendar from the universe data and then setup
# the universe and then run simulation.
# Universe data will be sourced from dataPath param or default to ./data/Universe.data.R
epoc <- function(dataPath=NULL, outputcalendar=TRUE, tofile=TRUE, msglevel="normal", loglevel="verbose", 
						logfile="EPOCDemo.log", logtrunc=TRUE, epocdebug=NULL, forceGC=FALSE, timer=TRUE) {
	# Determine which of current dir, package dir or param dir should be used
	msg <- "EPOC package demo data input files."
	packDataPath <- system.file("extdata","data", "Universe.data.R", package="EPOC")
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
	
	BaseScenarioPath<-dirname(dirname(uniDataPath))
	setwd(BaseScenarioPath)

	message("Instantiating model universe using ", msg)
	message("Output data files written to: ", file.path(BaseScenarioPath, "runtime"))
	
	# Load input data
	# Specify the universe for the epoc scenario

	universe <- new("Universe", dataPath=uniDataPath, msglevel, loglevel, logfile, logtrunc)

	message("set new universe")
	
	# Start controller
	# this creates/sets up both the universe and calendar
	controller <- new("Controller", universe=universe, outputcalendar=outputcalendar, tofile=tofile)

	message("set new controller")
	
	# Start simulation
	runSimulation(controller, epocdebug=epocdebug, forceGC=forceGC, timer=timer)
	
	return(invisible(controller))
}