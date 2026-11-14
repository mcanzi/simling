# Forms of address: du or Sie

Whether German speakers address a stranger with informal *du* or formal
*Sie*, by speaker age group and setting. 30 speakers per cell, one
observation each. For contingency tables and chi-squared tests.

## Usage

``` r
address_forms
```

## Format

A tibble with 180 rows and 4 columns:

- speaker:

  Speaker ID, `S001` to `S180`.

- age_group:

  `"under 30"` or `"over 50"`.

- setting:

  `"university"`, `"office"` or `"shop"`.

- form:

  `"Sie"` or `"du"`.

## Source

`data-raw/address_forms.R`

## Details

True model: the probability of *du* is 0.85 (university), 0.35 (shop)
and 0.45 (office) for speakers under 30, and 0.40, 0.08 and 0.15 for
speakers over 50. These probabilities are simulated. Strangers are by
default addressed with *Sie*, and variation in address depends more on
age than on region (Kretzenbacher 2011). In a 2021 survey reported by
Kretzenbacher and Hensel-Börner (2024), 44% of customers aged 18 to 29
liked being addressed with *du* in shops, against 23% of those aged 60
and over.

## References

Kretzenbacher, H. L. (2011). Perceptions of national and regional
standards of addressing in Germany and Austria. *Pragmatics*, 21(1),
69-83.
[doi:10.1075/prag.21.1.04kre](https://doi.org/10.1075/prag.21.1.04kre)

Kretzenbacher, H. L. & Hensel-Börner, S. (2024). Pronominal address in
German sales talk: Effects on the perception of the salesperson.
*Languages*, 9(10), 316.
[doi:10.3390/languages9100316](https://doi.org/10.3390/languages9100316)

## Examples

``` r
tab <- xtabs(~ setting + form + age_group, data = address_forms)
round(prop.table(tab, c(1, 3))[, "du", ], 2)
#>             age_group
#> setting      under 30 over 50
#>   university     0.83    0.47
#>   office         0.47    0.17
#>   shop           0.33    0.10
chisq.test(tab[, , "under 30"])
#> 
#>  Pearson's Chi-squared test
#> 
#> data:  tab[, , "under 30"]
#> X-squared = 16.217, df = 2, p-value = 0.000301
#> 
chisq.test(tab[, , "over 50"])
#> 
#>  Pearson's Chi-squared test
#> 
#> data:  tab[, , "over 50"]
#> X-squared = 12.393, df = 2, p-value = 0.002036
#> 
```
