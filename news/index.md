# Changelog

## simling (development version)

- [`?pupil_noise`](https://mcanzi.de/simling/reference/pupil_noise.md)
  gives the SD of the AR(1) residuals (20) as well as the SD of the
  innovations (12) used to simulate them.
- `citation("simling")` takes the version number from DESCRIPTION.

## simling 0.1.0

- First version, with 55 simulated data sets: 53 from 20 branches of
  linguistics, a meta-analysis and a messy export for data cleaning.
- [`simling_datasets()`](https://mcanzi.de/simling/reference/simling_datasets.md)
  lists the data sets with their branch, language, size, response and
  topic.
- Every data set comes with the code that generated it (`data-raw/`) and
  a help page listing its variables, its true model and its references.
- Each help page has an example that fits the model the data were
  simulated from, or summarises the pattern the page describes, so its
  output can be compared with the true values. Examples that need a
  package other than base R run only when that package is installed.
