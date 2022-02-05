
data_numeric <- data.frame(x = rep(c(1, 2, 3), 3),
                           y = rep(c(1, 2, 3), 3),
                           outside_values = rep(c(1,5,7),3),
                           inside_values = rep(c(2,3,4),3))



# Visual tests ------------------------------------------------------------

test_that("geom_heat_* on all numeric data", {
  p <- ggplot(data_numeric, aes(x,y)) + geom_heat_grid(outside = outside_values, inside = inside_values)
  vdiffr::expect_doppelganger("geom_heat_grid numeric", p)

  p <- ggplot(data_numeric, aes(x,y)) + geom_heat_circle(outside = outside_values, inside = inside_values)
  vdiffr::expect_doppelganger("geom_heat_circle numeric", p)

  p <- ggplot(data_numeric, aes(x,y)) + geom_heat_tri(lower = outside_values, upper = inside_values)
  vdiffr::expect_doppelganger("geom_heat_tri numeric", p)

})
