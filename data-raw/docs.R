devtools::load_all(".", quiet = TRUE)

sets <- simling_datasets()

cell <- function(x) ifelse(is.na(x), "–", x)
branch <- as.character(sets$branch)
first <- !duplicated(branch)
table_lines <- c(
  "| Branch | Data set | Language | Rows | Response | Topic |",
  "|---|---|---|---:|---|---|",
  sprintf(
    "| %s | `%s` | %s | %s | %s | %s |",
    ifelse(first, branch, ""), sets$name, cell(sets$language),
    format(sets$rows, big.mark = ",", trim = TRUE), sets$response, sets$topic
  )
)

readme <- readLines("README.md", encoding = "UTF-8")
start <- grep("<!-- datasets:start -->", readme, fixed = TRUE)
end <- grep("<!-- datasets:end -->", readme, fixed = TRUE)
readme <- c(readme[seq_len(start)], table_lines, readme[end:length(readme)])
writeLines(enc2utf8(readme), "README.md", useBytes = TRUE)

reference <- unlist(lapply(levels(sets$branch), function(b) {
  c(paste0("- title: ", b), "  contents:", paste0("  - ", sets$name[sets$branch == b]))
}))
reference <- c(
  "reference:",
  "- title: Finding a data set",
  "  contents:",
  "  - simling_datasets",
  reference,
  "- title: Package",
  "  contents:",
  "  - simling-package"
)
pkgdown <- readLines("_pkgdown.yml")
pkgdown <- c(pkgdown[seq_len(grep("^reference:", pkgdown) - 1)], reference)
writeLines(pkgdown, "_pkgdown.yml")
