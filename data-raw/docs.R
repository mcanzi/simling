devtools::load_all(".", quiet = TRUE)
library(dplyr)
library(purrr)
library(readr)
library(stringr)

sets <- simling_datasets()

table_lines <- c(
  "| Branch | Data set | Language | Rows | Response | Topic |",
  "|---|---|---|---:|---|---|",
  sets |>
    mutate(branch_cell = if_else(row_number() == 1, as.character(branch), ""), .by = branch) |>
    mutate(language = coalesce(language, "–"),
           rows = format(rows, big.mark = ",", trim = TRUE),
           line = str_c("| ", branch_cell, " | `", name, "` | ", language, " | ", rows, " | ",
                        response, " | ", topic, " |")) |>
    pull(line)
)

readme <- read_lines("README.md")
start <- str_which(readme, fixed("<!-- datasets:start -->"))
end <- str_which(readme, fixed("<!-- datasets:end -->"))
readme <- c(head(readme, start), table_lines, tail(readme, -(end - 1)))
write_lines(readme, "README.md")

reference <- levels(sets$branch) |>
  map(\(b) c(str_c("- title: ", b), "  contents:",
             str_c("  - ", sets |> filter(branch == b) |> pull(name)))) |>
  list_c()
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
pkgdown <- read_lines("_pkgdown.yml")
pkgdown <- c(head(pkgdown, str_which(pkgdown, "^reference:") - 1), reference)
write_lines(pkgdown, "_pkgdown.yml")
