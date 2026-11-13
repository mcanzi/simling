# Relativizer choice: that, which or zero

The relativizer in restrictive relative clauses (*the book that / which
/ 0 I read*), 10 tokens from each of 240 texts, half spoken, half
written. A three-way outcome; zero is impossible in subject relatives.

## Usage

``` r
relativizers
```

## Format

A tibble with 2400 rows and 6 columns:

- text:

  Text ID, `T001` to `T240`.

- mode:

  `"spoken"` or `"written"`.

- token:

  Token number within the text, 1 to 10.

- role:

  Role of the relativised noun in the clause, `"subject"` or `"object"`.

- antecedent_length:

  Length of the antecedent noun phrase in words.

- relativizer:

  `"that"`, `"which"` or `"zero"`.

## Source

`data-raw/relativizers.R`

## Details

True model: multinomial logit with "that" as reference. Which:
`-1.6 + 1.4 * written + 0.25 * (antecedent_length - 2)`. Zero (object
relatives only): `0.6 - 1.2 * written - 0.4 * (antecedent_length - 2)`.
By-text intercepts with SD 0.5 for each.

## Examples

``` r
table(relativizers$role, relativizers$relativizer)
#>          
#>           that which zero
#>   subject  869   463    0
#>   object   394   249  425
```
