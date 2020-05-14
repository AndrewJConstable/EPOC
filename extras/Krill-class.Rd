\name{Krill-class}
\Rdversion{1.1}
\docType{class}
\alias{Krill-class}
\alias{initialiseTransition,Krill-method}
\alias{initialiseReplicate,Krill-method}
\alias{initialize,Krill-method}

\title{Class "Krill" - Included EPOC Element class in Biota module. }
\description{This included class is instantiated as an object in the demo model.}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("Krill", universe, dataPath)}.
}
\section{Slots}{
	 \describe{
    \item{\code{nYrs}:}{Object of class \code{"numeric"} ~~ }
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
Class \code{"\linkS4class{Biota}"}, directly.
Class \code{"\linkS4class{Element}"}, by class "Biota", distance 2.
Class \code{"\linkS4class{EPOCObject}"}, by class "Biota", distance 3.
Class \code{"\linkS4class{.environment}"}, by class "Biota", distance 4.
Class \code{"\linkS4class{environment}"}, by class "Biota", distance 5, with explicit coerce.
Class \code{"\linkS4class{refObject}"}, by class "Biota", distance 6, with explicit coerce.
}
\section{Methods}{
  \describe{
    \item{initialiseTransition}{\code{signature(.Object = "Krill", universe = "Universe")}: ... }
    \item{initialiseReplicate}{\code{signature(.Object = "Krill", universe = "Universe")}: ... }
    \item{initialize}{\code{signature(.Object = "Krill")}: ... }
	 }
}
\references{ ~put references to the literature/web site here ~ }
\author{ Troy Robertson, Andrew Constable }
\note{}
\seealso{
	\code{\link{EPOC}, \linkS4class{Element}, \linkS4class{KrillEnvironment}, \linkS4class{Predator}, \linkS4class{Manager}, \linkS4class{Fishery}}
}
\examples{
showClass("Krill")
}
\keyword{classes}
