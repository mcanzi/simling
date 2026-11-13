# Two coders' GToBI labels

Two trained coders label the same 456 words from 40 German utterances
with GToBI pitch accents and phrase boundaries: 20 utterances of read
and 20 of spontaneous speech. Coders agree on whether a word is accented
about 85-90% of the time and on the type of accent about 60-70% of the
time, close to published benchmarks for ToBI. Accent agreement is lower
in spontaneous speech. For percentage agreement and Cohen's kappa.

## Usage

``` r
tobi_agreement
```

## Format

A tibble with 456 rows and 8 columns:

- utterance:

  Utterance ID, `U01` to `U40`.

- style:

  `"read"` or `"spontaneous"`.

- word:

  Word ID (`utterance_wNN`).

- position:

  Position of the word in the utterance.

- accent_1, accent_2:

  Pitch accent labelled by coder 1 and coder 2: `"none"`, `"H*"`,
  `"L+H*"`, `"L*"`, `"L*+H"`, `"H+!H*"` or `"H+L*"`.

- boundary_1, boundary_2:

  Boundary after the word labelled by coder 1 and coder 2: `"none"`,
  `"intermediate"` or `"intonation phrase"`.

## Source

`data-raw/tobi_agreement.R`

## Details

True model: each word has a true accent (55% none) and boundary (always
an intonation phrase boundary at the end of the utterance, 12%
intermediate boundaries elsewhere). Each coder gives the true label with
probability `plogis(base - difficulty)`, where `base` is 2.6 for
unaccented and 1.6 for accented words (0.2 lower for coder 2) and the
word's difficulty has mean 0 in read and 0.5 in spontaneous speech (SD
0.5). Otherwise the coder picks a similar label (e.g. `"L+H*"` for
`"H*"`).

## References

Grice, M., Baumann, S. & Benzmüller, R. (2005). German intonation in
autosegmental-metrical phonology. In S.-A. Jun (ed.), *Prosodic
Typology: The Phonology of Intonation and Phrasing* (pp. 55-83). Oxford:
Oxford University Press.

Pitrelli, J. F., Beckman, M. E. & Hirschberg, J. (1994). Evaluation of
prosodic transcription labeling reliability in the ToBI framework.
*Proceedings of ICSLP 1994*.

## Examples

``` r
table(tobi_agreement$accent_1, tobi_agreement$accent_2)
#>        
#>         none  H* L+H*  L* L*+H H+!H* H+L*
#>   none   184  19    1  15    1     0    0
#>   H*      12  48    3   0    0     8    0
#>   L+H*     1  12   34   1   12     0    0
#>   L*      12   0    0  29    4     0    2
#>   L*+H     0   2    8   6   14     0    0
#>   H+!H*    1   8    0   0    0    11    2
#>   H+L*     0   1    0   0    0     1    4
```
