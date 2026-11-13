datasets <- utils::data(package = "simling")$results[, "Item"]

test_that("there are 50 data sets and each has a help page", {
  expect_length(datasets, 50)
  topics <- names(readRDS(system.file("help", "aliases.rds", package = "simling")))
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
