datasets <- utils::data(package = "simling")$results[, "Item"]

test_that("there are 54 data sets and each has a help page", {
  expect_length(datasets, 55)
  aliases <- system.file("help", "aliases.rds", package = "simling")
  skip_if(aliases == "", "help index only exists in an installed package")
  topics <- names(readRDS(aliases))
  expect_true(all(datasets %in% topics))
})

test_that("every data set is a non-empty tibble", {
  for (d in datasets) {
    x <- get(d, envir = asNamespace("simling"))
    expect_s3_class(x, "tbl_df")
    expect_gt(nrow(x), 0)
  }
})

test_that("categorical columns are factors, except in messy_export", {
  for (d in setdiff(datasets, "messy_export")) {
    x <- get(d, envir = asNamespace("simling"))
    expect_false(any(vapply(x, is.character, logical(1))), label = d)
  }
})

test_that("column names are snake_case, except in messy_export", {
  for (d in setdiff(datasets, "messy_export")) {
    x <- get(d, envir = asNamespace("simling"))
    expect_true(all(grepl("^[a-z][a-z0-9_]*$", names(x))), label = d)
  }
})

test_that("factors have no unused levels", {
  for (d in datasets) {
    x <- get(d, envir = asNamespace("simling"))
    for (col in names(x)[vapply(x, is.factor, logical(1))]) {
      expect_setequal(levels(droplevels(x[[col]])), levels(x[[col]]))
    }
  }
})

test_that("simling_datasets() lists every data set with its true size", {
  sets <- simling_datasets()
  expect_s3_class(sets, "tbl_df")
  expect_setequal(sets$name, datasets)
  expect_false(anyDuplicated(sets$name) > 0)
  expect_s3_class(sets$branch, "factor")
  for (i in seq_len(nrow(sets))) {
    x <- get(sets$name[i], envir = asNamespace("simling"))
    expect_identical(sets$rows[i], nrow(x), label = sets$name[i])
    expect_identical(sets$columns[i], ncol(x), label = sets$name[i])
  }
})

test_that("README and pkgdown groups match simling_datasets()", {
  root <- testthat::test_path("..", "..")
  skip_if_not(file.exists(file.path(root, "_pkgdown.yml")))
  sets <- simling_datasets()
  pkgdown <- readLines(file.path(root, "_pkgdown.yml"))
  listed <- sub("^  - ", "", grep("^  - ", pkgdown, value = TRUE))
  expect_setequal(setdiff(listed, c("simling_datasets", "simling-package")), sets$name)
  for (b in levels(sets$branch)) {
    expect_true(paste0("- title: ", b) %in% pkgdown, label = b)
  }
  readme <- readLines(file.path(root, "README.md"), encoding = "UTF-8")
  rows <- grep("^\\| .* \\| `", readme, value = TRUE)
  expect_setequal(sub("^.*?`([a-z0-9_]+)`.*$", "\\1", rows), sets$name)
})
