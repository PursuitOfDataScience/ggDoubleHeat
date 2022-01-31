#' Pittsburgh Covid related Google & Twitter incidence rates
#'
#' A dataset containing the 30-week incidence rates of Covid related categories
#' from week 1 starting from June 1, 2020 to week 30
#' that ended in the last Sunday of the year in Pittsburgh Metropolitan
#' Statistical Area (MSA). The data columns are introduced below.
#' @format A data frame with 270 rows and 6 columns:
#' \describe{
#'   \item{msa}{Metropolitan statistical area (Pittsburgh only).}
#'   \item{week}{week 1 to week 30.}
#'   \item{week_start}{The Monday date of the week started.}
#'   \item{category}{9 Covid-related categories in total.}
#'   \item{Twitter}{weekly tweets percentage in the MSA falling into each category.}
#'   \item{Google}{weekly Google search percentage in the MSA falling into each category.}
#' }
#' @source Google is processed from Google Health API, and Twitter
#' from Meltwater, a Twitter vendor.
"pitts_tg"


#' Popular Emojis
#'
#' The most popular emoji of a given week in a given category from the Meltwater tweet sample
#' They can be rendered by using \code{"richtext"} with \code{annotate()}.
#'
#'
"pitts_emojis"
