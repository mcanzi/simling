# Linguistic features of six web registers

Frequencies of 16 lexico-grammatical features in 480 texts from six
registers of the web, as used in multi-dimensional analysis (Biber,
1988). Its parameters are based on the web register data of Ehret and
Taboada (2021). Three dimensions underlie the features, and one column
is the sum of three others. For exploratory factor analysis and, on the
dimension scores, cluster analysis.

## Usage

``` r
web_registers
```

## Format

A tibble with 480 rows and 20 columns. Except for `word_length`, the
features are rates per 1,000 words.

- text:

  Text ID, `T001` to `T480`.

- register:

  `"forum discussion"`, `"personal blog"`, `"news report"`,
  `"encyclopedia article"`, `"research article"` or `"recipe"`.

- words:

  Text length in words.

- adverbs:

  Adverbs.

- attributive_adjectives:

  Attributive adjectives (*a new house*).

- conjuncts:

  Conjuncts (*however*, *therefore*).

- contractions:

  Contractions (*don't*, *it's*).

- first_person:

  First person pronouns.

- negation:

  Analytic negation (*not*).

- nominalisations:

  Nominalisations (*situation*, *development*).

- nouns:

  Nouns.

- past_tense:

  Past tense verbs.

- perfect_aspect:

  Perfect aspect (*has done*).

- prepositions:

  Prepositions.

- present_tense:

  Present tense verbs.

- private_verbs:

  Private verbs (*think*, *feel*, *know*).

- pronouns:

  All personal pronouns: the sum of `first_person`, `second_person` and
  `third_person`.

- second_person:

  Second person pronouns.

- third_person:

  Third person pronouns.

- word_length:

  Mean word length in letters.

## Source

`data-raw/web_registers.R`

## Details

True model: each text has scores on three dimensions, involved (vs
informational) production, narrative and informational elaboration. They
are the register mean plus normal noise with SD 0.6 (involved,
elaborated) or 0.9 (narrative):

    register              texts  involved  narrative  elaborated
    forum discussion         90       1.3        0.0        -1.0
    personal blog            90       1.1        0.5        -0.9
    news report             110      -0.2        0.5         0.3
    encyclopedia article     60      -1.1        0.0         0.5
    research article         70      -1.0       -0.5         1.8
    recipe                   60       0.0       -1.0        -1.6

Each feature has a latent score: the dimension scores times its
loadings, plus normal noise with variance 1 minus the sum of its squared
loadings. Loadings are 0.75 (`contractions`, `first_person`), 0.7
(`second_person`), 0.6 (`negation`), 0.55 (`adverbs`), 0.5
(`private_verbs`), -0.55 (`prepositions`) and -0.8 (`nouns`) on the
involved dimension; 0.85 (`past_tense`), 0.55 (`third_person`) and 0.5
(`perfect_aspect`) on the narrative dimension; 0.75 (`nominalisations`),
0.5 (`attributive_adjectives`) and 0.45 (`conjuncts`) on informational
elaboration. `present_tense` loads 0.7 on involved and -0.4 on
narrative; `word_length` loads -0.45 on involved and 0.7 on elaboration.
The rate per 1,000 words is `base_rate * exp(spread * latent)`, with the
base rates and spreads in `data-raw/web_registers.R`, and the number of
occurrences in a text is Poisson with mean `rate * words / 1000`; the
columns give occurrences per 1,000 words. `word_length` is
`4.6 + 0.32 * latent`. Text length is log-normal with a median of 900
words, limited to 400 to 4,000. Because of the log scale and the Poisson
counts, a factor analysis of the rates gives smaller loadings than
these; log rates come closer. Since `pronouns` is the sum of three other
columns, the correlation matrix of all features is singular.

The base rates and spreads were chosen so that the register means
approach those of the same six registers in the data of Ehret and
Taboada (2021), whose texts come from the Corpus of Online Registers of
English (Egbert et al., 2015). Most simulated register means are within
25% of theirs. The largest differences are in pronouns and contractions,
most of all in recipes, which in their data use more first and second
person pronouns than three dimensions can reproduce. The differences
between registers on the dimensions are larger than in their data, so
that the registers separate more clearly.

## References

Biber, D. (1988). *Variation across Speech and Writing*. Cambridge:
Cambridge University Press.
[doi:10.1017/CBO9780511621024](https://doi.org/10.1017/CBO9780511621024)

Egbert, J., Biber, D. & Davies, M. (2015). Developing a bottom-up,
user-based method of web register classification. *Journal of the
Association for Information Science and Technology*, 66(9), 1817-1831.
[doi:10.1002/asi.23308](https://doi.org/10.1002/asi.23308)

Ehret, K. & Taboada, M. (2021). Characterising online news comments: A
multi-dimensional cruise through online registers. *Frontiers in
Artificial Intelligence*, 4, 643770.
[doi:10.3389/frai.2021.643770](https://doi.org/10.3389/frai.2021.643770)

Ehret, K. & Taboada, M. (2021). *MDA-OnlineRegisters* (version 1.0)
\[Data set and code\]. Zenodo.
[doi:10.5281/zenodo.4885180](https://doi.org/10.5281/zenodo.4885180)

## Examples

``` r
features <- setdiff(names(web_registers), c("text", "register", "words", "pronouns"))
fa <- factanal(web_registers[, features], factors = 3, rotation = "promax")
print(fa$loadings, cutoff = 0.3)
#> 
#> Loadings:
#>                        Factor1 Factor2 Factor3
#> adverbs                 0.531                 
#> attributive_adjectives          0.339         
#> conjuncts                       0.503         
#> contractions            0.530                 
#> first_person            0.621                 
#> negation                0.451                 
#> nominalisations                 0.747         
#> nouns                  -0.618                 
#> past_tense                              0.806 
#> perfect_aspect                          0.312 
#> prepositions           -0.456                 
#> present_tense           0.626                 
#> private_verbs                                 
#> second_person           0.518                 
#> third_person                            0.333 
#> word_length            -0.452   0.583         
#> 
#>                Factor1 Factor2 Factor3
#> SS loadings      2.754   1.296   0.967
#> Proportion Var   0.172   0.081   0.060
#> Cumulative Var   0.172   0.253   0.314
aggregate(cbind(contractions, past_tense, nominalisations) ~ register,
          data = web_registers, FUN = median)
#>               register contractions past_tense nominalisations
#> 1     forum discussion         9.55      19.95            8.80
#> 2        personal blog         9.00      29.20            8.60
#> 3          news report         2.70      28.75           15.70
#> 4 encyclopedia article         1.15      22.05           17.90
#> 5     research article         1.05      18.55           42.10
#> 6               recipe         4.45      16.05            6.95
round(min(eigen(cor(web_registers[, c(features, "pronouns")]))$values), 10)
#> [1] 0
```
