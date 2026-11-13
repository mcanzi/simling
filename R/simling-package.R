#' simling: Simulated Linguistic Data for Teaching Statistics
#'
#' Simulated data sets from many branches of linguistics. Each help page
#' lists the variables and the true model the data were simulated from; the
#' code is in `data-raw/` on GitHub. [simling_datasets()] lists them all, with
#' their branch, language, size, response and topic.
#'
#' Every categorical column is a factor. Its first level is the reference
#' level: the baseline condition, the first group or the expected response.
#' IDs such as participants, speakers and words are factors too. Binary
#' outcomes coded 0/1 and rating scales are numeric. The exception is
#' [messy_export], which keeps the text columns of a raw export.
#'
#' @keywords internal
#' @importFrom tibble tibble
"_PACKAGE"
