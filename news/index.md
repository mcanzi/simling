# Changelog

## simling 0.1.0

- First version, with 55 simulated data sets from 20 branches of
  linguistics, plus a meta-analysis and a messy export for data
  cleaning.
- [`simling_datasets()`](https://mcanzi.de/simling/reference/simling_datasets.md)
  lists the data sets with their branch, language, size, response and
  topic.
- Every data set comes with the code that generated it (`data-raw/`) and
  a help page listing its variables, its true model and its references.
- Each help page has an example that fits the model the data were
  simulated from, or summarises the pattern the page describes, so its
  output can be compared with the true values. Examples that need a
  package other than base R run only when that package is installed.
