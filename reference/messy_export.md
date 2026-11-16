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
x <- messy_export
table(x$Cond.)
#> 
#> HIGH   High   LOW   Low    hi  high   lo    low 
#>   128   131   132   135   138   142   142   138 
condition <- ifelse(substr(tolower(trimws(x$Cond.)), 1, 1) == "h", "high", "low")
rt <- as.numeric(sub(",", ".", x[["Response Time (ms)"]]))
rt[rt == -999] <- NA
id <- as.integer(gsub("[^0-9]", "", x[["Subject ID"]]))
test <- x$Block == "test" & !duplicated(data.frame(id, x$Item, x$Block))
tapply(rt[test], condition[test], mean, na.rm = TRUE)
#>     high      low 
#> 592.8893 631.4163 
```
