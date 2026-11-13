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

| Branch | Data set | Language | Rows | Response | Topic |
|---|---|---|---:|---|---|
| Phonetics | `formants` | – | 120 | continuous | Normalisation, z-scores |
| | `vowel_voicing` | English | 120 | continuous | Two groups, t-tests |
| | `speech_styles` | – | 150 | continuous | Categorical predictors with three levels |
| | `style_voicing` | – | 160 | continuous | Categorical × categorical interaction |
| | `vowel_duration` | – | 384 | continuous | Mixed models, random slopes |
| | `korean_stops` | Korean | 1,440 | continuous | Cluster analysis, sound change |
| | `price_f2` | English (L1 and L2) | 2,200 | trajectories | GAMs and GAMMs |
| | `mandarin_tones` | Mandarin | 4,224 | trajectories | Contour shape, speaker normalisation |
| Psycholinguistics | `rt_frequency` | – | 200 | RT, binary | Data wrangling |
| | `word_rt` | – | 400 | RT | Multiple regression, collinearity |
| | `freq_length` | – | 400 | RT | Continuous × continuous interaction |
| | `l2_frequency` | – | 400 | RT | Continuous × categorical interaction |
| | `lexical_decision` | – | 800 | RT | Mixed models, crossed random effects |
| | `lexical_decision_l2` | German (L1 and L2) | 1,200 | RT | Mixed models with interactions, figures |
| | `naming_pilot` | German | 1,200 | naming latency | Power analysis by simulation |
| | `lexical_accuracy` | Italian | 1,800 | binary | Mixed logistic regression |
| | `zipf_rt` | – | 2,000 | RT | Skewed predictors, log transformations |
| | `megastudy` | – | 6,000 | RT, proportion | Large item-level data, non-linear effects |
| | `pupil_noise` | – | 17,856 | trajectories | GAMMs, autocorrelation |
| | `n400` | German | 21,600 | ERP amplitude | EEG, topography, continuous predictors |
| | `visual_world` | English | 23,040 | samples per object | Eye tracking, time-course analysis |
| Syntax | `agreement_attraction` | English | 1,280 | eye-tracking measures, binary | Reading measures, missing data |
| | `acceptability` | English | 1,536 | 7-point ratings | Ordinal regression |
| | `german_relatives` | German | 13,824 | reading times | Self-paced reading, region-by-region analysis |
| Morphology | `german_plurals` | German | 2,880 | five categories | Multinomial regression, wug tests |
| Semantics and pragmatics | `scalar_implicature` | English | 1,440 | binary, RT | Bimodal individual differences |
| Conversation | `turn_taking` | 10 languages | 3,000 | gap duration | Skewed distributions, cross-linguistic comparison |
| Corpus linguistics | `passives` | English | 400 | counts | Poisson and negative binomial regression, offsets |
| | `relativizers` | English | 2,400 | three categories | Multinomial regression |
| Sociolinguistics | `address_forms` | German | 180 | categorical | Contingency tables, chi-squared |
| | `language_attitudes` | – | 320 | 5-point ratings | Factor analysis, reverse-coding |
| | `cantonese_tone_merger` | Cantonese | 1,800 | continuous | Sound change in apparent time, mixtures |
| | `td_deletion` | English | 2,000 | binary | Trees and random forests |
| Dialectology | `dialect_survey` | Italian | 580 | counts out of 10 | Maps, spatial patterns |
| Second language | `perception_training` | – | 18 | correct out of 40 | Paired designs, wide data |
| | `accent` | English (L1 and L2) | 1,200 | categorical | Random forests, cross-validation |
| Language acquisition | `overregularization` | English | 144 | errors out of attempts | Binomial regression, null effects |
| | `vocabulary_growth` | English | 572 | counts out of 680 | Growth curves, longitudinal data |
| Historical linguistics | `do_support` | English | 1,200 | counts out of trials | Logistic change, Constant Rate Effect |
| Typology | `word_order` | 400 invented languages | 400 | categorical, counts | Non-independence of languages |

"–" marks data sets without a particular language.

## Rebuilding the data

Run `source("data-raw/make_all.R")` from the package root. Each script sets its own seed, so the data are identical every time.

## License

MIT © Massimiliano Canzi
