# Scalar implicature: truth-value judgments

Participants judge *Some of the cards have stars* when all, some or none
of the cards have stars. In the all-context the sentence is literally
true but under-informative: pragmatic responders say "false", logical
responders "true". Participants differ strongly, so responses there are
bimodal by participant. 60 participants, 24 items, three counterbalanced
lists.

## Usage

``` r
scalar_implicature
```

## Format

A tibble with 1440 rows and 6 columns:

- participant:

  Participant ID, `P01` to `P60`.

- list:

  Counterbalancing list, 1 to 3.

- item:

  Item ID, `i01` to `i24`.

- context:

  How many cards have stars: `"some"` (true control), `"all"` (critical)
  or `"none"` (false control).

- response:

  `"true"` or `"false"`.

- rt:

  Response time in ms.

## Source

`data-raw/scalar_implicature.R`

## Details

True model: in the all-context, each participant answers "false" with
their own probability, drawn from Beta(0.5, 0.5) (mostly near 0 or 1).
Controls are answered correctly 96% of the time.
`log(rt) = 7.25 + 0.22 * pragmatic "false" + 0.08 * logical "true"`
(both in the all-context only), with by-participant (SD 0.15) and
by-item (SD 0.05) intercepts and residual SD 0.25.

## Examples

``` r
table(scalar_implicature$context, scalar_implicature$response)
#>       
#>        true false
#>   some  462    18
#>   all   234   246
#>   none   21   459
```
