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
speakers over 50.

## Examples

``` r
table(address_forms$age_group, address_forms$form)
#>           
#>            Sie du
#>   under 30  41 49
#>   over 50   68 22
```
