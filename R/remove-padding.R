#' Remove ggplot2 default padding
#'
#' The default ggplot2 plots give certain amount of padding for both continuous
#' and discrete variables. Due to this padding, it makes the plots generated from
#' `geom_heat_*()` look like there is something missing. Depends on users' preference,
#' they can remove the "empty space" by using this function. The only thing users
#' need to figure out is whether the `x` and `y` scales are continuous or discrete.
#'
#' @param x x-axis scale, if it is continuous scale, input "c"; discrete, "d".
#' @param y y-axis scale, if it is continuous scale, input "c"; discrete, "d".
#' @param ... ...
#'
#' @return remove_padding
#' @export
#' @import ggplot2
#' @import rlang


remove_padding <- function(x = "c", y = "d", ...){

  if (!(x == "c" || x == "d")) {rlang::abort("Arguments `x` only takes `c` or `d`")}

  else if (!(y == "c" || y == "d")) {rlang::abort("Arguments `y` only takes `c` or `d`")}

  else if (x == "c" && y == "d") {list(ggplot2::scale_x_continuous(expand = c(0, 0), ...), ggplot2::scale_y_discrete(expand = c(0, 0), ...))}

  else if (x == "c" && y == "c") {list(ggplot2::scale_x_continuous(expand = c(0, 0), ...),  ggplot2::scale_y_continuous(expand = c(0, 0), ...))}

  else if (x == "d" && y == "c") {list(ggplot2::scale_x_discrete(expand = c(0, 0), ...),  ggplot2::scale_y_continuous(expand = c(0, 0), ...))}

  else {list(ggplot2::scale_x_discrete(expand = c(0, 0), ...), ggplot2::scale_y_discrete(expand = c(0, 0), ...))}

  }
