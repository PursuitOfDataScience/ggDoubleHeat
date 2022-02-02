#' Pittsburgh COVID related Google & Twitter incidence rates
#'
#' A data set containing the 30-week incidence rates of COVID related categories
#' from week 1 starting from June 1, 2020 to week 30
#' that ended in the last Sunday of the year in Pittsburgh Metropolitan
#' Statistical Area (MSA). The data columns are introduced below. One quick note
#' about the columns of the data set: \code{week_start} as a column is present
#' in the data set for illustration purposes, reminding users what \code{week}
#' column is. In other words, it does not participate any visualization.
#' @format A data frame with 270 rows and 6 columns:
#' \describe{
#'   \item{msa}{Metropolitan statistical area (Pittsburgh only).}
#'   \item{week}{week 1 to week 30.}
#'   \item{week_start}{The Monday date of the week started.}
#'   \item{category}{9 Covid-related categories in total.}
#'   \item{Twitter}{weekly tweets percentage (\%) in the MSA falling into each
#'   category.}
#'   \item{Google}{weekly Google search percentage (\%) in the MSA falling into
#'   each category.}
#' }
#' @source Google is processed from Google Health API, and Twitter
#' from Meltwater, a Twitter vendor. Both data sources are processed by
#' the authors of the package.
"pitts_tg"


#' Popular Emojis
#'
#' The most popular emoji of a given week in a given category from the Meltwater
#' tweet sample. They can be rendered by using \code{"richtext"} with
#' \code{annotate()}.
#'
#'
"pitts_emojis"

