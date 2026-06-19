# Heattriangle

The heattriangle geom is used to create the two triangles split by a
diagonal line of a rectangle that use luminance to show the values from
two sources on the same plot.

## Usage

``` r
geom_heat_tri(
  lower,
  lower_name = NULL,
  lower_colors = c("#FED7D8", "#FE8C91", "#F5636B", "#E72D3F", "#C20824"),
  upper,
  upper_name = NULL,
  upper_colors = c("gray100", "gray85", "gray50", "gray35", "gray0"),
  ...
)
```

## Arguments

- lower:

  The column name for the lower portion of heattriangle.

- lower_name:

  The label name (in quotes) for the legend of the lower rendering.
  Default is `NULL`.

- lower_colors:

  A color vector, usually as hex codes.

- upper:

  The column name for the upper portion of heattriangle.

- upper_name:

  The label name (in quotes) for the legend of the upper rendering.
  Default is `NULL`.

- upper_colors:

  A color vector, usually as hex codes.

- ...:

  `...` accepts any arguments
  [`scale_fill_gradientn()`](https://ggplot2.tidyverse.org/reference/scale_gradient.html)
  has .

## Value

A heattriangle with the main diagonal split by a line within each unit.

## Examples

``` r

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


```
