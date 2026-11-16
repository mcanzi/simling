# Scalar implicature: truth-value judgments

Participants judge *Some of the cards have stars* when all, some or none
of the cards have stars. In the all-context the sentence is literally
true but under-informative: a "false" response is pragmatic, a "true"
response logical. Participants differ: some always answer one way, most
mix the two. 60 participants, 24 items, three counterbalanced lists.

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
their own probability, drawn from Beta(1.1, 0.7) (mean 0.61). Controls
are answered correctly 96% of the time. Reaction times follow

    log(rt) = 7.25 + 0.22 * pragmatic

where `pragmatic` marks a "false" response in the all-context, with
by-participant (SD 0.15) and by-item (SD 0.05) intercepts and residual
SD 0.25. The proportions follow Experiment 3 of Bott and Noveck (2004):
61% pragmatic responses, 9 of 32 participants who always gave the same
response, 87% to 98% correct on controls, slower pragmatic responses and
logical responses about as fast as controls. The effect sizes and data
are simulated.

## References

Bott, L. & Noveck, I. A. (2004). Some utterances are underinformative:
The onset and time course of scalar inferences. *Journal of Memory and
Language*, 51(3), 437-457.
[doi:10.1016/j.jml.2004.05.006](https://doi.org/10.1016/j.jml.2004.05.006)

## Examples

``` r
all_ctx <- subset(scalar_implicature, context == "all")
p_false <- tapply(all_ctx$response == "false", all_ctx$participant, mean)
hist(p_false, breaks = 10)

controls <- droplevels(subset(scalar_implicature, context != "all"))
tapply(controls$response == "true", controls$context, mean)
#>       some       none 
#> 0.96041667 0.03541667 
aggregate(rt ~ response, data = all_ctx, FUN = median)
#>   response     rt
#> 1     true 1330.5
#> 2    false 1748.5
```
