EX = {}

EX["rt_frequency"] = """aggregate(cbind(rt, correct) ~ frequency, data = rt_frequency, FUN = mean)
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(log(rt) ~ frequency + (1 | participant) + (1 | word), data = rt_frequency)
  exp(lme4::fixef(m))
}"""

EX["formants"] = """aggregate(cbind(f1, f2) ~ speaker + vowel, data = formants, FUN = mean)
formants$f1_z <- ave(formants$f1, formants$speaker, FUN = function(x) c(scale(x)))
formants$f2_z <- ave(formants$f2, formants$speaker, FUN = function(x) c(scale(x)))
aggregate(cbind(f1_z, f2_z) ~ speaker + vowel, data = formants, FUN = mean)"""

EX["zipf_rt"] = """hist(zipf_rt$freq, breaks = 50)
hist(log10(zipf_rt$freq), breaks = 50)
coef(lm(log(rt) ~ log10(freq), data = zipf_rt))"""

EX["word_rt"] = """cor(word_rt[c("log_freq", "length", "syllables")])
m <- lm(log(rt) ~ log_freq + length + syllables, data = word_rt)
summary(m)
summary(lm(log(rt) ~ syllables, data = word_rt))$coefficients"""

EX["freq_length"] = """m <- lm(log(rt) ~ lf_c * len_c, data = freq_length)
coef(m)"""

EX["vowel_voicing"] = """t.test(duration ~ voicing, data = vowel_voicing)
boxplot(duration ~ voicing, data = vowel_voicing)"""

EX["speech_styles"] = """m <- lm(duration ~ style, data = speech_styles)
anova(m)
coef(m)
pairwise.t.test(speech_styles$duration, speech_styles$style)"""

EX["l2_frequency"] = """m <- lm(log(rt) ~ log_freq * group, data = l2_frequency)
coef(m)
plot(log(rt) ~ log_freq, data = l2_frequency, col = group)"""

EX["style_voicing"] = """m <- lm(duration ~ style * voicing, data = style_voicing)
coef(m)
with(style_voicing, interaction.plot(voicing, style, duration))"""

EX["lexical_decision"] = """if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(log(rt) ~ freq_c + (1 + freq_c | participant) + (1 | word),
                  data = lexical_decision)
  summary(m)
}"""

EX["vowel_duration"] = """if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(duration ~ voicing + (1 + voicing | speaker) + (1 | word),
                  data = vowel_duration)
  summary(m)
}"""

EX["lexical_accuracy"] = """if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::glmer(correct ~ freq_c + (1 + freq_c || participant) + (1 | word),
                   data = lexical_accuracy, family = binomial)
  summary(m)
}"""

EX["lexical_decision_l2"] = """lexical_decision_l2$freq_c <- lexical_decision_l2$log_freq - 3.5
lexical_decision_l2$length_c <- lexical_decision_l2$length - 7
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(log(rt) ~ group * freq_c + length_c + (1 + freq_c | participant) +
                    (1 | word), data = lexical_decision_l2)
  lme4::fixef(m)
}"""

EX["price_f2"] = """if (requireNamespace("mgcv", quietly = TRUE)) {
  m <- mgcv::bam(f2 ~ l1 + s(time, by = l1) + s(time, speaker, bs = "fs", m = 1),
                 data = price_f2)
  summary(m)
  new <- expand.grid(time = c(0, 50, 100), l1 = c("English", "Italian"), speaker = "S01")
  cbind(new, f2 = predict(m, new, exclude = "s(time,speaker)"))
}"""

EX["mandarin_tones"] = """mandarin_tones$st <- 12 * log2(mandarin_tones$f0 /
  ave(mandarin_tones$f0, mandarin_tones$speaker))
round(tapply(mandarin_tones$st, mandarin_tones[c("tone", "time")], mean), 1)"""

