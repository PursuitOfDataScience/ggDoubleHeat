#' Heatgrid
#'
#' The heatgrid geom is used to create a modified heat map that uses luminance
#' to show the values from two sources on the same plot.
#'
#' @param outside The column name for the outside portion of heatgrid.
#' @param outside_name The label name (in quotes) for the legend of the outside
#' rendering. Default is \code{NULL}.
#' @param outside_colors A color vector, usually as hex codes.
#' @param inside The column name for the inside portion of heatgrid.
#' @param inside_name The label name (in quotes) for the legend of the inside
#' rendering. Default is \code{NULL}.
#' @param inside_colors A color vector, usually as hex codes.
#' @param r The value that controls how large of the inside portion with respect
#' to the outside one. When \code{r} is larger, the inside get smaller.
#' Default value is 3.
#' @param ... \code{...} accepts any arguments \code{scale_fill_gradientn()} has
#' .
#'
#' @import ggplot2
#' @import grid
#' @import rlang
#' @import ggnewscale
#' @return A heatgrid (modified heatmap) with nested tiles.
#' @export
#'
#' @examples
#'
#' # heatgrid with categorical variables only
#'
#' data <- data.frame(x = rep(c("a", "b", "c"), 3),
#'                    y = rep(c("d", "e", "f"), 3),
#'                    outside_values = rep(c(1,5,7),3),
#'                    inside_values = rep(c(2,3,4),3))
#'
#' ggplot(data, aes(x,y)) + geom_heat_grid(outside = outside_values,
#'                                         inside = inside_values)
#'
#' # Making the inside smaller by setting r to be larger.
#'
#' ggplot(data, aes(x,y)) + geom_heat_grid(outside = outside_values,
#'                                         inside = inside_values,
#'                                         r = 5)
#'
#' # heatgrid with numeric variables only
#'
#' data <- data.frame(x = rep(c(1, 2, 3), 3),
#'                    y = rep(c(1, 2, 3), 3),
#'                    outside_values = rep(c(1,5,7),3),
#'                    inside_values = rep(c(2,3,4),3))
#'
#' ggplot(data, aes(x,y)) + geom_heat_grid(outside = outside_values,
#'                                         inside = inside_values)
#'
#'
#' # heatgrid with a mixure of numeric and categorical variables
#'
#' data <- data.frame(x = rep(c("a", "b", "c"), 3),
#'                    y = rep(c(1, 2, 3), 3),
#'                    outside_values = rep(c(1,5,7),3),
#'                    inside_values = rep(c(2,3,4),3))
#'
#' ggplot(data, aes(x,y)) + geom_heat_grid(outside = outside_values,
#'                                         inside = inside_values)
#'
#'
#'
#'


geom_heat_grid <- function(outside,
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

  list(geom_tile_outside(ggplot2::aes(fill = {{ outside }})),

       ggplot2::scale_fill_gradientn(outside_name, colors = outside_colors, ...),

       ggnewscale::new_scale_fill(),

       geom_tile_inside(ggplot2::aes(fill = {{ inside }}, r = r)),

       ggplot2::scale_fill_gradientn(inside_name, colors = inside_colors, ...))

}




#' @format NULL
#' @usage NULL
#' @export
GeomRectCenter <- ggplot2::ggproto("GeomRectCenter", ggplot2::Geom,
                    default_aes = ggplot2::aes(color = "black", fill = NA, size = 0.5, linetype = 1,
                                      alpha = NA),


                    required_aes = c("xmin", "xmax", "ymin", "ymax"),


                    draw_panel = function(data, panel_params, coord) {

                      coords <- coord$transform(data, panel_params)
                      grid::rectGrob(
                        x = (coords$xmin + coords$xmax)/2,
                        y = (coords$ymin + coords$ymax)/2,
                        width = coords$xmax - coords$xmin,
                        height = coords$ymax - coords$ymin,
                        just = "center",
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
#' @export
GeomTileOutside <- ggplot2::ggproto("GeomTileOutside", GeomRectCenter,
                     extra_params = c("na.rm"),


                     setup_data = function(data, params) {
                       data$width <- data$width %||% params$width %||% resolution(data$x, FALSE)
                       data$height <- data$height %||% params$height %||% resolution(data$y, FALSE)

                       transform(data,
                                 xmin = x - width / 2,  xmax = x + width / 2,  width = NULL,
                                 ymin = y - height / 2, ymax = y + height / 2, height = NULL
                       )
                     },

                     default_aes = ggplot2::aes(fill = "grey20", colour = NA, size = 0.1, linetype = 1,
                                       alpha = NA, width = NA, height = NA),

                     required_aes = c("x", "y"),
                     non_missing_aes = c("xmin", "xmax", "ymin", "ymax"),

                     draw_key = ggplot2::draw_key_rect
)



geom_tile_outside <- function(mapping = NULL, data = NULL,
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
    geom = GeomTileOutside,
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
#' @export
GeomTileInside <- ggplot2::ggproto("GeomTileInside", GeomTileOutside,

                          setup_data = function(data, params) {
                            data$width <- data$width %||% params$width %||% resolution(data$x, FALSE)
                            data$height <- data$height %||% params$height %||% resolution(data$y, FALSE)

                            transform(data,
                                      xmin = x -  width/r,  xmax = x + width/r,  width = NULL,
                                      ymin = y - height/r, ymax = y + height/r, height = NULL
                            )
                          },

                          required_aes = c("x", "y", "r")
)

geom_tile_inside <- function(mapping = NULL, data = NULL,
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
    geom = GeomTileInside,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}


