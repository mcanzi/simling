# A messy experiment export

The raw export of a lexical decision experiment with 24 participants run
in two labs, as it might come out of experiment software and a
spreadsheet. The underlying data are clean (high- vs low-frequency
words, as in
[rt_frequency](https://mcanzi.de/simling/reference/rt_frequency.md));
the export needs cleaning before analysis. All columns except `Item` are
character, so this data set is the exception to the package's factor
convention.

## Usage

``` r
messy_export
```

## Format

A tibble with 1086 rows and 10 columns:

- Subject ID:

  Participant ID, written in four ways (`P01`, `p1`, `P 01`, `01`).

- Lab:

  `"A"` or `"B"`.

- Age:

  Age, sometimes with `" years"`.

- Block:

  `"practice"` or `"test"`.

- Item:

  Item number, 1 to 40; practice items reuse 1 to 4.

- Cond.:

  Word frequency, spelled in eight ways (`high`, `High`, `HIGH `, `hi`,
  `low`, `Low`, `LOW`, `lo `), some with trailing spaces.

- Response Time (ms):

  Reaction time, with a decimal comma in lab B, `"-999"` or `""` for
  missing values.

- ACC:

  Accuracy: `"1"`/`"0"` in lab A, `"correct"`/`"incorrect"` in lab B.

- Timestamp:

  Time of the trial: `2026-05-04 10:00:03` in lab A, `04.05.2026 10:00`
  in lab B.

- Notes:

  Always empty.

## Source

`data-raw/messy_export.R`

## Details

Problems to fix: inconsistent IDs, condition labels and accuracy codes;
a decimal comma; two codes for missing values; ages stored as text; two
date formats; 96 practice trials; 30 duplicated test trials; an empty
column; column names with spaces and punctuation. True model of the
clean data: `log(rt) = 6.38 + 0.1 * low + p0 + w0 + e`, with participant
(SD 0.12) and item (SD 0.05) effects and residual SD 0.15; accuracy is
96% for high- and 88% for low-frequency words.

## Examples

``` r
head(messy_export)
#> # A tibble: 6 × 10
#>   `Subject ID` Lab   Age   Block     Item Cond. `Response Time (ms)` ACC  
#>   <chr>        <chr> <chr> <chr>    <int> <chr> <chr>                <chr>
#> 1 p1           A     31    practice     1 Low   707.6                1    
#> 2 p1           A     31    practice     2 high  732.4                1    
#> 3 p1           A     31    practice     3 High  477.5                1    
#> 4 p1           A     31    practice     4 Low   810.6                1    
#> 5 p1           A     31    test         1 High  602.1                1    
#> 6 p1           A     31    test         2 high  933.2                1    
#> # ℹ 2 more variables: Timestamp <chr>, Notes <chr>
```
