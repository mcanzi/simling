# Changelog

## simling 0.1.2

- The scripts in `data-raw/` use the tidyverse throughout: purrr instead
  of loops and apply functions, joins and `case_when()` instead of index
  lookups, and stringr instead of base string functions. They reproduce
  the data exactly. `data-raw/session_info.txt` lists the R and package
  versions used.
- `german_plurals$article`, `korean_stops$vot` and
  `mandarin_tones$duration` no longer carry a stray `names` attribute.
  Their values are unchanged.
- [`?price_f2`](https://mcanzi.de/simling/reference/price_f2.md),
  [`?visual_world`](https://mcanzi.de/simling/reference/visual_world.md)
  and
  [`?mandarin_tones`](https://mcanzi.de/simling/reference/mandarin_tones.md)
  give the SD of the AR(1) innovations as well as the SD of the
  residuals.
- [`?iterated_learning`](https://mcanzi.de/simling/reference/iterated_learning.md)
  gives the starting number of distinct words in each condition, the
  size of its decline and its variation between chains.
- [`?lexical_decision_l2`](https://mcanzi.de/simling/reference/lexical_decision_l2.md)
  gives the range of `length` in the data (3 to 12).
- [`?reading_skipping`](https://mcanzi.de/simling/reference/reading_skipping.md)
  says that first fixations are log-normal around the values from Rayner
  et al. (2011).
- Help pages cite in the text most of the works they list, and reference
  lists are in alphabetical order. The two Ehret and Taboada (2021)
  works are now 2021a and 2021b. The scripts in `data-raw/` cite the
  same works as their help pages.
- New titles:
  [`?lexical_accuracy`](https://mcanzi.de/simling/reference/lexical_accuracy.md)
  (“Italian lexical decision accuracy”),
  [`?word_order`](https://mcanzi.de/simling/reference/word_order.md)
  (“Word order across 400 invented languages”) and
  [`?hungarian_harmony`](https://mcanzi.de/simling/reference/hungarian_harmony.md)
  (“A wug test of Hungarian vowel harmony”).
- README lists the packages needed to rebuild the data.

## simling 0.1.1

- simling can be installed from R-universe
  (<https://mcanzi.r-universe.dev>).
- New data set `web_registers`: 16 lexico-grammatical features in 480
  texts from six web registers, for factor analysis in the style of a
  multi-dimensional analysis. Its parameters are based on the web
  register data of Ehret and Taboada (2021).
- New hex logo: an orange cut in half, in the sunset colours of
  mcanzi.de.
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
