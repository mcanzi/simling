scripts <- setdiff(list.files("data-raw", pattern = "\\.R$", full.names = TRUE),
                   c("data-raw/make_all.R", "data-raw/docs.R",
                     "data-raw/readme_figure.R"))
for (s in scripts) sys.source(s, envir = new.env())
