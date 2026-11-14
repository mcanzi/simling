# Two coders' GToBI labels

Two trained coders label the same 456 words from 40 German utterances
with GToBI pitch accents and phrase boundaries: 20 utterances of read
and 20 of spontaneous speech. Coders agree on whether a word is accented
for about 86% of words and on the exact accent label for about 71%,
close to the agreement Grice et al. (1996) report for GToBI. In this
simulation, accent agreement is lower in spontaneous speech. For
percentage agreement and Cohen's kappa.

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

Grice, M., Reyelt, M., Benzmüller, R., Mayer, J. & Batliner, A. (1996).
Consistency in transcription and labelling of German intonation with
GToBI. In *Proceedings of the 4th International Conference on Spoken
Language Processing (ICSLP 96)* (pp. 1716-1719). Philadelphia.
[doi:10.1109/ICSLP.1996.607958](https://doi.org/10.1109/ICSLP.1996.607958)

Grice, M., Baumann, S. & Benzmüller, R. (2005). German intonation in
autosegmental-metrical phonology. In S.-A. Jun (ed.), *Prosodic
Typology: The Phonology of Intonation and Phrasing* (pp. 55-83). Oxford:
Oxford University Press.
[doi:10.1093/acprof:oso/9780199249633.003.0003](https://doi.org/10.1093/acprof%3Aoso/9780199249633.003.0003)

Pitrelli, J. F., Beckman, M. E. & Hirschberg, J. (1994). Evaluation of
prosodic transcription labeling reliability in the ToBI framework.
*Proceedings of ICSLP 1994*.
<https://www.isca-archive.org/icslp_1994/pitrelli94_icslp.html>

## Examples

``` r
kappa <- function(a, b) {
  tab <- table(a, b)
  po <- sum(diag(tab)) / sum(tab)
  pe <- sum(rowSums(tab) * colSums(tab)) / sum(tab)^2
  c(agreement = po, kappa = (po - pe) / (1 - pe))
}
with(tobi_agreement, kappa(accent_1 != "none", accent_2 != "none"))
#> agreement     kappa 
#> 0.8640351 0.7273148 
both <- subset(tobi_agreement, accent_1 != "none" & accent_2 != "none")
kappa(both$accent_1, both$accent_2)
#> agreement     kappa 
#> 0.6666667 0.5754880 
sapply(split(tobi_agreement, tobi_agreement$style),
       function(d) kappa(d$accent_1 != "none", d$accent_2 != "none"))
#>                read spontaneous
#> agreement 0.8864629   0.8414097
#> kappa     0.7706118   0.6833785
```
