# Past-tense overregularization

Overregularization errors (*goed*, *holded*) out of all irregular
past-tense contexts, for 24 children recorded every six months from 30
to 60 months. Errors are rare, and their rate stays about the same
across ages while children differ in how often they make them. For
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

True model, in log-odds: `-3.2`, with by-child intercepts of SD 0.5, so
about 4% of attempts are errors. Age has no effect. Children attempt
more irregular past tenses as they get older.

## References

Marcus, G. F., Pinker, S., Ullman, M., Hollander, M., Rosen, T. J. & Xu,
F. (1992). Overregularization in language acquisition. *Monographs of
the Society for Research in Child Development*, 57(4).

## Examples

``` r
head(overregularization)
#> # A tibble: 6 × 4
#>   child   age attempts errors
#>   <fct> <int>    <int>  <int>
#> 1 C01      30       17      0
#> 2 C01      36       26      4
#> 3 C01      42       30      1
#> 4 C01      48       42      0
#> 5 C01      54       33      2
#> 6 C01      60       44      2
```
