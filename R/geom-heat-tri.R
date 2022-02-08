#' Heattriangle
#'
#' The heattriangle geom is used to create the two triangles split by a diagonal
#' line of a rectangle that use luminance to show the values from two sources on
#' the same plot.
#'
#' @param lower The column name for the lower portion of heattriangle.
#' @param lower_name The label name (in quotes) for the legend of the lower
#' rendering. Default is \code{NULL}.
#' @param lower_colors A color vector, usually as hex codes.
#' @param upper The column name for the upper portion of heattriangle.
#' @param upper_name The label name (in quotes) for the legend of the upper
#' rendering. Default is \code{NULL}.
#' @param upper_colors A color vector, usually as hex codes.
#' @param ... \code{...} accepts any arguments \code{scale_fill_gradientn()} has
#' .
#'
#' @import ggplot2
#' @import grid
#' @import ggnewscale
#'
#' @export
#'
#' @examples
#'
#' # heattriangle with categorical variables only
#'
#' library(ggplot2)
#'
#' data <- data.frame(x = rep(c("a", "b", "c"), 3),
#'                    y = rep(c("d", "e", "f"), 3),
#'                    lower_values = rep(c(1,5,7),3),
#'                    upper_values = rep(c(2,3,4),3))
#'
#' ggplot(data, aes(x,y)) +
#' geom_heat_tri(lower = lower_values, upper = upper_values)
#'
#'
#' # heatcircle with numeric variables only
#'
#' data <- data.frame(x = rep(c(1, 2, 3), 3),
#'                    y = rep(c(1, 2, 3), 3),
#'                    lower_values = rep(c(1,5,7),3),
#'                    upper_values = rep(c(2,3,4),3))
#'
#' ggplot(data, aes(x,y)) +
#' geom_heat_tri(lower = lower_values, upper = upper_values)
#'
#'
#' # heatcircle with a mixture of numeric and categorical variables
#'
#' data <- data.frame(x = rep(c("a", "b", "c"), 3),
#'                    y = rep(c(1, 2, 3), 3),
#'                    lower_values = rep(c(1,5,7),3),
#'                    upper_values = rep(c(2,3,4),3))
#'
#' ggplot(data, aes(x,y)) +
#' geom_heat_tri(lower = lower_values, upper = upper_values)
#'
#'

geom_heat_tri <- function(lower,
                          lower_name = NULL,
                          lower_colors = c("#FED7D8","#FE8C91", "#F5636B", "#E72D3F","#C20824"),
                          upper,
                          upper_name = NULL,
                          upper_colors = c('gray100', 'gray85', 'gray50', 'gray35', 'gray0'),
                          ...){


  if(is.null(lower_name)) {lower_name = rlang::expr({{ lower }})}

  if(is.null(upper_name)) {upper_name = rlang::expr({{ upper }})}

  list(geom_lower_tri(ggplot2::aes(fill = {{ lower }})),

       ggplot2::scale_fill_gradientn(lower_name, colors = lower_colors, ...),

       ggnewscale::new_scale_fill(),

       geom_upper_tri(ggplot2::aes(fill = {{ upper }})),

       ggplot2::scale_fill_gradientn(upper_name, colors = upper_colors, ...))

}



#' @format NULL
#' @usage NULL


GeomTriLowerBase <- ggplot2::ggproto("GeomTriLowerBase", Geom,
                            default_aes = ggplot2::aes(color = NA, fill = "grey30", size = 0.5, linetype = 1,
                                              alpha = NA),

                            required_aes = c("xmin", "xmax", "ymin", "ymax"),


                            draw_panel = function(data, panel_params, coord) {

                              coords <- coord$transform(data, panel_params)

                              grid::polygonGrob(

                                x = c(coords$xmin, coords$xmin, coords$xmax),
                                y = c(coords$ymin, coords$ymax, coords$ymin),
                                id = rep(coords$group, times = 3),
                                gp = gpar(
                                  col = coords$color,
                                  fill = alpha(coords$fill, coords$alpha),
                                  lwd = coords$size * .pt,
                                  lty = coords$linetype

                                )
                              )
                            },

                            draw_key = ggplot2::draw_key_rect
)

#' @format NULL
#' @usage NULL


GeomTriUpperBase <- ggplot2::ggproto("GeomTriUpperBase", GeomTriLowerBase,

                            draw_panel = function(data, panel_params, coord) {

                              coords <- coord$transform(data, panel_params)
                              grid::polygonGrob(
                                x = c(coords$xmin, coords$xmax, coords$xmax),
                                y = c(coords$ymax, coords$ymax, coords$ymin),
                                id = rep(coords$group, times = 3),
                                gp = gpar(
                                  col = coords$color,
                                  fill = alpha(coords$fill, coords$alpha),
                                  lwd = coords$size * .pt,
                                  lty = coords$linetype

                                )
                              )
                            }
)


#' @format NULL
#' @usage NULL

GeomLowerTri <- ggplot2::ggproto("GeomLowerTri", GeomTriLowerBase,
                        extra_params = c("na.rm"),


                        setup_data = function(data, params) {
                          data$width <- data$width %||% params$width %||% resolution(data$x, FALSE)
                          data$height <- data$height %||% params$height %||% resolution(data$y, FALSE)


                          data <- transform(data,
                                            xmin = x - width / 2,  xmax = x + width / 2,  width = NULL,
                                            ymin = y - height / 2, ymax = y + height / 2, height = NULL)

                          if (anyDuplicated(data$group)) {

                            data$group <- seq_len(nrow(data))
                          }

                          data
                        },

                        default_aes = ggplot2::aes(fill = "grey20", colour = NA, size = 0.1, linetype = 1,
                                          alpha = NA, width = NA, height = NA),

                        required_aes = c("x", "y"),

                        non_missing_aes = c("xmin", "xmax", "ymin", "ymax"),

                        draw_key = ggplot2::draw_key_rect
)


#' @format NULL
#' @usage NULL


geom_lower_tri <- function(mapping = NULL, data = NULL,
                           stat = "identity", position = "identity",
                           ...,
                           linejoin = "mitre",
                           na.rm = FALSE,
                           show.legend = NA,
                           inherit.aes = TRUE) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomLowerTri,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}


#' @format NULL
#' @usage NULL


GeomUpperTri <- ggplot2::ggproto("GeomUpperTri", GeomTriUpperBase,

                        extra_params = c("na.rm"),

                        setup_data = function(data, params) {
                          data$width <- data$width %||% params$width %||% resolution(data$x, FALSE)
                          data$height <- data$height %||% params$height %||% resolution(data$y, FALSE)


                          data <- transform(data,
                                            xmin = x - width / 2,  xmax = x + width / 2,  width = NULL,
                                            ymin = y - height / 2, ymax = y + height / 2, height = NULL)

                          if (anyDuplicated(data$group)) {

                            data$group <- seq_len(nrow(data))
                          }

                          data
                        },

                        default_aes = ggplot2::aes(fill = "grey20", colour = NA, size = 0.1, linetype = 1,
                                          alpha = NA, width = NA, height = NA),

                        required_aes = c("x", "y"),

                        non_missing_aes = c("xmin", "xmax", "ymin", "ymax"),

                        draw_key = ggplot2::draw_key_rect
)


#' @format NULL
#' @usage NULL



geom_upper_tri <- function(mapping = NULL, data = NULL,
                           stat = "identity", position = "identity",
                           ...,
                           linejoin = "mitre",
                           na.rm = FALSE,
                           show.legend = NA,
                           inherit.aes = TRUE) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomUpperTri,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}


