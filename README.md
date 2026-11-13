# simling

Simulated linguistic data for teaching statistics in R.

Every data set in simling is simulated, and the code that generated it is in [`data-raw/`](data-raw). The true effects are therefore known: you can fit a model and check whether it recovers them. Each help page (`?vowel_duration`) lists the variables and the true model.

## Installation

```r
install.packages("simling", repos = c("https://mcanzi.r-universe.dev", "https://cloud.r-project.org"))
```

or, from GitHub:

```r
# install.packages("remotes")
remotes::install_github("mcanzi/simling")
```

## Usage

```r
library(simling)
vowel_duration
```

## Data sets

| Branch | Data set | Rows | Response | Topic |
|---|---|---:|---|---|
| Phonetics | `formants` | 120 | continuous | Normalisation, z-scores |
| | `vowel_voicing` | 120 | continuous | Two groups, t-tests |
| | `speech_styles` | 150 | continuous | Categorical predictors with three levels |
| | `style_voicing` | 160 | continuous | Categorical × categorical interaction |
| | `vowel_duration` | 384 | continuous | Mixed models, random slopes |
| | `price_f2` | 2,200 | trajectories | GAMs and GAMMs |
| Psycholinguistics | `rt_frequency` | 200 | continuous, binary | Data wrangling |
| | `word_rt` | 400 | continuous | Multiple regression, collinearity |
| | `freq_length` | 400 | continuous | Continuous × continuous interaction |
| | `l2_frequency` | 400 | continuous | Continuous × categorical interaction |
| | `lexical_decision` | 800 | continuous | Mixed models, crossed random effects |
| | `lexical_decision_l2` | 1,200 | continuous | Mixed models with interactions, figures |
| | `pilot_rt` | 1,200 | continuous | Power analysis by simulation |
| | `lexical_accuracy` | 1,800 | binary | Mixed logistic regression |
| | `zipf_rt` | 2,000 | continuous | Log transformations |
| | `megastudy` | 6,000 | continuous, proportion | Large item-level data, non-linear effects |
| | `pupil_noise` | 17,856 | trajectories | GAMMs, autocorrelation |
| | `visual_world` | 23,040 | counts out of samples | Eye tracking, time-course analysis |
| Syntax | `agreement_attraction` | 1,280 | eye-tracking measures, binary | Reading measures, missing data |
| | `acceptability` | 1,536 | 7-point ratings | Ordinal regression |
| Semantics and pragmatics | `address_forms` | 180 | categorical | Contingency tables, chi-squared |
| | `scalar_implicature` | 1,440 | binary, continuous | Bimodal individual differences |
| Corpus linguistics | `passives` | 400 | counts | Poisson and negative binomial regression, offsets |
| | `relativizers` | 2,400 | three categories | Multinomial regression |
| Sociolinguistics | `td_deletion` | 2,000 | binary | Trees and random forests |
| Second language | `perception_training` | 18 | correct out of 40 | Paired designs, wide data |
| | `accent` | 1,200 | categorical | Random forests, cross-validation |
| Language acquisition | `overregularization` | 144 | errors out of attempts | Binomial regression, non-linear age |
| | `vocabulary_growth` | 715 | counts out of 680 | Growth curves, longitudinal data |
| Historical linguistics | `do_support` | 1,200 | counts out of trials | Logistic change, Constant Rate Effect |
| Typology | `word_order` | 400 | categorical, counts | Non-independence of languages |

## Rebuilding the data

Run `source("data-raw/make_all.R")` from the package root. Each script sets its own seed, so the data are identical every time.

## License

MIT © Massimiliano Canzi
