# List the data sets in simling

Returns one row per data set, with its branch of linguistics, its
language, its size, its response variable and the statistical topic it
was built for. Filter it like any other tibble to find a data set for a
lesson.

## Usage

``` r
simling_datasets()
```

## Value

A tibble with one row per data set and the columns:

- name:

  Name of the data set, as passed to
  [`data()`](https://rdrr.io/r/utils/data.html) or `?`.

- branch:

  Branch of linguistics, a factor in the order used on the package
  website.

- language:

  Language or languages the data simulate. `NA` for data sets without a
  particular language.

- rows:

  Number of rows.

- columns:

  Number of columns.

- response:

  Type of response variable.

- topic:

  Statistical topic the data set was built for.

## Examples

``` r
simling_datasets()
#> # A tibble: 54 × 7
#>    name               branch    language             rows columns response topic
#>    <chr>              <fct>     <chr>               <int>   <int> <chr>    <chr>
#>  1 formants           Phonetics NA                    120       5 continu… Norm…
#>  2 vowel_voicing      Phonetics English               120       2 continu… Two …
#>  3 speech_styles      Phonetics NA                    150       2 continu… Cate…
#>  4 style_voicing      Phonetics NA                    160       3 continu… Cate…
#>  5 vowel_duration     Phonetics NA                    384       4 continu… Mixe…
#>  6 korean_stops       Phonetics Korean               1440       8 continu… Clus…
#>  7 price_f2           Phonetics English (L1 and L2)  2200       6 traject… GAMs…
#>  8 mandarin_tones     Phonetics Mandarin             4224       8 traject… Cont…
#>  9 vot_identification Phonetics English, Spanish     1224       6 binomia… Psyc…
#> 10 hungarian_harmony  Phonology Hungarian            4200       6 binary   Mixe…
#> # ℹ 44 more rows

sets <- simling_datasets()
sets[sets$branch == "Psycholinguistics", ]
#> # A tibble: 14 × 7
#>    name                branch            language    rows columns response topic
#>    <chr>               <fct>             <chr>      <int>   <int> <chr>    <chr>
#>  1 rt_frequency        Psycholinguistics NA           200       5 RT, bin… Data…
#>  2 freq_length         Psycholinguistics NA           400       5 RT       Cont…
#>  3 l2_frequency        Psycholinguistics NA           400       3 RT       Cont…
#>  4 lexical_decision    Psycholinguistics NA           800       5 RT       Mixe…
#>  5 lexical_decision_l2 Psycholinguistics German (L…  1200       6 RT       Mixe…
#>  6 naming_pilot        Psycholinguistics German      1200       6 naming … Powe…
#>  7 lexical_accuracy    Psycholinguistics Italian     1800       5 binary   Mixe…
#>  8 zipf_rt             Psycholinguistics NA          2000       4 RT       Skew…
#>  9 disfluencies        Psycholinguistics Italian     2400       6 counts,… Zero…
#> 10 megastudy           Psycholinguistics NA          6000       9 RT, pro… Larg…
#> 11 pupil_noise         Psycholinguistics NA         17856       6 traject… GAMM…
#> 12 n400                Psycholinguistics German     21600       9 ERP amp… EEG,…
#> 13 visual_world        Psycholinguistics English    23040      10 samples… Eye …
#> 14 reading_skipping    Psycholinguistics English     1512       9 binary,… Skip…
sets[grepl("counts", sets$response), c("name", "rows", "topic")]
#> # A tibble: 9 × 3
#>   name                rows topic                                            
#>   <chr>              <int> <chr>                                            
#> 1 vot_identification  1224 Psychometric curves, category boundaries         
#> 2 disfluencies        2400 Zero-inflated count models                       
#> 3 passives             400 Poisson and negative binomial regression, offsets
#> 4 dialect_survey       580 Maps, spatial patterns                           
#> 5 code_switching       360 Negative binomial regression, offsets            
#> 6 vocabulary_growth    573 Growth curves, longitudinal data                 
#> 7 do_support          1200 Logistic change, Constant Rate Effect            
#> 8 iterated_learning     80 Growth over generations, few clusters            
#> 9 word_order           400 Non-independence of languages                    
table(sets$branch)
#> 
#>                Phonetics                Phonology                  Prosody 
#>                        9                        1                        3 
#>        Psycholinguistics                   Syntax               Morphology 
#>                       14                        3                        1 
#> Semantics and pragmatics             Conversation       Corpus linguistics 
#>                        1                        1                        2 
#>         Sociolinguistics             Dialectology             Bilingualism 
#>                        4                        1                        1 
#>          Second language     Language acquisition     Clinical linguistics 
#>                        2                        3                        1 
#>            Sign language  Forensic speech science   Historical linguistics 
#>                        1                        1                        1 
#>       Language evolution                 Typology            Meta-analysis 
#>                        1                        1                        1 
#>            Data cleaning 
#>                        1 
```
