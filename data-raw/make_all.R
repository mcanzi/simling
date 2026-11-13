# Rebuild every data set in data/. Run from the package root, in a UTF-8
# locale (the default on macOS and most Linux systems):
#   source("data-raw/make_all.R")
# Each script is run in a fresh environment, so seeds and helper objects
# (participants, words, ...) never leak from one data set into the next.
scripts <- setdiff(list.files("data-raw", pattern = "\\.R$", full.names = TRUE),
                   "data-raw/make_all.R")
for (s in scripts) sys.source(s, envir = new.env())
