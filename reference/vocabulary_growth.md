# Vocabulary growth in toddlers

Productive vocabulary on a 680-word parental checklist, every two months
from 16 to 30 months, for 80 children. Each child's vocabulary follows
an S-shaped (logistic) curve, and children who hear more speech reach
its steep middle part earlier. Whether real vocabulary growth has a
distinct spurt is debated. Ganger and Brent (2004) modelled the rate of
word learning and found that a logistic curve, which implies a spurt,
fitted better than a quadratic one for only 5 of 38 children. About 10%
of sessions are missing.

## Usage

``` r
vocabulary_growth
```

## Format

A tibble with 573 rows and 4 columns:

- child:

  Child ID, `C01` to `C80`.

- input:

  Adult words per hour heard at home (one value per child).

- age:

  Age in months.

- vocabulary:

  Number of words produced, out of 680.

## Source

`data-raw/vocabulary_growth.R`

## Details

True model: `vocabulary` is binomial out of 680 with probability
`plogis((age - mid) / 3.2)`, where

    mid = 25.2 - 2 * log2(input / 1200)

plus a by-child deviation (SD 2.6 months), and session-level noise on
the logit scale (SD 0.15). Doubling the input moves the midpoint of the
curve 2 months earlier; this effect is simulated. The median curve
follows the CDI norms in Fenson et al. (1994): median vocabulary of 44
words at 16 months, 225 at 23 months and 573 at 30 months. They also
note that a logistic function fits the shape of vocabulary growth.

## References

Fenson, L., Dale, P. S., Reznick, J. S., Bates, E., Thal, D. J. &
Pethick, S. J. (1994). Variability in early communicative development.
*Monographs of the Society for Research in Child Development*, 59(5),
1-185. [doi:10.2307/1166093](https://doi.org/10.2307/1166093)

Fenson, L., Marchman, V. A., Thal, D. J., Dale, P. S., Reznick, J. S. &
Bates, E. (2007). *MacArthur-Bates Communicative Development
Inventories: User's guide and technical manual* (2nd ed.). Baltimore:
Brookes.

Frank, M. C., Braginsky, M., Yurovsky, D. & Marchman, V. A. (2017).
Wordbank: An open repository for developmental vocabulary data. *Journal
of Child Language*, 44(3), 677-694.
[doi:10.1017/S0305000916000209](https://doi.org/10.1017/S0305000916000209)

Ganger, J. & Brent, M. R. (2004). Reexamining the vocabulary spurt.
*Developmental Psychology*, 40(4), 621-632.
[doi:10.1037/0012-1649.40.4.621](https://doi.org/10.1037/0012-1649.40.4.621)

## Examples

``` r
plot(vocabulary ~ age, data = vocabulary_growth, col = grey(0.4))

if (requireNamespace("lme4", quietly = TRUE)) {
  vocabulary_growth$session <- seq_len(nrow(vocabulary_growth))
  m <- lme4::glmer(cbind(vocabulary, 680 - vocabulary) ~ I(age - 24) +
                     I(log2(input / 1200)) + (1 | child) + (1 | session),
                   data = vocabulary_growth, family = binomial)
  b <- lme4::fixef(m)
  c(midpoint_at_1200_words = 24 - b[[1]] / b[[2]], months_per_doubling = b[[3]] / b[[2]])
}
#> midpoint_at_1200_words    months_per_doubling 
#>              24.624519               1.697952 
```
