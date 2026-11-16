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

  Role of the word in the sentence, with levels in sentence order:
  determiner (`"det"`) and noun of the main clause, relative pronoun,
  then determiner, noun, participle and auxiliary of the relative clause
  (`"rc_det"` to `"rc_auxiliary"`), main verb, three spillover words and
  the final word. `levels(german_relatives$region)` gives the codes.

- length:

  Word length in letters.

- rt:

  Reading time in ms.

## Source

`data-raw/german_relatives.R`

## Details

True model:

    log(rt) = 5.85 + p0 + i0 + 0.012 * (length - 5) - 0.008 * position
      + cost * object + e

The object-relative cost is 0.01 to 0.03 in the relative clause, 0.04 on
the participle, 0.05 on the auxiliary and the main verb and 0.02 on the
next word, with by-participant variation (SD 0.03). By-participant
intercepts `p0` have SD 0.2 and by-item intercepts `i0` SD 0.04;
residual SD 0.2. The cost on the auxiliary matches the neutral condition
of Schriefers, Friederici and Kühn (1995, Experiment 1: 1350 against
1424 ms). Their relative clauses were ambiguous until the auxiliary and
had no main clause verb after them, so the cost on the other words and
all data are simulated.

## References

Schriefers, H., Friederici, A. D. & Kühn, K. (1995). The processing of
locally ambiguous relative clauses in German. *Journal of Memory and
Language*, 34(4), 499-520.
[doi:10.1006/jmla.1995.1023](https://doi.org/10.1006/jmla.1995.1023)

## Examples

``` r
round(tapply(german_relatives$rt, german_relatives[c("region", "condition")], mean))
#>                condition
#> region          subject object
#>   det               349    353
#>   noun              362    359
#>   rel_pronoun       344    354
#>   rc_det            344    351
#>   rc_noun           356    363
#>   rc_participle     354    368
#>   rc_auxiliary      332    355
#>   main_verb         345    368
#>   spillover_1       340    354
#>   spillover_2       341    336
#>   spillover_3       340    335
#>   final             338    341
if (requireNamespace("lme4", quietly = TRUE)) {
  mv <- subset(german_relatives, region == "main_verb")
  m <- lme4::lmer(log(rt) ~ condition + (1 | participant) + (1 | item), data = mv)
  lme4::fixef(m)
}
#>     (Intercept) conditionobject 
#>       5.8027047       0.0651166 
```
