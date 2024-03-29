% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/remove-padding.R
\name{remove_padding}
\alias{remove_padding}
\title{Remove ggplot2 default padding}
\usage{
remove_padding(x = "c", y = "d", ...)
}
\arguments{
\item{x}{x-axis scale, if it is continuous scale, input "c"; discrete, "d".}

\item{y}{y-axis scale, if it is continuous scale, input "c"; discrete, "d".}

\item{...}{...}
}
\value{
remove_padding
}
\description{
The default ggplot2 plots give certain amount of padding for both continuous
and discrete variables. Due to this padding, it makes the plots generated
from `geom_heat_*()` look like there is something missing. Depends on users'
preference, they can remove the "empty space" by using this function. The
only thing users need to figure out is whether the `x` and `y` scales are
continuous or discrete.
}