EX["korean_stops"] = """aggregate(cbind(vot, f0) ~ generation + stop, data = korean_stops, FUN = mean)
korean_stops$f0_st <- 12 * log2(korean_stops$f0 / ave(korean_stops$f0, korean_stops$speaker))
for (g in c("older", "younger")) {
  d <- subset(korean_stops, generation == g)
  set.seed(1)
  cl <- kmeans(scale(d[c("vot", "f0_st")]), centers = 3, nstart = 10)
  print(table(d$stop, cl$cluster))
}"""

EX["hungarian_harmony"] = """round(prop.table(table(hungarian_harmony$stem_type, hungarian_harmony$suffix), 1), 2)
if (requireNamespace("lme4", quietly = TRUE)) {
  mixed <- subset(hungarian_harmony, is.element(stem_type, c("Bi", "Bé", "Be", "BNN")))
  m <- lme4::glmer(suffix ~ stem_type + (1 | participant) + (1 | item),
                   data = droplevels(mixed), family = binomial)
  lme4::fixef(m)
}"""

EX["tobi_agreement"] = """kappa <- function(a, b) {
  tab <- table(a, b)
  po <- sum(diag(tab)) / sum(tab)
  pe <- sum(rowSums(tab) * colSums(tab)) / sum(tab)^2
  c(agreement = po, kappa = (po - pe) / (1 - pe))
}
with(tobi_agreement, kappa(accent_1 != "none", accent_2 != "none"))
with(subset(tobi_agreement, accent_1 != "none" & accent_2 != "none"), kappa(accent_1, accent_2))
sapply(split(tobi_agreement, tobi_agreement$style),
       function(d) kappa(d$accent_1 != "none", d$accent_2 != "none"))"""

EX["rhythm_metrics"] = """means <- aggregate(cbind(percent_v, delta_c, varco_v) ~ language,
                   data = rhythm_metrics, FUN = mean)
means[order(means$percent_v), ]
plot(delta_c ~ percent_v, data = rhythm_metrics, col = language)
coef(lm(delta_c ~ rate + language, data = rhythm_metrics))["rate"]"""

EX["naming_pilot"] = """if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(log(latency) ~ age_group * freq_c + (1 + freq_c | participant) +
                    (1 | picture), data = naming_pilot)
  lme4::fixef(m)
}"""

EX["megastudy"] = """m1 <- lm(rt ~ log_freq + length + neighbours + aoa + concreteness, data = megastudy)
m2 <- lm(rt ~ splines::ns(log_freq, 4) + length + neighbours + aoa + concreteness,
         data = megastudy)
anova(m1, m2)
coef(m2)[c("length", "neighbours", "aoa", "concreteness")]
round(cor(megastudy[c("log_freq", "length", "neighbours", "aoa")]), 2)"""

EX["pupil_noise"] = """curve <- aggregate(pupil ~ condition + time, data = pupil_noise, FUN = mean)
plot(pupil ~ time, data = curve, col = condition)
peaks <- do.call(rbind, lapply(split(curve, curve$condition),
                              function(d) d[which.max(d$pupil), ]))
peaks"""

EX["n400"] = """pz <- subset(n400, electrode == "Pz")
aggregate(amplitude ~ condition, data = pz, FUN = mean)
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(amplitude ~ cloze + (1 + cloze | participant), data = pz)
  lme4::fixef(m)
}
round(tapply(n400$amplitude, n400[c("anteriority", "condition")], mean), 2)"""

EX["visual_world"] = """visual_world$p_target <- visual_world$target / visual_world$samples
looks <- aggregate(p_target ~ condition + time, data = visual_world, FUN = mean)
plot(p_target ~ time, data = looks, col = condition)
abline(v = 600, lty = 2)
looks[looks$time == 600, ]"""

