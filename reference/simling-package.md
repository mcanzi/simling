# simling: Simulated Linguistic Data for Teaching Statistics

Simulated data sets from many branches of linguistics. Each help page
lists the variables and the true model the data were simulated from; the
code is in `data-raw/` on GitHub.
[`simling_datasets()`](https://mcanzi.de/simling/reference/simling_datasets.md)
lists them all, with their branch, language, size, response and topic.

## Details

Every categorical column is a factor. Its first level is the reference
level: the baseline condition, the first group or the expected response.
IDs such as participants, speakers and words are factors too. Binary
outcomes coded 0/1 and rating scales are numeric. The exception is
[messy_export](https://mcanzi.de/simling/reference/messy_export.md),
which keeps the text columns of a raw export.

## See also

Useful links:

- <https://github.com/mcanzi/simling>

- <https://mcanzi.de/simling/>

- Report bugs at <https://github.com/mcanzi/simling/issues>

## Author

**Maintainer**: Massimiliano Canzi <massimiliano.canzi@uni-konstanz.de>
([ORCID](https://orcid.org/0000-0001-6124-0321)) \[copyright holder\]
