# Self-paced reading of German relative clauses

48 participants read sentences word by word, such as *Der Lehrer, der
den Schüler gesehen hat, lachte laut über den Witz* (subject relative)
and *Der Lehrer, den der Schüler gesehen hat, ...* (object relative).
Object relatives slow readers down at the end of the relative clause and
on the main verb. 24 items, two counterbalanced lists, 12 words per
sentence.

## Usage

``` r
german_relatives
```

## Format

A tibble with 13824 rows and 8 columns:

- participant:

  Participant ID, `P01` to `P48`.

- list:

  Counterbalancing list, 1 or 2.

- item:

  Item ID, `i01` to `i24`.

- condition:

  `"subject"` or `"object"` relative clause.

- position:

  Word position in the sentence, 1 to 12.

- region:

  Role of the word: `"det"`, `"noun"`, `"rel_pronoun"`, `"rc_det"`,
  `"rc_noun"`, `"rc_participle"`, `"rc_auxiliary"`, `"main_verb"`,
  `"spillover_1"` to `"spillover_3"`, `"final"`.

- length:

  Word length in letters.

- rt:

  Reading time in ms.

## Source

`data-raw/german_relatives.R`

## Details

True model:
`log(rt) = 5.85 + p0 + i0 + 0.012 * (length - 5) - 0.008 * position + cost * object + e`.
The object-relative cost is 0.01 to 0.03 in the relative clause, 0.06 on
the participle, 0.08 on the auxiliary, 0.05 on the main verb and 0.02 on
the next word, with by-participant variation (SD 0.03). By-participant
intercepts `p0` have SD 0.2 and by-item intercepts `i0` SD 0.04;
residual SD 0.2.

## Examples

``` r
head(german_relatives)
#> # A tibble: 6 × 8
#>   participant  list item  condition position region        length    rt
#>   <fct>       <int> <fct> <fct>        <int> <fct>          <int> <dbl>
#> 1 P01             1 i01   subject          1 det                3   245
#> 2 P01             1 i01   subject          2 noun               6   322
#> 3 P01             1 i01   subject          3 rel_pronoun        3   270
#> 4 P01             1 i01   subject          4 rc_det             3   277
#> 5 P01             1 i01   subject          5 rc_noun            8   247
#> 6 P01             1 i01   subject          6 rc_participle      6   255
```
