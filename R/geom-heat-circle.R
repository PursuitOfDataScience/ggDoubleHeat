#' Heatcircle
#'
#' @param outside The column name for the outside portion of heatcircle.
#' @param outside_name The label name (in quotes) for the legend of the outside rendering. Default
#' is "outside".
#' @param outside_colors A color vector, usually as hexcodes.
#' @param inside The column name for the inside portion of heatcircle.
#' @param inside_name The label name (in quotes) for the legend of the inside rendering. Default
#' is "outside".
#' @param inside_colors A color vector, usually as hexcodes.
#' @param r The value that controls how large of the inside portion with respect to the outside one.
#' When r is larger, the inside get smaller. Default value is 3.
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
geom_heat_circle <- function(outside,
                             outside_name = "outside",
                             outside_colors = c("#FED7D8","#FE8C91", "#F5636B", "#E72D3F","#C20824"),
                             inside,
                             inside_name = "inside",
                             inside_colors = c('gray100', 'gray85', 'gray50', 'gray35', 'gray0'),
                             r = 3,
                             ...){
  list(geom_circle_outside(aes(fill = {{ outside }})),
       scale_fill_gradientn(outside_name, colors = outside_colors, ...),
       new_scale("fill"),
       geom_circle_inside(aes(fill = {{ inside }}, r = r)),
       scale_fill_gradientn(inside_name, colors = inside_colors, ...))

}




GeomOneCircle <- ggproto("GeomOneCircle", Geom,
                         default_aes = aes(color = "green", fill = "green", size = 0.5, linetype = 1,
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

                         draw_key = draw_key_dotplot
)




GeomCircleOutside <- ggproto("GeomCircleOutside", GeomOneCircle,
                       extra_params = c("na.rm"),


                       setup_data = function(data, params) {
                         data$width <- data$width %||% params$width %||% resolution(data$x, FALSE)
                         data$height <- data$height %||% params$height %||% resolution(data$y, FALSE)

                         transform(data,
                                   xmin = x -  0.5 * width,  xmax = x + 0.5 * width,  width = NULL,
                                   ymin = y - 0.5 * height, ymax = y + 0.5 * height, height = NULL
                         )
                       },

                       default_aes = aes(fill = "grey20", colour = NA, size = 0.1, linetype = 1,
                                         alpha = NA, width = NA, height = NA),

                       required_aes = c("x", "y"),
                       non_missing_aes = c("xmin", "xmax", "ymin", "ymax"),

                       draw_key = draw_key_dotplot
)



geom_circle_outside <- function(mapping = NULL, data = NULL,
                          stat = "identity", position = "identity",
                          ...,
                          linejoin = "mitre",
                          na.rm = FALSE,
                          show.legend = NA,
                          inherit.aes = TRUE) {
  layer(
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




GeomCircleInside <- ggproto("GeomCircleInside", GeomCircleOutside,
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
  layer(
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