EX["disfluencies"] = """m0 <- glm(filled_pauses ~ role + offset(log(syllables / 100)), data = disfluencies,
          family = poisson)
c(observed_zeros = mean(disfluencies$filled_pauses == 0),
  poisson_zeros = mean(dpois(0, fitted(m0))))
if (requireNamespace("pscl", quietly = TRUE)) {
  m <- pscl::zeroinfl(filled_pauses ~ role + offset(log(syllables / 100)) | 1,
                      data = disfluencies)
  exp(coef(m, "count"))
  plogis(coef(m, "zero"))
}"""

EX["agreement_attraction"] = """aggregate(gaze_duration ~ grammaticality + attractor, data = agreement_attraction,
          FUN = mean)
mean(agreement_attraction$skipped)
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(log(gaze_duration) ~ grammaticality * attractor + (1 | participant) +
                    (1 | item), data = agreement_attraction)
  lme4::fixef(m)
}"""

EX["acceptability"] = """round(tapply(acceptability$rating, acceptability[c("length", "structure")], mean), 2)
\\donttest{
if (requireNamespace("ordinal", quietly = TRUE)) {
  acceptability$rating <- factor(acceptability$rating, ordered = TRUE)
  m <- ordinal::clmm(rating ~ length * structure + (1 | participant) + (1 | item),
                     data = acceptability)
  coef(summary(m))
}
}"""

EX["german_relatives"] = """round(tapply(german_relatives$rt, german_relatives[c("region", "condition")], mean))
if (requireNamespace("lme4", quietly = TRUE)) {
  mv <- subset(german_relatives, region == "main_verb")
  m <- lme4::lmer(log(rt) ~ condition + (1 | participant) + (1 | item), data = mv)
  lme4::fixef(m)
}"""

EX["german_plurals"] = """round(prop.table(table(german_plurals$final, german_plurals$plural), 1), 2)
round(prop.table(table(german_plurals$gender, german_plurals$plural), 1), 2)
if (requireNamespace("nnet", quietly = TRUE)) {
  m <- nnet::multinom(plural ~ gender + final, data = german_plurals, trace = FALSE)
  round(coef(m), 2)
}"""

EX["scalar_implicature"] = """all_ctx <- subset(scalar_implicature, context == "all")
p_false <- tapply(all_ctx$response == "false", all_ctx$participant, mean)
hist(p_false, breaks = 10)
controls <- droplevels(subset(scalar_implicature, context != "all"))
tapply(controls$response == "true", controls$context, mean)
aggregate(rt ~ response, data = all_ctx, FUN = median)"""

EX["turn_taking"] = """sort(tapply(turn_taking$offset, turn_taking$language, median))
hist(turn_taking$offset, breaks = 60)
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(offset ~ response + answer + gaze + language + (1 | conversation),
                  data = turn_taking)
  lme4::fixef(m)[c("responsedisconfirmation", "answernon-answer", "gazeyes")]
}"""

EX["passives"] = """if (requireNamespace("MASS", quietly = TRUE)) {
  m <- MASS::glm.nb(passives ~ 0 + register + offset(log(words / 1000)), data = passives)
  exp(coef(m))
  m$theta
}"""

EX["relativizers"] = """table(relativizers$role, relativizers$relativizer)
if (requireNamespace("nnet", quietly = TRUE)) {
  obj <- subset(relativizers, role == "object")
  obj$length_c <- obj$antecedent_length - 2
  m <- nnet::multinom(relativizer ~ mode + length_c, data = obj, trace = FALSE)
  round(coef(m), 2)
}"""

EX["address_forms"] = """tab <- xtabs(~ setting + form + age_group, data = address_forms)
round(prop.table(tab, c(1, 3))[, "du", ], 2)
chisq.test(tab[, , "under 30"])
chisq.test(tab[, , "over 50"])"""

EX["language_attitudes"] = """la <- language_attitudes
la$lazy <- 6 - la$lazy
la$cold <- 6 - la$cold
items <- na.omit(la[, 4:15])
fa <- factanal(items, factors = 3, rotation = "promax")
print(fa$loadings, cutoff = 0.3)
aggregate(cbind(intelligent, friendly, will_survive) ~ dialect_speaker, data = la, FUN = mean)"""

