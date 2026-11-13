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

| Data set | Design | Topic |
|---|---|---|
| `rt_frequency` | 10 participants × 20 words | Data wrangling |
| `formants` | 2 speakers × 3 vowels × 20 tokens | Normalisation, z-scores |
| `zipf_rt` | 2000 words | Log transformations |
| `word_rt` | 400 words | Multiple regression, collinearity |
| `vowel_voicing` | 2 groups × 60 | Categorical predictors, t-tests |
| `speech_styles` | 3 groups × 50 | Categorical predictors with three levels |
| `l2_frequency` | 2 groups × 200 | Continuous × categorical interaction |
| `style_voicing` | 2 × 2 cells × 40 | Categorical × categorical interaction |
| `freq_length` | 400 words | Continuous × continuous interaction |
| `lexical_decision` | 20 participants × 40 words | Mixed models, crossed random effects |
| `vowel_duration` | 16 speakers × 24 words | Mixed models, random slopes |
| `lexical_accuracy` | 30 participants × 60 words | Mixed logistic regression |
| `lexical_decision_l2` | 30 participants × 40 words | Mixed models with interactions, figures |
| `price_f2` | 20 speakers × 10 tokens × 11 time points | GAMs and GAMMs |
| `pupil_noise` | 24 participants × 2 conditions × 12 trials × 31 time points | GAMMs, autocorrelation |
| `td_deletion` | 40 speakers × 50 tokens | Trees and random forests |
| `accent` | 30 speakers × 40 tokens | Random forests, cross-validation |
| `pilot_rt` | 30 participants × 40 words | Power analysis by simulation |

## Rebuilding the data

Run `source("data-raw/make_all.R")` from the package root. Each script sets its own seed, so the data are identical every time.

## License

MIT © Massimiliano Canzi
