
data_char <- data.frame(x = rep(c("a", "b", "c"), 3),
                        y = rep(c("d", "e", "f"), 3),
                        outside_values = rep(c(1,5,7),3),
                        inside_values = rep(c(2,3,4),3))



# Visual tests ------------------------------------------------------------

test_that("geom_heat_* on all character data", {
  p <- ggplot(data_char, aes(x,y)) + geom_heat_grid(outside = outside_values, inside = inside_values)
  vdiffr::expect_doppelganger("geom_heat_grid character", p)

  p <- ggplot(data_char, aes(x,y)) + geom_heat_circle(outside = outside_values, inside = inside_values)
  vdiffr::expect_doppelganger("geom_heat_circle character", p)

  p <- ggplot(data_char, aes(x,y)) + geom_heat_tri(lower = outside_values, upper = inside_values)
  vdiffr::expect_doppelganger("geom_heat_tri character", p)

})
