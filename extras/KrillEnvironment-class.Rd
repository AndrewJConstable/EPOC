\name{KrillEnvironment-class}
\Rdversion{1.1}
\docType{class}
\alias{KrillEnvironment-class}
\alias{initialiseReplicate,KrillEnvironment,Universe-method}
\alias{initialize,KrillEnvironment}
\alias{regionalSeries,KrillEnvironment,Universe-method}

\title{Class "KrillEnvironment" - Included EPOC Element class in Environment module. }
\description{This included class is instantiated as an object in the demo model.}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("KrillEnvironment", universe, dataPath)}.
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
Class \code{"\linkS4class{Environment}"}, directly.
Class \code{"\linkS4class{Element}"}, by class "Environment", distance 2.
Class \code{"\linkS4class{EPOCObject}"}, by class "Environment", distance 3.
Class \code{"\linkS4class{.environment}"}, by class "Environment", distance 4.
Class \code{"\linkS4class{environment}"}, by class "Environment", distance 5, with explicit coerce.
Class \code{"\linkS4class{refObject}"}, by class "Environment", distance 6, with explicit coerce.
}
\section{Methods}{
  \describe{
    \item{initialiseScenario}{\code{signature(.Object = "KrillEnvironment")}: ... }
    \item{initialiseReplicate}{\code{signature(.Object = "KrillEnvironment")}: ... }
    \item{initialize}{\code{signature(.Object = "KrillEnvironment")}: ... }
    \item{regionalSeries}{\code{signature(.Object = "KrillEnvironment")}: ... }
	 }
}
\references{}
\author{ Andrew Constable, Troy Robertson }
\note{}
\seealso{
	\code{\link{EPOC}, \linkS4class{Element}, \linkS4class{Krill}, \linkS4class{Predator}, \linkS4class{Manager}, \linkS4class{Fishery}}
}
\examples{
showClass("KrillEnvironment")
}
\keyword{classes}
