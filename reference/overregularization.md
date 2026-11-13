# Past-tense overregularization

Overregularization errors (*goed*, *holded*) out of all irregular
past-tense contexts, for 24 children recorded every six months from 30
to 60 months. The simulation follows the account of Marcus et al.
(1992): errors are rare, their rate does not change with age, and
children differ in how often they make them. Maratsos (2000) disputed
the low rates, arguing that averages over all verbs hide much higher
rates for verbs a child uses rarely. These data have no verb-level
information. For binomial models of errors out of attempts and for
testing an effect that is absent.

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

True model, in log-odds: `-3.2`, with by-child intercepts of SD 0.5, so
about 4% of attempts are errors. Age has no effect. Children attempt
more irregular past tenses as they get older.

## References

Marcus, G. F., Pinker, S., Ullman, M., Hollander, M., Rosen, T. J. & Xu,
F. (1992). Overregularization in language acquisition. *Monographs of
the Society for Research in Child Development*, 57(4).
[doi:10.2307/1166115](https://doi.org/10.2307/1166115)

Maratsos, M. (2000). More overregularizations after all: New data and
discussion on Marcus, Pinker, Ullman, Hollander, Rosen & Xu. *Journal of
Child Language*, 27(1), 183-212.

## Examples

``` r
sum(overregularization$errors) / sum(overregularization$attempts)
#> [1] 0.04491781
aggregate(cbind(errors, attempts) ~ age, data = overregularization, FUN = sum)
#>   age errors attempts
#> 1  30     19      370
#> 2  36     22      503
#> 3  42     25      648
#> 4  48     36      796
#> 5  54     41      933
#> 6  60     51     1069
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::glmer(cbind(errors, attempts - errors) ~ I((age - 45) / 12) + (1 | child),
                   data = overregularization, family = binomial)
  summary(m)$coefficients
}
#>                     Estimate Std. Error     z value      Pr(>|z|)
#> (Intercept)      -3.11136919 0.10698042 -29.0835399 5.798139e-186
#> I((age - 45)/12)  0.01244421 0.09174487   0.1356393  8.921064e-01
```
