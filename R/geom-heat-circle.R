#' Heatcircle
#'
#' The heatcircle geom is used to create the two concentric circles that use luminance to
#' show the values from two sources on the same plot.
#' @param outside The column name for the outside portion of heatcircle.
#' @param outside_name The label name (in quotes) for the legend of the outside rendering. Default
#' is NULL.
#' @param outside_colors A color vector, usually as hexcodes.
#' @param inside The column name for the inside portion of heatcircle.
#' @param inside_name The label name (in quotes) for the legend of the inside rendering. Default
#' is NULL.
#' @param inside_colors A color vector, usually as hexcodes.
#' @param r The value that controls how large of the inside portion with respect to the outside one.
#' When r is larger, the inside get smaller. Default value is 3.
#' @param ...
#'
#' @import ggplot2
#' @import grid
#' @import rlang
#' @return geom_heat_circle
#' @export
#'
#' @examples
#'
#' # A simple heatcircle
#'
#' data <- data.frame(x = rep(c("a", "b", "c"), 3),
#'                    y = rep(c("d", "e", "f"), 3),
#'                    outside_values = rep(c(1,5,7),3),
#'                    inside_values = rep(c(2,3,4),3))
#'
#' ggplot(data, aes(x,y)) + geom_heat_circle(outside = outside_values,
#'                                           inside = inside_values)
#'


geom_heat_circle <- function(outside,
                             outside_name = NULL,
                             outside_colors = c("#FED7D8","#FE8C91", "#F5636B", "#E72D3F","#C20824"),
                             inside,
                             inside_name = NULL,
                             inside_colors = c('gray100', 'gray85', 'gray50', 'gray35', 'gray0'),
                             r = 3,
                             ...){

  if(r <= 2){rlang::abort(message = "`r` has to be greater than 2.")}

  if(is.null(outside_name)) {outside_name = rlang::expr({{ outside }})}

  if(is.null(inside_name)) {inside_name = rlang::expr({{ inside }})}

  list(geom_circle_outside(ggplot2::aes(fill = {{ outside }})),

       ggplot2::scale_fill_gradientn(outside_name, colors = outside_colors, ...),

       ggnewscale::new_scale_fill(),

       geom_circle_inside(aes(fill = {{ inside }}, r = r)),

       ggplot2::scale_fill_gradientn(inside_name, colors = inside_colors, ...))

}




GeomOneCircle <- ggplot2::ggproto("GeomOneCircle", ggplot2::Geom,
                         default_aes = ggplot2::aes(color = "green", fill = "green", size = 0.5, linetype = 1,
                                           alpha = NA),


                         required_aes = c("xmin", "xmax", "ymin", "ymax"),


                         draw_panel = function(data, panel_params, coord) {

                           coords <- coord$transform(data, panel_params)
                           grid::circleGrob(
                             x = (coords$xmin + coords$xmax)/2,
                             y = (coords$ymin + coords$ymax)/2,
                             r = ifelse(coords$xmax - coords$xmin < coords$ymax - coords$ymin,
                                        (coords$xmax - coords$xmin)/2,
                                        (coords$ymax - coords$ymin)/2),
                             gp = gpar(
                               col = coords$color,
                               fill = alpha(coords$fill, coords$alpha),
                               lwd = coords$size * .pt,
                               lty = coords$linetype
                             )
                           )
                         },

                         draw_key = ggplot2::draw_key_dotplot
)




GeomCircleOutside <- ggplot2::ggproto("GeomCircleOutside", GeomOneCircle,
                       extra_params = c("na.rm"),


                       setup_data = function(data, params) {
                         data$width <- data$width %||% params$width %||% resolution(data$x, FALSE)
                         data$height <- data$height %||% params$height %||% resolution(data$y, FALSE)

                         transform(data,
                                   xmin = x -  0.5 * width,  xmax = x + 0.5 * width,  width = NULL,
                                   ymin = y - 0.5 * height, ymax = y + 0.5 * height, height = NULL
                         )
                       },

                       default_aes = ggplot2::aes(fill = "grey20", colour = NA, size = 0.1, linetype = 1,
                                         alpha = NA, width = NA, height = NA),

                       required_aes = c("x", "y"),
                       non_missing_aes = c("xmin", "xmax", "ymin", "ymax"),

                       draw_key = ggplot2::draw_key_dotplot
)



geom_circle_outside <- function(mapping = NULL, data = NULL,
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
    geom = GeomCircleOutside,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}




GeomCircleInside <- ggplot2::ggproto("GeomCircleInside", GeomCircleOutside,
                       extra_params = c("na.rm"),


                       setup_data = function(data, params) {
                         data$width <- data$width %||% params$width %||% resolution(data$x, FALSE)
                         data$height <- data$height %||% params$height %||% resolution(data$y, FALSE)

                         transform(data,
                                   xmin = x - width / r,  xmax = x + width / r,  width = NULL,
                                   ymin = y - height / r, ymax = y + height / r, height = NULL
                         )
                       },

                       required_aes = c("x", "y", "r")
)



geom_circle_inside <- function(mapping = NULL, data = NULL,
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
    geom = GeomCircleInside,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}
