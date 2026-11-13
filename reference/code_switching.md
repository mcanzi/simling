# Code-switching by Portuguese-German bilinguals

Switches between Portuguese and German in conversations of 90 speakers
of Portuguese heritage in Germany, 30 from each of three generations.
Each speaker is recorded in four conversations on different topics, with
a bilingual or a monolingual (German) interlocutor. Second-generation
speakers switch most, and more of their switches fall within a sentence.
Speakers rarely switch with monolingual interlocutors. For count models
with an exposure.

## Usage

``` r
code_switching
```

## Format

A tibble with 360 rows and 8 columns:

- speaker:

  Speaker ID, `S01` to `S90`.

- generation:

  `"first"`, `"second"` or `"third"`.

- conversation:

  Conversation ID (`speaker_topic`).

- topic:

  `"family"`, `"work"`, `"leisure"` or `"migration"`.

- interlocutor:

  `"monolingual"` or `"bilingual"`.

- utterances:

  Utterances by the speaker in the conversation.

- switches:

  Switches between the languages.

- intrasentential:

  Of these, switches within a sentence.

## Source

`data-raw/code_switching.R`

## Details

True model: switches are negative binomial (size 6) with mean
`rate * utterances`, where `rate` is 0.04 (first), 0.12 (second) or 0.07
(third generation), multiplied by 1.3 (family), 0.8 (work), 1 (leisure)
or 1.1 (migration), by 0.25 with a monolingual interlocutor, and by a
speaker effect (SD 0.35 on the log scale). Intrasentential switches are
binomial with probability 0.25, 0.6 and 0.4 for the three generations.

## References

Poplack, S. (1980). Sometimes I'll start a sentence in Spanish y termino
en español: Toward a typology of code-switching. *Linguistics*, 18(7-8),
581-618.
[doi:10.1515/ling.1980.18.7-8.581](https://doi.org/10.1515/ling.1980.18.7-8.581)

## Examples

``` r
head(code_switching)
#> # A tibble: 6 × 8
#>   speaker generation conversation  topic     interlocutor utterances switches
#>   <fct>   <fct>      <fct>         <fct>     <fct>             <int>    <int>
#> 1 S01     first      S01_family    family    bilingual           114        6
#> 2 S01     first      S01_leisure   leisure   bilingual           144        2
#> 3 S01     first      S01_migration migration monolingual         125        0
#> 4 S01     first      S01_work      work      bilingual            91        8
#> 5 S02     first      S02_family    family    bilingual           183        8
#> 6 S02     first      S02_leisure   leisure   bilingual           145        5
#> # ℹ 1 more variable: intrasentential <int>
```
