pkgname <- "ggDoubleHeat"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "ggDoubleHeat-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('ggDoubleHeat')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("geom_heat_circle")
### * geom_heat_circle

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: geom_heat_circle
### Title: Heatcircle
### Aliases: geom_heat_circle

### ** Examples


# heatcircle with categorical variables only

library(ggplot2)

data <- data.frame(x = rep(c("a", "b", "c"), 3),
                   y = rep(c("d", "e", "f"), 3),
                   outside_values = rep(c(1,5,7),3),
                   inside_values = rep(c(2,3,4),3))

ggplot(data, aes(x,y)) +
geom_heat_circle(outside = outside_values,
                 inside = inside_values)


# Making the inside smaller by setting r to be larger.

ggplot(data, aes(x,y)) +
geom_heat_circle(outside = outside_values,
                 inside = inside_values,
                 r = 5)


# heatcircle with numeric variables only

data <- data.frame(x = rep(c(1, 2, 3), 3),
                   y = rep(c(1, 2, 3), 3),
                   outside_values = rep(c(1,5,7),3),
                   inside_values = rep(c(2,3,4),3))

ggplot(data, aes(x,y)) +
geom_heat_circle(outside = outside_values,
                 inside = inside_values)


# heatcircle with a mixture of numeric and categorical variables

data <- data.frame(x = rep(c("a", "b", "c"), 3),
                   y = rep(c(1, 2, 3), 3),
                   outside_values = rep(c(1,5,7),3),
                   inside_values = rep(c(2,3,4),3))

ggplot(data, aes(x,y)) +
geom_heat_circle(outside = outside_values,
                 inside = inside_values)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("geom_heat_circle", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("geom_heat_grid")
### * geom_heat_grid

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: geom_heat_grid
### Title: Heatgrid
### Aliases: geom_heat_grid

### ** Examples


# heatgrid with categorical variables only

library(ggplot2)

data <- data.frame(x = rep(c("a", "b", "c"), 3),
                   y = rep(c("d", "e", "f"), 3),
                   outside_values = rep(c(1,5,7),3),
                   inside_values = rep(c(2,3,4),3))

ggplot(data, aes(x,y)) +
geom_heat_grid(outside = outside_values,
               inside = inside_values)

# Making the inside smaller by setting r to be larger.

ggplot(data, aes(x,y)) +
geom_heat_grid(outside = outside_values,
               inside = inside_values,
               r = 5)

# heatgrid with numeric variables only

data <- data.frame(x = rep(c(1, 2, 3), 3),
                   y = rep(c(1, 2, 3), 3),
                   outside_values = rep(c(1,5,7),3),
                   inside_values = rep(c(2,3,4),3))

ggplot(data, aes(x,y)) +
geom_heat_grid(outside = outside_values,
               inside = inside_values)


# heatgrid with a mixture of numeric and categorical variables

data <- data.frame(x = rep(c("a", "b", "c"), 3),
                   y = rep(c(1, 2, 3), 3),
                   outside_values = rep(c(1,5,7),3),
                   inside_values = rep(c(2,3,4),3))

ggplot(data, aes(x,y)) +
geom_heat_grid(outside = outside_values,
               inside = inside_values)







base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("geom_heat_grid", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("geom_heat_tri")
### * geom_heat_tri

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: geom_heat_tri
### Title: Heattriangle
### Aliases: geom_heat_tri

### ** Examples


# heattriangle with categorical variables only

library(ggplot2)

data <- data.frame(x = rep(c("a", "b", "c"), 3),
                   y = rep(c("d", "e", "f"), 3),
                   lower_values = rep(c(1,5,7),3),
                   upper_values = rep(c(2,3,4),3))

ggplot(data, aes(x,y)) +
geom_heat_tri(lower = lower_values, upper = upper_values)


# heatcircle with numeric variables only

data <- data.frame(x = rep(c(1, 2, 3), 3),
                   y = rep(c(1, 2, 3), 3),
                   lower_values = rep(c(1,5,7),3),
                   upper_values = rep(c(2,3,4),3))

ggplot(data, aes(x,y)) +
geom_heat_tri(lower = lower_values, upper = upper_values)


# heatcircle with a mixture of numeric and categorical variables

data <- data.frame(x = rep(c("a", "b", "c"), 3),
                   y = rep(c(1, 2, 3), 3),
                   lower_values = rep(c(1,5,7),3),
                   upper_values = rep(c(2,3,4),3))

ggplot(data, aes(x,y)) +
geom_heat_tri(lower = lower_values, upper = upper_values)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("geom_heat_tri", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
