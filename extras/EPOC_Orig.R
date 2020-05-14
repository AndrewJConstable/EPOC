# FOOSA Startup Routine

# debugging
options(error=recover)

# Clear workspace
rm(list=ls(all=TRUE))

#Define top-level EPOC directory
# Set the working directory to the working directory which should be where this file is located
setwd(file.path("Z:/1 Projects/4 Software development/R/EPOC V0.3.0"))

# Perform EPOC setup
source(file=file.path(getwd(), "base", "EPOC.Setup.R"))

# Load input data
# Specify the universe for the epoc scenario
universe <- new("Universe", dataPath=file.path(getwd(), "data", "Universe.data.R"))
    
#Start controller
# this creates/sets up both the universe and calendar
controller <- new("Controller", universe=universe)
 
###########
# Serialise to file, and then unserialise from file
#serialiseSimulation(controller, "Test")
#controller <- unserialiseSimulation(new("Controller"), "Test")
###########

# Display calendar
displayCalendar(controller, toScreen=FALSE)

# Profiling
#Rprof(filename=paste(getwd(), "prof.out"), memory.profiling=TRUE)

# Start simulation
#runSimulation(controller)
system.time(runSimulation(controller), gcFirst = T)

#Rprof(NULL)