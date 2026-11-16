# simling (development version)

* New data set `web_registers`: 16 lexico-grammatical features in 480 texts
  from six web registers, for factor analysis in the style of a
  multi-dimensional analysis. Its parameters are based on the web register
  data of Ehret and Taboada (2021).
* New hex logo: an orange cut in half, in the sunset colours of mcanzi.de.
* `?pupil_noise` gives the SD of the AR(1) residuals (20) as well as the SD
  of the innovations (12) used to simulate them.
* `citation("simling")` takes the version number from DESCRIPTION.

# simling 0.1.0

* First version, with 55 simulated data sets: 53 from 20 branches of
  linguistics, a meta-analysis and a messy export for data cleaning.
* `simling_datasets()` lists the data sets with their branch, language, size,
  response and topic.
* Every data set comes with the code that generated it (`data-raw/`) and a
  help page listing its variables, its true model and its references.
* Each help page has an example that fits the model the data were simulated
  from, or summarises the pattern the page describes, so its output can be
  compared with the true values. Examples that need a package other than base
  R run only when that package is installed.
