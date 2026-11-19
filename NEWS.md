# simling 0.1.2

* `?vowel_duration` cites the vowel duration simulation in Winter (2019,
  section 15.2) that the data set is based on.
* New data set `fuzzy_contrasts`: articulatory trajectories (linear
  discriminant values from ultrasound images) of GOOSE and FOOT before /l/
  in four morphological contexts in Southern British English, after
  Strycharczuk and Scobbie (2017). Durations and the numbers of speakers
  with each contrast follow the paper.
* `?disfluencies`, `?rhythm_metrics` and `?word_order` now cite Di Napoli
  (2020), Rathcke and Smith (2015) and Dryer (2013) in the text.
* README: simling has 57 data sets from 20 branches of linguistics.
* The scripts in `data-raw/` use the tidyverse throughout: purrr instead of
  loops and apply functions, joins and `case_when()` instead of index
  lookups, and stringr instead of base string functions. They reproduce the
  data exactly. `data-raw/session_info.txt` lists the R and package
  versions used.
* `german_plurals$article`, `korean_stops$vot` and
  `mandarin_tones$duration` no longer carry a stray `names` attribute. Their
  values are unchanged.
* `?price_f2`, `?visual_world` and `?mandarin_tones` give the SD of the
  AR(1) innovations as well as the SD of the residuals.
* `?iterated_learning` gives the starting number of distinct words in each
  condition, the size of its decline and its variation between chains.
* `?lexical_decision_l2` gives the range of `length` in the data (3 to 12).
* `?reading_skipping` says that first fixations are log-normal around the
  values from Rayner et al. (2011).
* Help pages cite in the text all of the works they list, and reference
  lists are in alphabetical order. The two Ehret and Taboada (2021) works
  are now 2021a and 2021b. The scripts in `data-raw/` cite the same works
  as their help pages.
* New titles: `?lexical_accuracy` ("Italian lexical decision accuracy"),
  `?word_order` ("Word order across 400 invented languages") and
  `?hungarian_harmony` ("A wug test of Hungarian vowel harmony").
* README lists the packages needed to rebuild the data.

# simling 0.1.1

* simling can be installed from R-universe (<https://mcanzi.r-universe.dev>).
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
