#' List the data sets in simling
#'
#' Returns one row per data set, with its branch of linguistics, its language,
#' its size, its response variable and the statistical topic it was built for.
#' Filter it like any other tibble to find a data set for a lesson.
#'
#' @return A tibble with one row per data set and the columns:
#' \describe{
#'   \item{name}{Name of the data set, as passed to `data()` or `?`.}
#'   \item{branch}{Branch of linguistics, a factor in the order used on the
#'   package website.}
#'   \item{language}{Language or languages the data simulate. `NA` for data
#'   sets without a particular language.}
#'   \item{rows}{Number of rows.}
#'   \item{columns}{Number of columns.}
#'   \item{response}{Type of response variable.}
#'   \item{topic}{Statistical topic the data set was built for.}
#' }
#' @export
#' @examples
#' simling_datasets()
#'
#' sets <- simling_datasets()
#' sets[sets$branch == "Psycholinguistics", ]
#' sets[grepl("counts", sets$response), c("name", "rows", "topic")]
#' table(sets$branch)
simling_datasets <- function() {
  meta <- simling_meta()
  meta$branch <- factor(meta$branch, levels = unique(meta$branch))
  meta
}

simling_meta <- function() {
  tibble::tribble(
    ~name, ~branch, ~language, ~rows, ~columns, ~response, ~topic,
    "formants", "Phonetics", NA, 120L, 5L,
    "continuous", "Normalisation, z-scores",
    "vowel_voicing", "Phonetics", "English", 120L, 2L,
    "continuous", "Two groups, t-tests",
    "speech_styles", "Phonetics", NA, 150L, 2L,
    "continuous", "Categorical predictors with three levels",
    "style_voicing", "Phonetics", NA, 160L, 3L,
    "continuous", "Categorical \u00d7 categorical interaction",
    "vowel_duration", "Phonetics", NA, 384L, 4L,
    "continuous", "Mixed models, random slopes",
    "korean_stops", "Phonetics", "Korean", 1440L, 8L,
    "continuous", "Cluster analysis, sound change",
    "price_f2", "Phonetics", "English (L1 and L2)", 2200L, 6L,
    "trajectories", "GAMs and GAMMs",
    "mandarin_tones", "Phonetics", "Mandarin", 4224L, 8L,
    "trajectories", "Contour shape, speaker normalisation",
    "hungarian_harmony", "Phonology", "Hungarian", 4200L, 6L,
    "binary", "Mixed logistic regression, wug tests",
    "tobi_agreement", "Prosody", "German", 456L, 8L,
    "labels from two coders", "Inter-rater agreement, kappa",
    "rhythm_metrics", "Prosody", "8 languages", 400L, 7L,
    "continuous", "Classification, rhythm classes",
    "rt_frequency", "Psycholinguistics", NA, 200L, 5L,
    "RT, binary", "Data wrangling",
    "word_rt", "Psycholinguistics", NA, 400L, 4L,
    "RT", "Multiple regression, collinearity",
    "freq_length", "Psycholinguistics", NA, 400L, 5L,
    "RT", "Continuous \u00d7 continuous interaction",
    "l2_frequency", "Psycholinguistics", NA, 400L, 3L,
    "RT", "Continuous \u00d7 categorical interaction",
    "lexical_decision", "Psycholinguistics", NA, 800L, 5L,
    "RT", "Mixed models, crossed random effects",
    "lexical_decision_l2", "Psycholinguistics", "German (L1 and L2)", 1200L, 6L,
    "RT", "Mixed models with interactions, figures",
    "naming_pilot", "Psycholinguistics", "German", 1200L, 6L,
    "naming latency", "Power analysis by simulation",
    "lexical_accuracy", "Psycholinguistics", "Italian", 1800L, 5L,
    "binary", "Mixed logistic regression",
    "zipf_rt", "Psycholinguistics", NA, 2000L, 4L,
    "RT", "Skewed predictors, log transformations",
    "disfluencies", "Psycholinguistics", "Italian", 2400L, 6L,
    "counts, many zeros", "Zero-inflated count models",
    "megastudy", "Psycholinguistics", NA, 6000L, 8L,
    "RT, proportion", "Large item-level data, non-linear effects",
    "pupil_noise", "Psycholinguistics", NA, 17856L, 6L,
    "trajectories", "GAMMs, autocorrelation",
    "n400", "Psycholinguistics", "German", 21600L, 9L,
    "ERP amplitude", "EEG, topography, continuous predictors",
    "visual_world", "Psycholinguistics", "English", 23040L, 10L,
    "samples per object", "Eye tracking, time-course analysis",
    "agreement_attraction", "Syntax", "English", 1280L, 10L,
    "eye-tracking measures, binary", "Reading measures, missing data",
    "acceptability", "Syntax", "English", 1536L, 6L,
    "7-point ratings", "Ordinal regression",
    "german_relatives", "Syntax", "German", 13824L, 8L,
    "reading times", "Self-paced reading, region-by-region analysis",
    "german_plurals", "Morphology", "German", 2880L, 7L,
    "five categories", "Multinomial regression, wug tests",
    "scalar_implicature", "Semantics and pragmatics", "English", 1440L, 6L,
    "binary, RT", "Bimodal individual differences",
    "turn_taking", "Conversation", "10 languages", 3000L, 6L,
    "gap duration", "Skewed distributions, cross-linguistic comparison",
    "passives", "Corpus linguistics", "English", 400L, 4L,
    "counts", "Poisson and negative binomial regression, offsets",
    "relativizers", "Corpus linguistics", "English", 2400L, 6L,
    "three categories", "Multinomial regression",
    "address_forms", "Sociolinguistics", "German", 180L, 4L,
    "categorical", "Contingency tables, chi-squared",
    "language_attitudes", "Sociolinguistics", NA, 320L, 15L,
    "5-point ratings", "Factor analysis, reverse-coding",
    "cantonese_tone_merger", "Sociolinguistics", "Cantonese", 1800L, 7L,
    "continuous", "Sound change in apparent time, mixtures",
    "td_deletion", "Sociolinguistics", "English", 2000L, 11L,
    "binary", "Trees and random forests",
    "dialect_survey", "Dialectology", "Italian", 580L, 7L,
    "counts out of 10", "Maps, spatial patterns",
    "code_switching", "Bilingualism", "Portuguese\u2013German", 360L, 8L,
    "counts", "Negative binomial regression, offsets",
    "perception_training", "Second language", NA, 18L, 3L,
    "correct out of 40", "Paired designs, wide data",
    "accent", "Second language", "English (L1 and L2)", 1200L, 9L,
    "categorical", "Random forests, cross-validation",
    "overregularization", "Language acquisition", "English", 144L, 4L,
    "errors out of attempts", "Binomial regression, null effects",
    "vocabulary_growth", "Language acquisition", "English", 572L, 4L,
    "counts out of 680", "Growth curves, longitudinal data",
    "first_words", "Language acquisition", "European Portuguese", 2400L, 6L,
    "age at first word, censored", "Survival analysis",
    "dgs_iconicity", "Sign language", "German Sign Language", 18000L, 7L,
    "7-point ratings", "Crossed random effects, group differences",
    "forensic_comparison", "Forensic speech science", "German", 3240L, 6L,
    "similarity scores", "Likelihood ratios, Cllr, calibration",
    "do_support", "Historical linguistics", "English", 1200L, 5L,
    "counts out of trials", "Logistic change, Constant Rate Effect",
    "word_order", "Typology", "400 invented languages", 400L, 8L,
    "categorical, counts", "Non-independence of languages",
    "bouba_kiki_meta", "Meta-analysis", "21 languages", 40L, 8L,
    "effect sizes", "Random-effects meta-analysis, publication bias",
    "messy_export", "Data cleaning", NA, 1086L, 10L,
    "raw text", "Cleaning a real-looking export"
  )
}
