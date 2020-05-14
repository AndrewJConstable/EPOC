\name{Fishery-class}
\Rdversion{1.1}
\docType{class}
\alias{Fishery-class}
\alias{initialiseTransition,Fishery-method}
\alias{initialiseReplicate,Fishery-method}
\alias{initialize,Fishery-method}

\title{Class "Fishery" - Included EPOC Element class in Activity module. }
\description{This included class is instantiated as an object in the demo model.}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("Fishery", universe, dataPath)}.
}
\section{Slots}{
	 \describe{
    \item{\code{polygons}:}{Object of class \code{"vector"} ~~ }
    \item{\code{polygonsN}:}{Object of class \code{"numeric"} ~~ }
    \item{\code{birthday}:}{Object of class \code{"numeric"} ~~ }
    \item{\code{timesteps}:}{Object of class \code{"list"} ~~ }
    \item{\code{timestepsN}:}{Object of class \code{"numeric"} ~~ }
    \item{\code{recordElements}:}{Object of class \code{"numeric"} ~~ }
    \item{\code{currentScenarioDir}:}{Object of class \code{"character"} ~~ }
    \item{\code{inputData}:}{Object of class \code{"list"} ~~ }
    \item{\code{dataPath}:}{Object of class \code{"character"} ~~ }
    \item{\code{signature}:}{Object of class \code{"Signature"} ~~ }
    \item{\code{epocAttributes}:}{Object of class \code{"list"} ~~ }
    \item{\code{.xData}:}{Object of class \code{"environment"} ~~ }
  }
}
\section{Extends}{
Class \code{"\linkS4class{Activity}"}, directly.
Class \code{"\linkS4class{Element}"}, by class "Activity", distance 2.
Class \code{"\linkS4class{EPOCObject}"}, by class "Activity", distance 3.
Class \code{"\linkS4class{.environment}"}, by class "Activity", distance 4.
Class \code{"\linkS4class{environment}"}, by class "Activity", distance 5, with explicit coerce.
}
\section{Methods}{
  \describe{
    \item{initialiseTransition}{\code{signature(.Object = "Fishery", universe = "Universe")}: ... }
    \item{initialiseReplicate}{\code{signature(.Object = "Fishery", universe = "Universe")}: ... }
    \item{initialize}{\code{signature(.Object = "Fishery")}: ... }
	 }
}
\references{}
\author{ Andrew Constable, Troy Robertson }
\note{}
\seealso{
	\code{\link{EPOC}, \linkS4class{Element}, \linkS4class{KrillEnvironment}, \linkS4class{Krill}, \linkS4class{Predator}, \linkS4class{Manager}}
}
\examples{
showClass("Fishery")
}
\keyword{classes}
