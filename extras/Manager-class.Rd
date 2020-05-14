\name{Manager-class}
\Rdversion{1.1}
\docType{class}
\alias{Manager-class}
\alias{initialiseReplicate,Manager-method}
\alias{initialize,Manager-method}

\title{Class "Manager" - Included EPOC Element class in Management module. }
\description{This included class is instantiated as an object in the demo model.}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("Manager", universe, dataPath)}.
}
\section{Slots}{
	 \describe{
    \item{\code{polygons}:}{Object of class \code{"list"} - List of polygon indexes in which this element is found. }
    \item{\code{polygonsN}:}{Object of class \code{"numeric"} - Polygon count. }
    \item{\code{birthday}:}{Object of class \code{"numeric"} - List of timesteps defined by actions. }
    \item{\code{timesteps}:}{Object of class \code{"list"} - List of timesteps with its detail. }
    \item{\code{timestepsN}:}{Object of class \code{"numeric"} - Timestep count. }
    \item{\code{recordElements}:}{Object of class \code{"numeric"} - }
    \item{\code{currentScenarioDir}:}{Object of class \code{"character"} - Output directory for active scenario. }
    \item{\code{inputData}:}{Object of class \code{"list"} - Raw input data as sourced from input data file. }
    \item{\code{dataPath}:}{Object of class \code{"character"} - Path to input data file.}
    \item{\code{signature}:}{Object of class \code{"Signature"} - Signature definition for element. }
    \item{\code{epocAttributes}:}{Object of class \code{"list"} - Element attributes pulled from input data. }
    \item{\code{.xData}:}{Object of class \code{"environment"}}
  }
}
\section{Extends}{
Class \code{"\linkS4class{Management}"}, directly.
Class \code{"\linkS4class{Element}"}, by class "Management", distance 2.
Class \code{"\linkS4class{EPOCObject}"}, by class "Management", distance 3.
Class \code{"\linkS4class{.environment}"}, by class "Management", distance 4.
Class \code{"\linkS4class{environment}"}, by class "Management", distance 5, with explicit coerce.
}
\section{Methods}{
  \describe{
    \item{initialiseReplicate}{\code{signature(.Object = "Manager")}: ... }
    \item{initialize}{\code{signature(.Object = "Manager")}: ... }
	 }
}
\references{}
\author{ Andrew Constable, Troy Robertson }
\note{}
\seealso{}
\examples{
showClass("Manager")
}
\keyword{classes}
