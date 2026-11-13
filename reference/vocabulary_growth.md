# Vocabulary growth in toddlers

Productive vocabulary on a 680-word parental checklist, every two months
from 16 to 30 months, for 80 children. Growth is S-shaped, and children
who hear more speech start their vocabulary spurt earlier. About 10% of
sessions are missing.

## Usage

``` r
vocabulary_growth
```

## Format

A tibble with 572 rows and 4 columns:

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
`plogis((age - mid) / 2.8)`, where `mid = 25.2 - 2 * log2(input / 1200)`
plus a by-child deviation (SD 2.6 months), and session-level noise on
the logit scale (SD 0.15). Doubling the input moves the spurt 2 months
earlier. Children average about 300 words at 24 months.

## References

Fenson, L., Marchman, V. A., Thal, D. J., Dale, P. S., Reznick, J. S. &
Bates, E. (2007). *MacArthur-Bates Communicative Development
Inventories: User's guide and technical manual* (2nd ed.). Baltimore:
Brookes.

Frank, M. C., Braginsky, M., Yurovsky, D. & Marchman, V. A. (2017).
Wordbank: An open repository for developmental vocabulary data. *Journal
of Child Language*, 44(3), 677-694.
[doi:10.1017/S0305000916000209](https://doi.org/10.1017/S0305000916000209)

## Examples

``` r
head(vocabulary_growth)
#> # A tibble: 6 × 4
#>   child input   age vocabulary
#>   <fct> <int> <int>      <int>
#> 1 C01     861    16         17
#> 2 C01     861    18         45
#> 3 C01     861    20         66
#> 4 C01     861    22        147
#> 5 C01     861    24        254
#> 6 C01     861    28        454
```
