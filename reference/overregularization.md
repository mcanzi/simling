# Past-tense overregularization

Overregularization errors (*goed*, *holded*) out of all irregular
past-tense contexts, for 24 children recorded every six months from 30
to 60 months. The simulation follows the account of Marcus et al.
(1992): errors are rare, their rate does not change with age, and
children differ in how often they make them. Maratsos (2000) disputed
the low rates, arguing that averages over all verbs hide much higher
rates for verbs a child uses rarely and periods in which a child
overregularizes often. These data have no verb-level information. For
binomial models of errors out of attempts and for testing an effect that
is absent.

## Usage

``` r
overregularization
```

## Format

A tibble with 144 rows and 4 columns:

- child:

  Child ID, `C01` to `C24`.

- age:

  Age in months.

- attempts:

  Irregular past-tense contexts in the recording.

- errors:

  Overregularizations among them.

## Source

`data-raw/overregularization.R`

## Details

True model, in log-odds: `-3.66`, with by-child intercepts of SD 0.9, so
the median child makes errors in 2.5% of attempts and a few children in
many more. Age has no effect. Children attempt more irregular past
tenses as they get older. Marcus et al. (1992) report a median rate of
2.5% and a mean of 4.2% across 25 children, with a roughly constant rate
from age 2 into the school years. Maratsos (2000) showed that pooling
all tokens gives most weight to frequent verbs, whose rates are lowest.
The children and counts are simulated.

## References

Marcus, G. F., Pinker, S., Ullman, M., Hollander, M., Rosen, T. J. & Xu,
F. (1992). Overregularization in language acquisition. *Monographs of
the Society for Research in Child Development*, 57(4).
[doi:10.2307/1166115](https://doi.org/10.2307/1166115)

Maratsos, M. (2000). More overregularizations after all: New data and
discussion on Marcus, Pinker, Ullman, Hollander, Rosen & Xu. *Journal of
Child Language*, 27(1), 183-212.
[doi:10.1017/S0305000999004067](https://doi.org/10.1017/S0305000999004067)

## Examples

``` r
sum(overregularization$errors) / sum(overregularization$attempts)
#> [1] 0.03727715
aggregate(cbind(errors, attempts) ~ age, data = overregularization, FUN = sum)
#>   age errors attempts
#> 1  30     16      370
#> 2  36     18      503
#> 3  42     18      648
#> 4  48     31      796
#> 5  54     35      933
#> 6  60     43     1069
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::glmer(cbind(errors, attempts - errors) ~ I((age - 45) / 12) + (1 | child),
                   data = overregularization, family = binomial)
  summary(m)$coefficients
}
#>                     Estimate Std. Error     z value     Pr(>|z|)
#> (Intercept)      -3.48754528  0.1772913 -19.6712757 3.800969e-86
#> I((age - 45)/12)  0.03074469  0.1011252   0.3040259 7.611082e-01
```
