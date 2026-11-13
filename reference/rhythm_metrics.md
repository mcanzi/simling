# Rhythm metrics in eight languages

%V, ΔC and VarcoV for 5 sentences from each of 10 speakers of 8
languages. Languages traditionally called stress-timed (English, German,
Dutch) have lower %V and higher ΔC and VarcoV, syllable-timed languages
(Spanish, Italian) the reverse, and Japanese the highest %V. European
Portuguese, with its reduced and deleted vowels, sits closer to the
stress-timed languages than Brazilian Portuguese. ΔC falls with speech
rate; VarcoV is rate-normalised. For classifying languages by their
rhythm metrics.

## Usage

``` r
rhythm_metrics
```

## Format

A tibble with 400 rows and 7 columns:

- language:

  `"English"`, `"German"`, `"Dutch"`, `"European Portuguese"`,
  `"Brazilian Portuguese"`, `"Spanish"`, `"Italian"` or `"Japanese"`.

- speaker:

  Speaker ID, e.g. `Eng_01`.

- sentence:

  `sent1` to `sent5`.

- rate:

  Speech rate in syllables per second.

- percent_v:

  Percentage of the sentence that is vocalic.

- delta_c:

  Standard deviation of consonantal intervals in ms.

- varco_v:

  Coefficient of variation of vocalic intervals.

## Source

`data-raw/rhythm_metrics.R`

## Details

True model: language means for %V, ΔC and VarcoV are 41, 54, 65
(English), 42, 52, 62 (German), 42, 53, 63 (Dutch), 43, 50, 58 (European
Portuguese), 46, 45, 52 (Brazilian Portuguese), 46, 46, 48 (Spanish),
47, 47, 52 (Italian) and 53, 36, 45 (Japanese). These values follow the
ordering reported in the literature and were chosen for the simulation.
ΔC falls by 6 ms per syllable per second. By-speaker variation: SD 1.2
for %V, 3 ms for ΔC, 0.4 syll/s for rate.

## References

Ramus, F., Nespor, M. & Mehler, J. (1999). Correlates of linguistic
rhythm in the speech signal. *Cognition*, 73(3), 265-292.
[doi:10.1016/S0010-0277(99)00058-X](https://doi.org/10.1016/S0010-0277%2899%2900058-X)

White, L. & Mattys, S. L. (2007). Calibrating rhythm: First language and
second language studies. *Journal of Phonetics*, 35(4), 501-522.
[doi:10.1016/j.wocn.2007.02.003](https://doi.org/10.1016/j.wocn.2007.02.003)

Frota, S. & Vigário, M. (2001). On the correlates of rhythmic
distinctions: The European/Brazilian Portuguese case. *Probus*, 13(2),
247-275.
[doi:10.1515/prbs.2001.005](https://doi.org/10.1515/prbs.2001.005)

## Examples

``` r
head(rhythm_metrics)
#> # A tibble: 6 × 7
#>   language             speaker sentence  rate percent_v delta_c varco_v
#>   <fct>                <fct>   <fct>    <dbl>     <dbl>   <dbl>   <dbl>
#> 1 Brazilian Portuguese Bra_01  sent1     5.52      45.6    46.5    50.6
#> 2 Brazilian Portuguese Bra_01  sent2     5.41      47.4    39.9    55  
#> 3 Brazilian Portuguese Bra_01  sent3     5.47      47.2    41.7    60.4
#> 4 Brazilian Portuguese Bra_01  sent4     4.64      44      48      52.5
#> 5 Brazilian Portuguese Bra_01  sent5     5.4       47.5    39.4    56.6
#> 6 Brazilian Portuguese Bra_02  sent1     5.66      46.9    40.3    46.1
```
