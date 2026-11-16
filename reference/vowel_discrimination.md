# Same-different discrimination of English vowels

An AX discrimination task: listeners hear two vowels from different
talkers and say whether they are the same or different. 20 native
listeners of English and 30 L2 learners each hear six vowel contrasts,
with 8 same and 8 different trials per contrast. Native listeners tell
all contrasts apart; the learners only some of them. For signal
detection theory: hits, false alarms, d' and response bias.

## Usage

``` r
vowel_discrimination
```

## Format

A tibble with 4800 rows and 7 columns:

- listener:

  Listener ID, `E01` to `E20` (L1) and `G01` to `G30` (L2).

- group:

  `"L1"` or `"L2"`.

- trial:

  Trial number in the listener's random order, 1 to 96.

- contrast:

  Vowel contrast, named by lexical sets: `"FLEECE-KIT"`,
  `"FLEECE-DRESS"`, `"START-STRUT"`, `"TRAP-START"`, `"THOUGHT-LOT"` or
  `"GOOSE-FOOT"`.

- pair:

  Order of the two vowels: `"AA"`, `"BB"`, `"AB"` or `"BA"`.

- trial_type:

  `"same"` (AA, BB) or `"different"` (AB, BA).

- response:

  `"same"` or `"different"`.

## Source

`data-raw/vowel_discrimination.R`

## Details

True model: the differencing model for same-different designs (Macmillan
and Creelman 2005). Each vowel gives a normal observation with SD 1; the
two observations differ in mean by `d` on different trials and not at
all on same trials. The listener says "different" when the absolute
difference between them exceeds their criterion (mean 2, SD 0.35 across
listeners). `d` is 3.9 to 4.6 for native listeners and 0.7 to 2.6 for
learners, multiplied by a listener factor `exp(skill)` with `skill`
normal, SD 0.2. With 8 trials per cell, hit rates of 1 and false-alarm
rates of 0 are common, so the example adds 0.5 to each count and 1 to
each number of trials; this correction pulls the native listeners' d'
below their true values. The design follows the AX task of Georgiou and
Giannakou (2024), whose learners discriminated FLEECE-DRESS and
THOUGHT-LOT above chance and the other contrasts not; the listeners, d'
values and responses here are simulated.

## References

Georgiou, G. P. & Giannakou, A. (2024). Discrimination of second
language vowel contrasts and the role of phonological short-term memory
and nonverbal intelligence. *Journal of Psycholinguistic Research*,
53(1), 9.
[doi:10.1007/s10936-024-10038-z](https://doi.org/10.1007/s10936-024-10038-z)

Macmillan, N. A. & Creelman, C. D. (2005). *Detection Theory: A User's
Guide* (2nd ed.). Mahwah, NJ: Erlbaum.

## Examples

``` r
vd <- vowel_discrimination
vd$said_different <- vd$response == "different"
rates <- aggregate(said_different ~ listener + group + contrast + trial_type, data = vd,
                   FUN = function(x) (sum(x) + 0.5) / (length(x) + 1))
rates <- reshape(rates, idvar = c("listener", "group", "contrast"),
                 timevar = "trial_type", direction = "wide")
dprime_sd <- function(h, f) {
  if (h <= f) return(0)
  k <- sqrt(2) * qnorm(f / 2)
  uniroot(function(d) h - pnorm((k + d) / sqrt(2)) - pnorm((k - d) / sqrt(2)),
          c(0, 10))$root
}
rates$dprime <- mapply(dprime_sd, rates$said_different.different,
                       rates$said_different.same)
round(tapply(rates$dprime, rates[c("contrast", "group")], mean), 2)
#>               group
#> contrast         L1   L2
#>   FLEECE-KIT   3.55 0.91
#>   FLEECE-DRESS 3.48 2.83
#>   START-STRUT  3.17 0.88
#>   TRAP-START   3.72 1.36
#>   THOUGHT-LOT  3.45 2.20
#>   GOOSE-FOOT   3.20 1.09
```
