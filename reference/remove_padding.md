# Remove ggplot2 default padding

The default ggplot2 plots give certain amount of padding for both
continuous and discrete variables. Due to this padding, it makes the
plots generated from \`geom_heat\_\*()\` look like there is something
missing. Depends on users' preference, they can remove the "empty space"
by using this function. The only thing users need to figure out is
whether the \`x\` and \`y\` scales are continuous or discrete.

## Usage

``` r
remove_padding(x = "c", y = "d", ...)
```

## Arguments

- x:

  x-axis scale, if it is continuous scale, input "c"; discrete, "d".

- y:

  y-axis scale, if it is continuous scale, input "c"; discrete, "d".

- ...:

  ...

## Value

remove_padding
