# Word order in a typological sample

400 invented languages from 100 invented families in six invented areas.
Languages mostly inherit their family's word order, so languages from
the same family are similar. Adposition order and case marking correlate
with word order, in the spirit of Greenberg's universals. Family sizes
are skewed: a few large families and many small ones.

## Usage

``` r
word_order
```

## Format

A tibble with 400 rows and 8 columns:

- language:

  Language ID, `L001` to `L400`.

- family:

  `"Family 001"` to `"Family 100"`.

- area:

  `"Area A"` to `"Area F"`.

- order:

  Basic word order: `"SOV"`, `"SVO"`, `"VSO"` or `"no dominant order"`.

- adpositions:

  `"postpositions"` or `"prepositions"`.

- case_marking:

  Whether nouns are case-marked, `"no"` or `"yes"`.

- consonants:

  Size of the consonant inventory.

- vowels:

  Size of the vowel inventory.

## Source

`data-raw/word_order.R`

## Details

True model: each family draws a word order from its area's preferences;
each language keeps it with probability 0.8 and otherwise draws again.
Postpositions have probability 0.92 in SOV, 0.5 in no-dominant-order and
0.12 in VO languages. Case marking has probability 0.7 in SOV and 0.3 in
other languages. Consonant inventories are 6 plus a negative binomial
count (mean 16, by-family variation); vowel inventories are 3 plus a
Poisson count (mean 2.5). Overall, about 44% of the languages are SOV,
36% SVO, 6% VSO and 14% have no dominant order, close to the world-wide
proportions in WALS (feature 81A). All language, family and area names
and all figures are invented.

## References

Dryer, M. S. (2013). Order of subject, object and verb. In M. S. Dryer &
M. Haspelmath (eds.), *WALS Online*. Leipzig: Max Planck Institute for
Evolutionary Anthropology. <https://wals.info/chapter/81>

Greenberg, J. H. (1963). Some universals of grammar with particular
reference to the order of meaningful elements. In J. H. Greenberg (ed.),
*Universals of Language* (pp. 58-90). Cambridge, MA: MIT Press.

## Examples

``` r
table(word_order$order, word_order$adpositions)
#>                    
#>                     postpositions prepositions
#>   SOV                         158           17
#>   SVO                          20          125
#>   VSO                           1           23
#>   no dominant order            26           30
```
