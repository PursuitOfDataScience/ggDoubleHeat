# States' COVID-related Google & Twitter incidence rates

A data set containing the 30-week incidence rates of COVID related
categories from week 1 starting from June 1, 2020 to week 30 that ended
in the last Sunday of the year in 4 states (Florida, Missouri, New York,
and Texas). The data columns are introduced below. One quick note about
the columns of the data set: `week_start` as a column is present in the
data set for illustration purposes, reminding users what `week` column
is. In other words, it does not participate any visualization.

## Usage

``` r
states_tg
```

## Format

A data frame with 1116 rows and 6 columns:

- state:

  state

- week:

  week 1 to week 30.

- week_start:

  The Monday date of the week started.

- category:

  9 Covid-related categories in total.

- Twitter:

  weekly tweets percentage (%) in state falling into each category.

- Google:

  weekly Google search percentage (%) in state falling into each
  category.

## Source

Just like `pitts_tg`, Google is processed from Google Health API, and
Twitter from Meltwater, a Twitter vendor. Both data sources are
processed by the authors of the package.