EX["cantonese_tone_merger"] = """rise <- tapply(cantonese_tone_merger$rise,
               cantonese_tone_merger[c("speaker", "tone")], mean)
age <- tapply(cantonese_tone_merger$age, cantonese_tone_merger$speaker, unique)
difference <- rise[, "T2"] - rise[, "T5"]
hist(difference, breaks = 20)
plot(age, difference)
table(merger = difference < 2, under_40 = age < 40)"""

EX["td_deletion"] = """if (requireNamespace("rpart", quietly = TRUE)) {
  tree <- rpart::rpart(deleted ~ following + morph + rate + log_freq + age + gender +
                         education + noise_cont + noise_bin, data = td_deletion)
  round(tree$variable.importance)
}
if (requireNamespace("randomForest", quietly = TRUE)) {
  set.seed(1)
  rf <- randomForest::randomForest(deleted ~ following + morph + rate + log_freq + age +
                                     gender + education + noise_cont + noise_bin,
                                   data = td_deletion, importance = TRUE)
  round(randomForest::importance(rf, type = 1), 1)
}"""

EX["dialect_survey"] = """dialect_survey$p <- dialect_survey$degeminated / dialect_survey$words
plot(lat ~ long, data = dialect_survey, col = grey(1 - p), pch = 16, asp = 1.3)
abline(h = 44.1, lty = 2)
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::glmer(cbind(degeminated, words - degeminated) ~ I(lat - 44.1) + I(age - 50) +
                     (1 | town), data = dialect_survey, family = binomial)
  lme4::fixef(m)
}"""

EX["code_switching"] = """if (requireNamespace("MASS", quietly = TRUE)) {
  m <- MASS::glm.nb(switches ~ generation + topic + interlocutor + offset(log(utterances)),
                    data = code_switching)
  round(exp(coef(m)), 2)
}
totals <- aggregate(cbind(intrasentential, switches) ~ generation, data = code_switching,
                    FUN = sum)
totals$intrasentential / totals$switches"""

EX["perception_training"] = """t.test(perception_training$post, perception_training$pre, paired = TRUE)
t.test(perception_training$post, perception_training$pre)"""

EX["accent"] = """aggregate(cbind(vot, vowel_ratio, rate, f0) ~ l1 + gender, data = accent, FUN = mean)
speakers <- levels(accent$speaker)
test <- is.element(accent$speaker, speakers[seq(1, length(speakers), by = 5)])
m <- glm(l1 ~ vot + vowel_ratio + rate, data = accent[!test, ], family = binomial)
mean((predict(m, accent[test, ], type = "response") > 0.5) == (accent$l1[test] == "Italian"))
if (requireNamespace("randomForest", quietly = TRUE)) {
  set.seed(1)
  rf <- randomForest::randomForest(l1 ~ vot + vowel_ratio + rate + f0 + h1h2 + intensity,
                                   data = accent[!test, ], importance = TRUE)
  print(round(randomForest::importance(rf, type = 1), 1))
  mean(predict(rf, accent[test, ]) == accent$l1[test])
}"""

EX["overregularization"] = """sum(overregularization$errors) / sum(overregularization$attempts)
aggregate(cbind(errors, attempts) ~ age, data = overregularization, FUN = sum)
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::glmer(cbind(errors, attempts - errors) ~ I((age - 45) / 12) + (1 | child),
                   data = overregularization, family = binomial)
  summary(m)$coefficients
}"""

EX["vocabulary_growth"] = """plot(vocabulary ~ age, data = vocabulary_growth, col = grey(0.4))
if (requireNamespace("lme4", quietly = TRUE)) {
  vocabulary_growth$session <- seq_len(nrow(vocabulary_growth))
  m <- lme4::glmer(cbind(vocabulary, 680 - vocabulary) ~ I(age - 24) +
                     I(log2(input / 1200)) + (1 | child) + (1 | session),
                   data = vocabulary_growth, family = binomial)
  b <- lme4::fixef(m)
  c(spurt_at_1200_words = 24 - b[[1]] / b[[2]], months_per_doubling = b[[3]] / b[[2]])
}"""

