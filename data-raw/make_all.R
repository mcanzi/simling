scripts <- setdiff(list.files("data-raw", pattern = "\\.R$", full.names = TRUE),
                   "data-raw/make_all.R")
for (s in scripts) sys.source(s, envir = new.env())
