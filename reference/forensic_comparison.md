# Forensic voice comparison scores

Scores from two systems comparing pairs of recordings of 80 male
speakers of German: an automatic speaker recognition system and a
formant-based system. Every speaker is compared with himself
(same-speaker comparisons, recordings from two sessions) and with every
other speaker (different-speaker comparisons). Higher scores mean more
similar voices. For calibrating scores into likelihood ratios, computing
Cllr and comparing or fusing systems.

## Usage

``` r
forensic_comparison
```

## Format

A tibble with 3240 rows and 6 columns:

- comparison:

  Comparison ID, `C0001` to `C3240`.

- speaker_a, speaker_b:

  The two speakers, `S01` to `S80`.

- same_speaker:

  `"no"` or `"yes"`.

- score_auto:

  Score of the automatic system.

- score_formant:

  Score of the formant-based system.

## Source

`data-raw/forensic_comparison.R`

## Details

True model: automatic scores are normal with mean 2.5 (SD 1) for
same-speaker and -1 (SD 1.3) for different-speaker comparisons; formant
scores have means 1 (SD 1) and -0.5 (SD 1.1). Each speaker shifts his
scores by a speaker effect (SD 0.4 automatic, 0.3 formant; the mean of
the two speakers in different-speaker comparisons). The automatic system
discriminates much better: after logistic-regression calibration its
Cllr is about 0.25, against about 0.7 for the formant system.

## References

Brümmer, N. & du Preez, J. (2006). Application-independent evaluation of
speaker detection. *Computer Speech and Language*, 20(2-3), 230-275.
[doi:10.1016/j.csl.2005.08.001](https://doi.org/10.1016/j.csl.2005.08.001)

## Examples

``` r
head(forensic_comparison)
#> # A tibble: 6 × 6
#>   comparison speaker_a speaker_b same_speaker score_auto score_formant
#>   <fct>      <fct>     <fct>     <fct>             <dbl>         <dbl>
#> 1 C0001      S01       S01       yes               3.42          2.38 
#> 2 C0002      S01       S02       no               -0.201         0.214
#> 3 C0003      S01       S03       no               -0.523        -0.176
#> 4 C0004      S01       S04       no               -1.01         -0.047
#> 5 C0005      S01       S05       no               -3.63          1.07 
#> 6 C0006      S01       S06       no               -0.704         1.48 
```