EX["first_words"] = """if (requireNamespace("survival", quietly = TRUE)) {
  km <- survival::survfit(survival::Surv(age, produced) ~ category, data = first_words)
  plot(km, col = 1:3, xlim = c(10, 24))
  m <- survival::coxph(survival::Surv(age, produced) ~ category + log_freq +
                         survival::frailty(child), data = first_words)
  coef(m)
}"""

EX["dgs_iconicity"] = """round(tapply(dgs_iconicity$rating, dgs_iconicity[c("group", "category")], mean), 2)
signs <- aggregate(rating ~ sign + group, data = dgs_iconicity, FUN = mean)
signs <- reshape(signs, idvar = "sign", timevar = "group", direction = "wide")
cor(signs[, 2], signs[, 3])
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(rating ~ group * category + (1 | rater) + (1 | sign), data = dgs_iconicity)
  lme4::fixef(m)
}"""

EX["forensic_comparison"] = """cllr <- function(score, same) {
  m <- glm(same ~ score, family = binomial)
  log_lr <- predict(m) - log(mean(same) / (1 - mean(same)))
  0.5 * (mean(log2(1 + exp(-log_lr[same]))) + mean(log2(1 + exp(log_lr[!same]))))
}
same <- forensic_comparison$same_speaker == "yes"
c(automatic = cllr(forensic_comparison$score_auto, same),
  formant = cllr(forensic_comparison$score_formant, same))
boxplot(score_auto ~ same_speaker, data = forensic_comparison)"""

EX["do_support"] = """do_support$century <- (do_support$year - 1550) / 100
m <- glm(cbind(do, eligible - do) ~ 0 + context + context:century, data = do_support,
         family = binomial)
round(coef(m), 2)
rising <- subset(do_support, context != "affirmative declarative")
anova(glm(cbind(do, eligible - do) ~ context + century, data = rising, family = binomial),
      glm(cbind(do, eligible - do) ~ context * century, data = rising, family = binomial),
      test = "Chisq")"""

EX["word_order"] = """round(prop.table(table(word_order$order)), 2)
round(prop.table(table(word_order$order, word_order$adpositions), 1), 2)
head(sort(table(word_order$family), decreasing = TRUE))
if (requireNamespace("lme4", quietly = TRUE)) {
  word_order$sov <- word_order$order == "SOV"
  m1 <- glm(adpositions ~ sov, data = word_order, family = binomial)
  m2 <- lme4::glmer(adpositions ~ sov + (1 | family), data = word_order, family = binomial)
  rbind(glm = summary(m1)$coefficients["sovTRUE", 1:2],
        glmer = summary(m2)$coefficients["sovTRUE", 1:2])
}"""

EX["bouba_kiki_meta"] = """if (requireNamespace("metafor", quietly = TRUE)) {
  m <- metafor::rma(yi = log_odds, sei = se, data = bouba_kiki_meta)
  print(m)
  print(metafor::rma(yi = log_odds, sei = se, mods = ~ script, data = bouba_kiki_meta))
  print(metafor::regtest(m))
  metafor::funnel(m)
}"""

EX["messy_export"] = """x <- messy_export
table(x$Cond.)
condition <- ifelse(substr(tolower(trimws(x$Cond.)), 1, 1) == "h", "high", "low")
rt <- as.numeric(sub(",", ".", x[["Response Time (ms)"]]))
rt[rt == -999] <- NA
id <- as.integer(gsub("[^0-9]", "", x[["Subject ID"]]))
test <- x$Block == "test" & !duplicated(data.frame(id, x$Item, x$Block))
tapply(rt[test], condition[test], mean, na.rm = TRUE)"""
