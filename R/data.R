# All data sets are simulated. The code that generated each one is in
# data-raw/ (https://github.com/mcanzi/simling/tree/main/data-raw), so the
# true effects are known and listed under "True model".

#' Reaction times to high- and low-frequency words
#'
#' A small lexical decision task: 10 participants each respond to the same 20
#' words, 10 of high and 10 of low frequency.
#'
#' @format A tibble with 200 rows and 5 columns:
#' \describe{
#'   \item{participant}{Participant ID, `P01` to `P10`.}
#'   \item{word}{Word ID, `w01` to `w20`.}
#'   \item{frequency}{Word frequency, `"high"` or `"low"`.}
#'   \item{rt}{Reaction time in ms.}
#'   \item{accuracy}{1 for a correct response, 0 for an error.}
#' }
#' @details True model: `log(rt) = 6.38 + 0.1 * low + p0 + w0 + e`, with
#'   by-participant intercepts `p0` (SD 0.12), by-word intercepts `w0` (SD
#'   0.06) and residual SD 0.15, so low-frequency words take about 10%
#'   longer. Accuracy is 95% for high- and 85% for low-frequency words.
#' @source `data-raw/rt_frequency.R`
#' @examples
#' head(rt_frequency)
"rt_frequency"

#' Formants of three vowels from two speakers
#'
#' F1 and F2 of /i a u/, 20 tokens per vowel from each of two speakers.
#' Speaker B has a shorter vocal tract, so all formants are 20% higher.
#'
#' @format A tibble with 120 rows and 5 columns:
#' \describe{
#'   \item{speaker}{`"A"` or `"B"`.}
#'   \item{vowel}{`"i"`, `"a"` or `"u"`.}
#'   \item{token}{Token number, 1 to 20.}
#'   \item{F1, F2}{First and second formant in Hz.}
#' }
#' @details True model: speaker A's mean F1 and F2 are 300 and 2300 Hz for
#'   /i/, 750 and 1300 Hz for /a/, and 320 and 800 Hz for /u/; speaker B's are
#'   1.2 times higher. Token SD is 40 Hz for F1 and 120 Hz for F2.
#' @source `data-raw/formants.R`
#' @examples
#' head(formants)
"formants"

#' Reaction times and Zipfian word frequency
#'
#' 2000 words sampled at random from the 50,000 most frequent word types of a
#' corpus whose frequencies follow Zipf's law (frequency proportional to
#' 1 / rank). As in real corpora, most words are rare and a few are very
#' frequent, so frequency is extremely skewed. Useful for log transformations.
#'
#' @format A tibble with 2000 rows and 4 columns:
#' \describe{
#'   \item{word}{Word ID, `w0001` to `w2000`.}
#'   \item{rank}{Frequency rank in the corpus, 1 to 50,000.}
#'   \item{freq}{Frequency per million words, `50000 / rank`.}
#'   \item{rt}{Reaction time in ms.}
#' }
#' @details True model: `log(rt) = 6.62 - 0.08 * log10(freq) + e`, with
#'   `e` normal, SD 0.15.
#' @source `data-raw/zipf_rt.R`
#' @examples
#' head(zipf_rt)
"zipf_rt"

#' Reaction times, word frequency and word length
#'
#' 400 words with their frequency, length in letters and syllables, and a
#' reaction time. Frequent words are shorter, so frequency and length are
#' correlated.
#'
#' @format A tibble with 400 rows and 4 columns:
#' \describe{
#'   \item{log_freq}{log10 word frequency, 1 to 6.}
#'   \item{length}{Length in letters, 2 to 14.}
#'   \item{syllables}{Number of syllables, roughly `length / 3`.}
#'   \item{rt}{Reaction time in ms.}
#' }
#' @details True model: `log(rt) = 6.62 - 0.04 * (log_freq - 3.5) + 0.0186 *
#'   (length - 7) + e`, with `e` normal, SD 0.06. Syllables have no effect of
#'   their own.
#' @source `data-raw/word_rt.R`
#' @examples
#' head(word_rt)
"word_rt"

#' Vowel duration before voiced and voiceless consonants
#'
#' A production study: 60 vowels before voiceless consonants (*beat*) and 60
#' before voiced ones (*bead*).
#'
#' @format A tibble with 120 rows and 2 columns:
#' \describe{
#'   \item{voicing}{Factor, levels `"voiceless"` (reference) and
#'     `"voiced"`.}
#'   \item{duration}{Vowel duration in ms.}
#' }
#' @details True model: mean 120 ms (SD 20) before voiceless and 160 ms
#'   (SD 22) before voiced consonants.
#' @source `data-raw/vowel_voicing.R`
#' @examples
#' head(vowel_voicing)
"vowel_voicing"

#' Vowel duration in three speaking styles
#'
#' 50 vowels each in casual, clear and loud speech.
#'
#' @format A tibble with 150 rows and 2 columns:
#' \describe{
#'   \item{style}{`"casual"`, `"clear"` or `"loud"`.}
#'   \item{duration}{Vowel duration in ms.}
#' }
#' @details True model: mean 110 ms (SD 18) in casual, 150 ms (SD 20) in
#'   clear and 132 ms (SD 19) in loud speech.
#' @source `data-raw/speech_styles.R`
#' @examples
#' head(speech_styles)
"speech_styles"

#' Frequency effects in L1 and L2 speakers
#'
#' Reaction times of L1 and L2 speakers to words of varying frequency. The
#' frequency effect is stronger for L2 speakers: a continuous-by-categorical
#' interaction.
#'
#' @format A tibble with 400 rows and 3 columns:
#' \describe{
#'   \item{group}{`"L1"` or `"L2"`, 200 responses each.}
#'   \item{log_freq}{log10 word frequency, 1 to 6.}
#'   \item{rt}{Reaction time in ms.}
#' }
#' @details True model: `log(rt) = 6.56 - 0.04 * log_freq` for L1 and
#'   `6.85 - 0.07 * log_freq` for L2 speakers, plus normal noise with SD 0.06.
#' @source `data-raw/l2_frequency.R`
#' @examples
#' head(l2_frequency)
"l2_frequency"

#' Vowel duration by speaking style and voicing
#'
#' A 2 x 2 design: casual or clear speech, voiceless or voiced following
#' consonant, 40 tokens per cell. The voicing effect is larger in clear
#' speech: a categorical-by-categorical interaction.
#'
#' @format A tibble with 160 rows and 3 columns:
#' \describe{
#'   \item{style}{`"casual"` or `"clear"`.}
#'   \item{voicing}{Factor, levels `"voiceless"` (reference) and `"voiced"`.}
#'   \item{duration}{Vowel duration in ms.}
#' }
#' @details True model: cell means are 110 (casual, voiceless), 145 (casual,
#'   voiced), 125 (clear, voiceless) and 180 ms (clear, voiced); SD 18 ms.
#' @source `data-raw/style_voicing.R`
#' @examples
#' head(style_voicing)
"style_voicing"

#' Reaction times with a frequency-by-length interaction
#'
#' 400 words whose frequency and length interact: the length effect is
#' smaller for frequent words. A continuous-by-continuous interaction.
#'
#' @format A tibble with 400 rows and 5 columns:
#' \describe{
#'   \item{log_freq}{log10 word frequency, 1 to 6.}
#'   \item{length}{Length in letters, 3 to 12.}
#'   \item{lf_c}{`log_freq`, centred.}
#'   \item{len_c}{`length`, centred.}
#'   \item{rt}{Reaction time in ms.}
#' }
#' @details True model: `log(rt) = 6.63 - 0.04 * lf_c + 0.018 * len_c -
#'   0.0065 * lf_c * len_c + e`, with `e` normal, SD 0.05.
#' @source `data-raw/freq_length.R`
#' @examples
#' head(freq_length)
"freq_length"

#' Lexical decision with participants and words
#'
#' 20 participants each respond to the same 40 words. Participants differ in
#' speed and in the size of their frequency effect; words differ in
#' difficulty. For crossed random effects.
#'
#' @format A tibble with 800 rows and 5 columns:
#' \describe{
#'   \item{participant}{Participant ID, `P01` to `P20`.}
#'   \item{word}{Word ID, `w01` to `w40`.}
#'   \item{log_freq}{log10 word frequency, 1 to 6.}
#'   \item{freq_c}{`log_freq`, centred on the mean of the 40 words.}
#'   \item{rt}{Reaction time in ms.}
#' }
#' @details True model: `log(rt) = 6.47 + u0 + w0 + (-0.045 + u1) * freq_c +
#'   e`. By-participant intercepts `u0` have SD 0.11 and slopes `u1` SD
#'   0.025, correlated at -0.6; by-word intercepts `w0` have SD 0.045;
#'   residual SD 0.075. Not to be confused with `languageR::lexdec`, which is
#'   real data.
#' @source `data-raw/lexical_decision.R`
#' @examples
#' head(lexical_decision)
"lexical_decision"

#' Vowel duration with speakers and words
#'
#' 16 speakers each produce the same 24 words, 12 with a voiceless and 12
#' with a voiced final consonant. Speakers differ in speed and in the size of
#' their voicing effect; words differ in duration.
#'
#' @format A tibble with 384 rows and 4 columns:
#' \describe{
#'   \item{speaker}{Speaker ID, `S01` to `S16`.}
#'   \item{word}{Word ID, `w01` to `w24`.}
#'   \item{voicing}{Factor, levels `"voiceless"` (reference) and `"voiced"`.}
#'   \item{duration}{Vowel duration in ms.}
#' }
#' @details True model: `duration = 150 + s0 + w0 + (20 + s1) * voiced + e`.
#'   By-speaker intercepts `s0` have SD 25 ms and slopes `s1` SD 12 ms
#'   (uncorrelated); by-word intercepts `w0` have SD 15 ms; residual SD 20 ms.
#' @source `data-raw/vowel_duration.R`
#' @examples
#' head(vowel_duration)
"vowel_duration"

#' Accuracy in an Italian lexical decision task
#'
#' 30 native speakers of Italian decide whether each of 60 Italian words is a
#' word; the outcome is whether the response was correct. For mixed-effects
#' logistic regression.
#'
#' @format A tibble with 1800 rows and 5 columns:
#' \describe{
#'   \item{participant}{Participant ID, `P01` to `P30`.}
#'   \item{word}{Word ID, `w01` to `w60`.}
#'   \item{log_freq}{log10 word frequency, 1 to 6.}
#'   \item{freq_c}{`log_freq`, centred on the mean of the 60 words.}
#'   \item{correct}{1 for a correct response, 0 for an error.}
#' }
#' @details True model, in log-odds: `1.5 + u0 + w0 + (0.8 + u1) * freq_c`.
#'   By-participant intercepts `u0` have SD 0.8 and slopes `u1` SD 0.3
#'   (uncorrelated); by-word intercepts `w0` have SD 0.5.
#' @source `data-raw/lexical_accuracy.R`
#' @examples
#' head(lexical_accuracy)
"lexical_accuracy"

#' German lexical decision by L1 and L2 speakers
#'
#' 30 participants (15 L1 and 15 L2 speakers of German) each respond to the
#' same 40 German words. L2 speakers are slower and more sensitive to
#' frequency.
#'
#' @format A tibble with 1200 rows and 6 columns:
#' \describe{
#'   \item{participant}{Participant ID, `P01` to `P30`.}
#'   \item{group}{`"L1"` or `"L2"`.}
#'   \item{word}{Word ID, `w01` to `w40`.}
#'   \item{log_freq}{log10 word frequency, 1 to 6.}
#'   \item{length}{Length in letters, 3 to 13; frequent words are shorter.}
#'   \item{rt}{Reaction time in ms.}
#' }
#' @details True model: `log(rt) = 6.55 + 0.16 * L2 + p0 + w0 + slope *
#'   (log_freq - 3.5) + 0.017 * (length - 7) + e`, where `slope = -0.035 -
#'   0.03 * L2 + p1`. By-participant intercepts `p0` have SD 0.085 and slopes
#'   `p1` SD 0.015; by-word intercepts `w0` have SD 0.04; residual SD 0.09.
#' @source `data-raw/lexical_decision_l2.R`
#' @examples
#' head(lexical_decision_l2)
"lexical_decision_l2"

#' F2 trajectories of the PRICE diphthong
#'
#' F2 over the course of the PRICE vowel (as in *price*), 10 tokens from each
#' of 20 speakers: 10 L1 English and 10 L1 Italian speakers of English.
#' Italian speakers start higher, end lower and move earlier and more
#' gradually. For GAMs and GAMMs.
#'
#' @format A tibble with 2200 rows and 6 columns:
#' \describe{
#'   \item{speaker}{Factor, `S01` to `S20`.}
#'   \item{l1}{Factor, `"English"` or `"Italian"`.}
#'   \item{traj}{Factor, one level per token (`speaker.token`).}
#'   \item{duration}{Vowel duration in ms, 120 to 300.}
#'   \item{time}{Normalised time, 0 to 100 in steps of 10.}
#'   \item{f2}{F2 in Hz.}
#' }
#' @details True model: a logistic rise from an onset (1250 Hz English, 1320
#'   Hz Italian) to an offset (2050 / 1900 Hz, lowered by 2 Hz per ms that
#'   the vowel is shorter than 250 ms), with its midpoint at 62 / 50 and
#'   width 8 / 14. By-speaker offsets (SD 60 Hz) and midpoints (SD 5) and
#'   by-token offsets (SD 40 Hz); residuals are AR(1) with rho 0.6 and SD 30
#'   Hz.
#' @source `data-raw/price_f2.R`
#' @examples
#' head(price_f2)
"price_f2"

#' Pupil dilation when listening in quiet and in noise
#'
#' Pupil size over 3 seconds after stimulus onset, 12 trials per condition
#' from each of 24 participants. Listening in noise leads to a larger and
#' later peak. For GAMMs with autocorrelated residuals.
#'
#' @format A tibble with 17856 rows and 6 columns:
#' \describe{
#'   \item{participant}{Factor, `P01` to `P24`.}
#'   \item{condition}{Factor, levels `"quiet"` (reference) and `"noise"`.}
#'   \item{trial}{Trial number within condition, 1 to 12.}
#'   \item{trial_id}{Factor, one level per trial
#'     (`participant.condition.trial`).}
#'   \item{time}{Time from stimulus onset in ms, 0 to 3000 in steps of 100.}
#'   \item{pupil}{Baseline-corrected pupil size, arbitrary units.}
#' }
#' @details True model: a gamma-shaped response peaking at 180 units after
#'   1200 ms in quiet, and 90 units higher and 250 ms later in noise. The peak
#'   shrinks by 4 units per trial (habituation). By-participant variation in
#'   peak (SD 40), latency (SD 150 ms) and noise effect (SD 30); by-trial
#'   variation in peak (SD 40) and baseline (SD 15); residuals are AR(1) with
#'   rho 0.8 and SD 12.
#' @source `data-raw/pupil_noise.R`
#' @examples
#' head(pupil_noise)
"pupil_noise"

#' /t, d/ deletion
#'
#' Whether word-final /t, d/ is deleted (as in *wes' side*), 50 tokens from
#' each of 40 speakers. Includes an interaction, a non-linear age effect,
#' correlated predictors and two pure-noise predictors. For classification
#' trees and random forests.
#'
#' @format A tibble with 2000 rows and 11 columns:
#' \describe{
#'   \item{speaker}{Factor, `S01` to `S40`.}
#'   \item{deleted}{Factor, levels `"retained"` and `"deleted"`.}
#'   \item{following}{Following segment: `"consonant"`, `"vowel"` or
#'     `"pause"`.}
#'   \item{morph}{`"monomorpheme"` (*mist*) or `"past"` (*missed*).}
#'   \item{rate}{Speech rate in syllables per second.}
#'   \item{log_freq}{log10 word frequency, 1 to 6.}
#'   \item{age}{Speaker age, 18 to 80.}
#'   \item{gender}{`"female"` or `"male"`; no effect.}
#'   \item{education}{`"school"` or `"university"`; correlated with age but
#'     no effect of its own.}
#'   \item{noise_cont, noise_bin}{Random noise, continuous and binary; no
#'     effect.}
#' }
#' @details True model, in log-odds of deletion: `-0.8 + s0 + 1.8 *
#'   consonant + 0.4 * pause - 1 * past + 0.9 * (rate - 5) * consonant + 1.2 *
#'   plogis((45 - age) / 5) + 0.25 * (log_freq - 3.5)`, with by-speaker
#'   intercepts `s0` of SD 0.5. Rate matters only before consonants; deletion
#'   drops sharply around age 45.
#' @source `data-raw/td_deletion.R`
#' @examples
#' head(td_deletion)
"td_deletion"

#' Acoustic cues to a foreign accent
#'
#' Six acoustic measures from 40 tokens of each of 30 speakers of English: 15
#' L1 English and 15 L1 Italian. Three measures differ by L1, one by gender
#' and two by nothing. For classification with random forests and
#' cross-validation by speaker.
#'
#' @format A tibble with 1200 rows and 9 columns:
#' \describe{
#'   \item{speaker}{Factor, `S01` to `S30`.}
#'   \item{l1}{Factor, `"English"` or `"Italian"`.}
#'   \item{gender}{Factor, `"female"` or `"male"`.}
#'   \item{vot}{Voice onset time of /p t k/ in ms.}
#'   \item{vowel_ratio}{Ratio of stressed to unstressed vowel duration.}
#'   \item{rate}{Speech rate in syllables per second.}
#'   \item{f0}{Mean f0 in Hz.}
#'   \item{h1h2}{H1-H2 in dB.}
#'   \item{intensity}{Mean intensity in dB.}
#' }
#' @details True model: speaker means for English vs Italian are 70 vs 45 ms
#'   VOT, 1.6 vs 1.2 vowel ratio and 5.2 vs 4.7 syllables/s; VOT and vowel
#'   ratio vary log-normally around the speaker mean, so they stay positive; f0 is 210 Hz for
#'   female and 120 Hz for male speakers. H1-H2 varies by speaker only and
#'   intensity by token only.
#' @source `data-raw/accent.R`
#' @examples
#' head(accent)
"accent"

#' A pilot German picture-naming study for power analysis
#'
#' 15 younger and 15 older adults name the same 40 pictures in German.
#' Naming is slower for pictures with less frequent names, more so for older
#' adults. Meant as the pilot data from which to simulate a larger study.
#'
#' @format A tibble with 1200 rows and 6 columns:
#' \describe{
#'   \item{participant}{Factor, `P01` to `P30`.}
#'   \item{age_group}{`"younger"` or `"older"`.}
#'   \item{group}{`age_group` contrast-coded: -0.5 younger, 0.5 older.}
#'   \item{picture}{Factor, `pic01` to `pic40`.}
#'   \item{freq_c}{Centred log10 frequency of the picture name, about -2.5
#'     to 2.5.}
#'   \item{latency}{Naming latency in ms.}
#' }
#' @details True model: `log(latency) = 6.75 + 0.15 * group + p0 + w0 +
#'   (-0.04 - 0.02 * group + p1) * freq_c + e`. By-participant intercepts `p0`
#'   have SD 0.08 and slopes `p1` SD 0.015; by-picture intercepts `w0` have
#'   SD 0.04; residual SD 0.1.
#' @source `data-raw/naming_pilot.R`
#' @examples
#' head(naming_pilot)
"naming_pilot"

#' Acceptability judgments for whether-islands
#'
#' 7-point acceptability ratings in a 2 x 2 factorial design: dependency
#' length (short or long) by structure (non-island or island). Island effects
#' show up as an interaction: long dependencies out of islands are worse than
#' the two main effects predict. 48 participants rate 32 items, each item in
#' one condition per participant (four counterbalanced lists).
#'
#' @format A tibble with 1536 rows and 6 columns:
#' \describe{
#'   \item{participant}{Participant ID, `P01` to `P48`.}
#'   \item{list}{Counterbalancing list, 1 to 4.}
#'   \item{item}{Item ID, `i01` to `i32`.}
#'   \item{length}{Dependency length, `"short"` or `"long"`.}
#'   \item{structure}{`"non-island"` or `"island"`.}
#'   \item{rating}{Rating from 1 (unacceptable) to 7 (acceptable).}
#' }
#' @details True model: a cumulative logit model with thresholds at -2.5,
#'   -1.5, -0.5, 0.5, 1.5 and 2.5 on a latent scale `1.5 - 0.6 * long - 0.4 *
#'   island - 0.9 * long * island`. By-participant intercepts (SD 0.8) and
#'   interaction slopes (SD 0.3); by-item intercepts (SD 0.4).
#' @source `data-raw/acceptability.R`
#' @examples
#' table(acceptability$length, acceptability$structure, acceptability$rating)
"acceptability"

#' Eye-tracking while reading: agreement attraction
#'
#' Reading measures on the verb in sentences like *The key to the cabinet(s)
#' was/were rusty*: grammaticality by number of the attractor noun. A plural
#' attractor makes ungrammatical *were* easier to read. 40 participants read
#' 32 items, each in one condition (four counterbalanced lists).
#'
#' @format A tibble with 1280 rows and 10 columns:
#' \describe{
#'   \item{participant}{Participant ID, `P01` to `P40`.}
#'   \item{list}{Counterbalancing list, 1 to 4.}
#'   \item{item}{Item ID, `i01` to `i32`.}
#'   \item{grammaticality}{`"grammatical"` or `"ungrammatical"`.}
#'   \item{attractor}{Number of the attractor noun, `"singular"` or
#'     `"plural"`.}
#'   \item{skipped}{1 if the verb was skipped in first-pass reading.}
#'   \item{first_fixation}{Duration of the first fixation on the verb in
#'     ms; `NA` if skipped.}
#'   \item{gaze_duration}{Sum of first-pass fixations in ms; `NA` if
#'     skipped.}
#'   \item{regression}{1 if the reader made a regression out of the verb in
#'     first pass; `NA` if skipped.}
#'   \item{total_time}{Sum of all fixations on the verb in ms; `NA` if never
#'     fixated.}
#' }
#' @details True model: `log(gaze_duration) = 5.55 + 0.14 * ungrammatical -
#'   0.09 * ungrammatical * plural`, with by-participant (SD 0.15) and by-item
#'   (SD 0.08) intercepts and residual SD 0.3. First-pass regressions, in
#'   log-odds: `-1.9 + 0.9 * ungrammatical - 0.5 * ungrammatical * plural`,
#'   by-participant SD 0.5. Skipping rate about 14%, unrelated to condition.
#' @source `data-raw/agreement_attraction.R`
#' @examples
#' head(agreement_attraction)
"agreement_attraction"

#' Scalar implicature: truth-value judgments
#'
#' Participants judge *Some of the cards have stars* when all, some or none of
#' the cards have stars. In the all-context the sentence is literally true but
#' under-informative: pragmatic responders say "false", logical responders
#' "true". Participants differ strongly, so responses there are bimodal by
#' participant. 60 participants, 24 items, three counterbalanced lists.
#'
#' @format A tibble with 1440 rows and 6 columns:
#' \describe{
#'   \item{participant}{Participant ID, `P01` to `P60`.}
#'   \item{list}{Counterbalancing list, 1 to 3.}
#'   \item{item}{Item ID, `i01` to `i24`.}
#'   \item{context}{How many cards have stars: `"all"` (critical),
#'     `"some"` (true control) or `"none"` (false control).}
#'   \item{response}{`"true"` or `"false"`.}
#'   \item{rt}{Response time in ms.}
#' }
#' @details True model: in the all-context, each participant answers "false"
#'   with their own probability, drawn from Beta(0.5, 0.5) (mostly near 0 or
#'   1). Controls are answered correctly 96% of the time. `log(rt) = 7.25 +
#'   0.22 * pragmatic "false" + 0.08 * logical "true"` (both in the
#'   all-context only), with by-participant (SD 0.15) and by-item (SD 0.05)
#'   intercepts and residual SD 0.25.
#' @source `data-raw/scalar_implicature.R`
#' @examples
#' table(scalar_implicature$context, scalar_implicature$response)
"scalar_implicature"

#' Visual-world eye tracking: anticipatory looks
#'
#' Listeners hear *The boy will eat / move the cake* while looking at four
#' objects: the target (a cake, the only edible object), a phonological
#' competitor (a cage) and two unrelated distractors. After a restrictive
#' verb (*eat*) they look at the target before the noun is heard; while the
#' noun unfolds, the competitor briefly attracts looks too. Eye-tracker
#' samples on each object in 50 ms bins from verb onset; the noun starts at
#' 600 ms. 32 participants, 24
#' items, 12 per condition (two counterbalanced lists).
#'
#' @format A tibble with 23040 rows and 10 columns:
#' \describe{
#'   \item{participant}{Participant ID, `P01` to `P32`.}
#'   \item{list}{Counterbalancing list, 1 or 2.}
#'   \item{item}{Item ID, `i01` to `i24`.}
#'   \item{condition}{`"restrictive"` or `"non-restrictive"` verb.}
#'   \item{time}{Start of the 50 ms bin, ms from verb onset, 0 to 1450.}
#'   \item{target, competitor, distractor_1, distractor_2}{Eye-tracker
#'     samples on each object in this bin; they add up to `samples`.}
#'   \item{samples}{Samples per bin: always 25 (500 Hz).}
#' }
#' @details True model: on the logit scale, looks to the target rise from
#'   chance (0.25) to about 0.88 along a logistic curve with width 90 ms,
#'   centred at 650 ms after restrictive and 900 ms after non-restrictive
#'   verbs. By-participant variation in the centre (SD 80 ms) and in the final
#'   level (SD 0.3 logits); by-item variation in the centre (SD 40 ms). Within
#'   a trial, deviations are AR(1) with rho 0.9. Of the remaining samples,
#'   the competitor gets a third plus a bump of up to 25 percentage points
#'   centred at 850 ms (SD about 100 ms); the two distractors split the rest
#'   evenly.
#' @source `data-raw/visual_world.R`
#' @examples
#' head(visual_world)
"visual_world"

#' Passives in four registers
#'
#' Number of passive constructions in 400 texts, 100 each from conversation,
#' fiction, news and academic writing. Texts differ in length, so counts need
#' an exposure term. The counts are overdispersed.
#'
#' @format A tibble with 400 rows and 4 columns:
#' \describe{
#'   \item{text}{Text ID, `T001` to `T400`.}
#'   \item{register}{`"conversation"`, `"fiction"`, `"news"` or
#'     `"academic"`.}
#'   \item{words}{Text length in words.}
#'   \item{passives}{Number of passives.}
#' }
#' @details True model: negative binomial with mean `rate * words / 1000`
#'   and size 4, where `rate` per 1000 words is 2 (conversation), 5 (fiction),
#'   10 (news) and 18 (academic).
#' @source `data-raw/passives.R`
#' @examples
#' head(passives)
"passives"

#' Relativizer choice: that, which or zero
#'
#' The relativizer in restrictive relative clauses (*the book that / which /
#' 0 I read*), 10 tokens from each of 240 texts, half spoken, half written.
#' A three-way outcome; zero is impossible in subject relatives.
#'
#' @format A tibble with 2400 rows and 6 columns:
#' \describe{
#'   \item{text}{Text ID, `T001` to `T240`.}
#'   \item{mode}{`"spoken"` or `"written"`.}
#'   \item{token}{Token number within the text, 1 to 10.}
#'   \item{role}{Role of the relativized noun in the clause, `"subject"`
#'     or `"object"`.}
#'   \item{antecedent_length}{Length of the antecedent noun phrase in
#'     words.}
#'   \item{relativizer}{`"that"`, `"which"` or `"zero"`.}
#' }
#' @details True model: multinomial logit with "that" as reference. Which:
#'   `-1.6 + 1.4 * written + 0.25 * (antecedent_length - 2)`. Zero (object
#'   relatives only): `0.6 - 1.2 * written - 0.4 * (antecedent_length - 2)`.
#'   By-text intercepts with SD 0.5 for each.
#' @source `data-raw/relativizers.R`
#' @examples
#' table(relativizers$role, relativizers$relativizer)
"relativizers"

#' Vocabulary growth in toddlers
#'
#' Productive vocabulary on a 680-word parental checklist, every two months
#' from 16 to 30 months, for 80 children. Growth is S-shaped, and children
#' who hear more speech start their vocabulary spurt earlier. About 10% of
#' sessions are missing.
#'
#' @format A tibble with 572 rows and 4 columns:
#' \describe{
#'   \item{child}{Child ID, `C01` to `C80`.}
#'   \item{input}{Adult words per hour heard at home (one value per child).}
#'   \item{age}{Age in months.}
#'   \item{vocabulary}{Number of words produced, out of 680.}
#' }
#' @details True model: `vocabulary` is binomial out of 680 with probability
#'   `plogis((age - mid) / 2.8)`, where `mid = 25.2 - 2 * log2(input /
#'   1200)` plus a by-child deviation (SD 2.6 months), and session-level noise
#'   on the logit scale (SD 0.15). Doubling the input moves the spurt 2 months
#'   earlier. Children average about 300 words at 24 months.
#' @source `data-raw/vocabulary_growth.R`
#' @examples
#' head(vocabulary_growth)
"vocabulary_growth"

#' Past-tense overregularization
#'
#' Overregularization errors (*goed*, *holded*) out of all irregular past-tense
#' contexts, for 24 children recorded every six months from 30 to 60 months.
#' Errors are rare and peak around 42 months. For binomial models of errors
#' out of attempts.
#'
#' @format A tibble with 144 rows and 4 columns:
#' \describe{
#'   \item{child}{Child ID, `C01` to `C24`.}
#'   \item{age}{Age in months.}
#'   \item{attempts}{Irregular past-tense contexts in the recording.}
#'   \item{errors}{Overregularizations among them.}
#' }
#' @details True model, in log-odds: `-3 - 0.006 * (age - 42)^2`, with
#'   by-child intercepts of SD 0.5. The error rate peaks at about 5%.
#' @source `data-raw/overregularization.R`
#' @examples
#' head(overregularization)
"overregularization"

#' The rise of periphrastic do
#'
#' Use of *do* (*Did he go?*, *He did not go*) in 300 texts dated 1400 to
#' 1700, in four sentence types: the number of clauses with *do* out of all
#' eligible clauses. In three contexts the change follows S-curves with the
#' same slope but different starting points (the Constant Rate Effect);
#' affirmative declaratives barely take part.
#'
#' @format A tibble with 1200 rows and 5 columns:
#' \describe{
#'   \item{text}{Text ID, `T001` to `T300`.}
#'   \item{year}{Year of the text.}
#'   \item{context}{`"affirmative question"`, `"negative question"`,
#'     `"negative declarative"` or `"affirmative declarative"`.}
#'   \item{do}{Clauses with *do*.}
#'   \item{eligible}{All clauses in this context in this text.}
#' }
#' @details True model, in log-odds: `baseline + 0.035 * (year - 1550)`
#'   (3.5 per century in every context), with baselines 1.0 (affirmative
#'   questions), 1.6 (negative questions), -0.6 (negative declaratives) and
#'   -7.5 (affirmative declaratives), and by-text intercepts (SD 0.4). The
#'   later decline of *do* in affirmative declaratives is not simulated.
#' @source `data-raw/do_support.R`
#' @examples
#' head(do_support)
"do_support"

#' Word order in a typological sample
#'
#' 400 invented languages from 100 invented families in six invented areas.
#' Languages mostly inherit their family's word order, so observations are
#' not independent. Adposition order and case marking correlate with word
#' order, in the spirit of Greenberg's universals. Family sizes are skewed:
#' a few large families and many small ones.
#'
#' @format A tibble with 400 rows and 8 columns:
#' \describe{
#'   \item{language}{Language ID, `L001` to `L400`.}
#'   \item{family}{`"Family 001"` to `"Family 100"`.}
#'   \item{area}{`"Area A"` to `"Area F"`.}
#'   \item{order}{Basic word order: `"SOV"`, `"SVO"`, `"VSO"` or `"no
#'     dominant order"`.}
#'   \item{adpositions}{`"postpositions"` or `"prepositions"`.}
#'   \item{case_marking}{Whether nouns are case-marked, `"yes"` or `"no"`.}
#'   \item{consonants}{Size of the consonant inventory.}
#'   \item{vowels}{Size of the vowel inventory.}
#' }
#' @details True model: each family draws a word order from its area's
#'   preferences; each language keeps it with probability 0.8 and otherwise
#'   draws again. Postpositions have probability 0.92 in SOV, 0.5 in
#'   no-dominant-order and 0.12 in VO languages. Case marking has probability
#'   0.7 in SOV and 0.3 in other languages. Consonant inventories are 6 plus a
#'   negative binomial count (mean 16, by-family variation); vowel
#'   inventories are 3 plus a Poisson count (mean 2.5). Overall, about 44% of
#'   the languages are SOV, 36% SVO, 6% VSO and 14% have no dominant order,
#'   close to the world-wide proportions in WALS (feature 81A). All names and
#'   figures are invented, not real typological data.
#' @source `data-raw/word_order.R`
#' @examples
#' table(word_order$order, word_order$adpositions)
"word_order"

#' Forms of address: du or Sie
#'
#' Whether German speakers address a stranger with informal *du* or formal
#' *Sie*, by speaker age group and setting. 30 speakers per cell, one
#' observation each. For contingency tables and chi-squared tests.
#'
#' @format A tibble with 180 rows and 4 columns:
#' \describe{
#'   \item{speaker}{Speaker ID, `S001` to `S180`.}
#'   \item{age_group}{`"under 30"` or `"over 50"`.}
#'   \item{setting}{`"university"`, `"shop"` or `"office"`.}
#'   \item{form}{`"du"` or `"Sie"`.}
#' }
#' @details True model: the probability of *du* is 0.85 (university), 0.35
#'   (shop) and 0.45 (office) for speakers under 30, and 0.40, 0.08 and 0.15
#'   for speakers over 50.
#' @source `data-raw/address_forms.R`
#' @examples
#' table(address_forms$age_group, address_forms$form)
"address_forms"

#' Perceptual training of a non-native contrast
#'
#' 18 learners identify a non-native consonant contrast in 40 trials before
#' and after a week of perceptual training. A small paired design in wide
#' format.
#'
#' @format A tibble with 18 rows and 3 columns:
#' \describe{
#'   \item{learner}{Learner ID, `L01` to `L18`.}
#'   \item{pre}{Correct responses out of 40 before training.}
#'   \item{post}{Correct responses out of 40 after training.}
#' }
#' @details True model: binomial out of 40, with log-odds `0.4 + ability`
#'   before and `0.4 + ability + gain` after training. `ability` has SD 0.6;
#'   `gain` has mean 0.6 and SD 0.35.
#' @source `data-raw/perception_training.R`
#' @examples
#' perception_training
"perception_training"

#' Megastudy of 6000 words
#'
#' Item-level norms for 6000 words, as in large lexical decision megastudies:
#' mean RT and accuracy per word, with correlated lexical predictors. For
#' multiple regression, collinearity, non-linear effects and variable
#' importance.
#'
#' @format A tibble with 6000 rows and 8 columns:
#' \describe{
#'   \item{word}{Word ID, `w0001` to `w6000`.}
#'   \item{log_freq}{log10 frequency per million words.}
#'   \item{length}{Length in letters, 2 to 16.}
#'   \item{neighbours}{Number of orthographic neighbours.}
#'   \item{aoa}{Age of acquisition in years.}
#'   \item{concreteness}{Concreteness rating, 1 to 5.}
#'   \item{rt}{Mean lexical decision RT in ms.}
#'   \item{accuracy}{Proportion of correct responses.}
#' }
#' @details True model: `rt = 720 - 120 * plogis(log_freq - 2.5) + 9 *
#'   (length - 7) - 2 * neighbours + 10 * (aoa - 7) - 6 * (concreteness - 3) +
#'   e`, with `e` normal, SD 35 ms. The frequency effect is S-shaped: it
#'   levels off for very rare and very frequent words. Accuracy is `plogis(2.5
#'   + 0.7 * (log_freq - 2.5) - 0.2 * (aoa - 7) + e)`, with `e` SD 0.5.
#'   Frequent words are shorter, have more neighbours and are acquired
#'   earlier.
#' @source `data-raw/megastudy.R`
#' @examples
#' head(megastudy)
"megastudy"

#' f0 contours of the four Mandarin tones
#'
#' 12 speakers of Mandarin (6 female, 6 male) produce 8 syllables on each of
#' the four lexical tones; f0 is measured at 11 equally spaced points through
#' the vowel. The contours follow the textbook shapes: T1 high level (55), T2
#' rising (35), T3 low dipping (214) and T4 falling (51). For GAMMs of
#' contour shape and for speaker normalisation.
#'
#' @format A tibble with 4224 rows and 8 columns:
#' \describe{
#'   \item{speaker}{Factor, `S01` to `S12`.}
#'   \item{gender}{Factor, `"female"` or `"male"`.}
#'   \item{tone}{Factor, `"T1"` to `"T4"`.}
#'   \item{syllable}{Factor, `syl1` to `syl8`.}
#'   \item{token_id}{Factor, one level per token (`speaker.tone.syllable`).}
#'   \item{duration}{Vowel duration in ms.}
#'   \item{time}{Normalised time, 0 to 100 in steps of 10.}
#'   \item{f0}{f0 in Hz.}
#' }
#' @details True model: each tone follows a smooth curve through targets on
#'   Chao's 1-5 scale at 0, 25, 50, 75 and 100% of the vowel (T1: 5, 5, 5,
#'   4.9, 4.8; T2: 3, 2.8, 3.3, 4.2, 5; T3: 2.2, 1.6, 1, 1.3, 2.5; T4: 5, 4.6,
#'   3.7, 2.5, 1.2). One Chao level is about 2.5 semitones (by-speaker SD
#'   0.3); level 1 is about 160 Hz for female and 90 Hz for male speakers.
#'   Token offsets have SD 0.5 semitones and residuals are AR(1) with rho
#'   0.7. Mean durations are 250, 270, 300 and 220 ms for T1 to T4.
#' @source `data-raw/mandarin_tones.R`
#' @examples
#' head(mandarin_tones)
"mandarin_tones"

#' The three-way stop contrast in Seoul Korean
#'
#' Word-initial lenis, tense and aspirated stops from 20 older and 20 younger
#' speakers of Seoul Korean: VOT and the f0 of the following vowel. Older
#' speakers keep the three stops apart by VOT; younger speakers have merged
#' lenis and aspirated VOT and keep them apart by f0 instead. For cluster
#' analysis and classification, and for a sound change in progress.
#'
#' @format A tibble with 1440 rows and 8 columns:
#' \describe{
#'   \item{speaker}{Factor, `S01` to `S40`.}
#'   \item{generation}{Factor, `"older"` or `"younger"`.}
#'   \item{gender}{Factor, `"female"` or `"male"`.}
#'   \item{stop}{Factor, `"lenis"`, `"tense"` or `"aspirated"`.}
#'   \item{place}{Factor, `"labial"`, `"coronal"` or `"velar"`.}
#'   \item{rep}{Repetition, 1 to 4.}
#'   \item{vot}{Voice onset time in ms.}
#'   \item{f0}{f0 at the start of the following vowel in Hz.}
#' }
#' @details True model: mean VOT for tense, lenis and aspirated stops is 12,
#'   55 and 95 ms for older and 12, 78 and 82 ms for younger speakers, 5 ms
#'   shorter for labials and 10 ms longer for velars; token variation is
#'   log-normal (SD 0.3 for tense, 0.18 otherwise) and by-speaker SD 0.1. f0
#'   relative to the speaker's mean (about 200 Hz female, 115 Hz male) is
#'   +1.2, -1.5 and +1.5 semitones for older and +1.2, -3.5 and +2.0
#'   semitones for younger speakers, token SD 0.8 semitones. Inspired by
#'   reports of the VOT merger in younger Seoul speakers (e.g. Silva 2006);
#'   not real data.
#' @source `data-raw/korean_stops.R`
#' @examples
#' head(korean_stops)
"korean_stops"

#' Self-paced reading of German relative clauses
#'
#' 48 participants read sentences word by word, such as *Der Lehrer, der den
#' Schüler gesehen hat, lachte laut über den Witz* (subject relative) and
#' *Der Lehrer, den der Schüler gesehen hat, ...* (object relative). Object
#' relatives slow readers down at the end of the relative clause and on the
#' main verb. 24 items, two counterbalanced lists, 12 words per sentence.
#'
#' @format A tibble with 13824 rows and 8 columns:
#' \describe{
#'   \item{participant}{Participant ID, `P01` to `P48`.}
#'   \item{list}{Counterbalancing list, 1 or 2.}
#'   \item{item}{Item ID, `i01` to `i24`.}
#'   \item{condition}{Factor, `"subject"` (reference) or `"object"`
#'     relative clause.}
#'   \item{position}{Word position in the sentence, 1 to 12.}
#'   \item{region}{Role of the word: `"det"`, `"noun"`, `"rel_pronoun"`,
#'     `"rc_det"`, `"rc_noun"`, `"rc_participle"`, `"rc_auxiliary"`,
#'     `"main_verb"`, `"spillover_1"` to `"spillover_3"`, `"final"`.}
#'   \item{length}{Word length in letters.}
#'   \item{rt}{Reading time in ms.}
#' }
#' @details True model: `log(rt) = 5.85 + p0 + i0 + 0.012 * (length - 5) -
#'   0.008 * position + cost * object + e`. The object-relative cost is 0.01
#'   to 0.03 in the relative clause, 0.06 on the participle, 0.08 on the
#'   auxiliary, 0.05 on the main verb and 0.02 on the next word, with
#'   by-participant variation (SD 0.03). By-participant intercepts `p0` have
#'   SD 0.2 and by-item intercepts `i0` SD 0.04; residual SD 0.2.
#' @source `data-raw/german_relatives.R`
#' @examples
#' head(german_relatives)
"german_relatives"

#' Single-trial N400 amplitudes
#'
#' 30 participants read German sentences ending in an expected or unexpected
#' word (*Er trinkt seinen Kaffee / Schrank*). For each trial, the mean EEG
#' amplitude 300-500 ms after the final word at nine electrodes. The N400 is
#' more negative the less predictable the word (lower cloze probability), and
#' largest over centro-parietal sites. 80 items, two counterbalanced lists.
#'
#' @format A tibble with 21600 rows and 9 columns:
#' \describe{
#'   \item{participant}{Participant ID, `P01` to `P30`.}
#'   \item{list}{Counterbalancing list, 1 or 2.}
#'   \item{item}{Item ID, `i01` to `i80`.}
#'   \item{condition}{Factor, `"expected"` (reference) or `"unexpected"`.}
#'   \item{cloze}{Cloze probability of the final word.}
#'   \item{electrode}{`"F3"`, `"Fz"`, `"F4"`, `"C3"`, `"Cz"`, `"C4"`,
#'     `"P3"`, `"Pz"` or `"P4"`.}
#'   \item{anteriority}{`"frontal"`, `"central"` or `"parietal"`.}
#'   \item{laterality}{`"left"`, `"midline"` or `"right"`.}
#'   \item{amplitude}{Mean amplitude in microvolts.}
#' }
#' @details True model: `amplitude = 2 + p0 + i0 + e0 + weight * (-4 + p1) *
#'   (1 - cloze) + trial + e`. The electrode weight is 1 at Pz, 0.85 to 0.9
#'   at other parietal and central sites and 0.5 to 0.6 at frontal sites;
#'   `e0` is a small electrode offset. By-participant intercepts `p0` (SD 1.5)
#'   and N400 slopes `p1` (SD 1); by-item intercepts `i0` (SD 0.5); trial
#'   noise shared across electrodes (SD 4) and electrode noise (SD 3). Cloze
#'   is 0.5 to 0.95 for expected and 0 to 0.05 for unexpected words.
#' @source `data-raw/n400.R`
#' @examples
#' head(n400)
"n400"

#' Merging of the Cantonese rising tones
#'
#' Hong Kong Cantonese has two rising tones, T2 (high rising, 25) and T5 (low
#' rising, 23), which some younger speakers merge. 90 speakers aged 18 to 75
#' each produce 10 T2 and 10 T5 words; the size of the f0 rise is measured in
#' semitones. For a sound change in apparent time and for individual
#' differences: mergers form a separate group rather than a gradual trend.
#'
#' @format A tibble with 1800 rows and 7 columns:
#' \describe{
#'   \item{speaker}{Factor, `S01` to `S90`.}
#'   \item{age}{Age in years.}
#'   \item{gender}{Factor, `"female"` or `"male"`.}
#'   \item{word}{Factor, `w01` to `w20`.}
#'   \item{tone}{Factor, `"T2"` or `"T5"`.}
#'   \item{log_freq}{log10 word frequency, 1 to 5; no effect.}
#'   \item{rise}{f0 rise from onset to offset in semitones.}
#' }
#' @details True model: each speaker is a merger with probability `0.65 *
#'   plogis((40 - age) / 6)`. Non-mergers rise by 7 semitones in T2 and 3.5
#'   in T5; mergers by 5.6 and 4.8. By-speaker intercepts have SD 0.6 and
#'   token SD is 0.9. Inspired by reports of T2/T5 merging (e.g. Mok, Zuo &
#'   Wong 2013); not their data.
#' @source `data-raw/cantonese_tone_merger.R`
#' @examples
#' head(cantonese_tone_merger)
"cantonese_tone_merger"

#' A wug test of German noun plurals
#'
#' 60 adult native speakers of German give the plural of 48 nonce nouns,
#' each presented with its article (*der*, *die*, *das*). The plural ending
#' depends on gender and on how the noun ends: schwa-final and feminine nouns
#' mostly take *-(e)n*, nouns in *-el*/*-er* mostly no ending, masculine and
#' neuter nouns ending in a consonant mostly *-e*, and nouns ending in a full
#' vowel *-s*. Speakers differ in how readily they use *-s*. A five-way
#' outcome.
#'
#' @format A tibble with 2880 rows and 7 columns:
#' \describe{
#'   \item{participant}{Participant ID, `P01` to `P60`.}
#'   \item{item}{Item ID, `i01` to `i48`.}
#'   \item{nonce}{The nonce noun, e.g. `"Pünde"`.}
#'   \item{article}{`"der"`, `"die"` or `"das"`.}
#'   \item{gender}{Factor, `"feminine"`, `"masculine"` or `"neuter"`.}
#'   \item{final}{Factor, how the noun ends: `"-el/-er"`, `"consonant"`,
#'     `"full vowel"` or `"schwa"`.}
#'   \item{plural}{Factor, `"-e"`, `"-(e)n"`, `"-er"`, `"-s"` or
#'     `"zero"`.}
#' }
#' @details True model: each gender-by-ending cell has its own probabilities
#'   for the five endings (see `data-raw/german_plurals.R`), perturbed on the
#'   log scale by a by-participant preference for *-s* (SD 0.6) and by
#'   response-level noise (SD 0.3).
#' @source `data-raw/german_plurals.R`
#' @examples
#' table(german_plurals$final, german_plurals$plural)
"german_plurals"

#' Turn-taking in 10 languages
#'
#' The gap between the end of a yes/no question and the start of its answer,
#' in 25 question-answer pairs from each of 12 conversations in each of 10
#' languages. Negative values are overlaps. In every language, gaps cluster
#' just above zero and are skewed to the right; languages differ in their
#' average gap by a few hundred milliseconds. Disconfirmations and
#' non-answers come later; answers to a questioner who is looking at the
#' responder come sooner.
#'
#' @format A tibble with 3000 rows and 6 columns:
#' \describe{
#'   \item{language}{Factor, 10 languages.}
#'   \item{conversation}{Factor, 12 per language.}
#'   \item{response}{`"confirmation"` or `"disconfirmation"`.}
#'   \item{answer}{`"answer"` or `"non-answer"` (e.g. *I don't know*).}
#'   \item{gaze}{Whether the questioner was looking at the responder,
#'     `"yes"` or `"no"`.}
#'   \item{offset}{Time from the end of the question to the start of the
#'     answer in ms.}
#' }
#' @details True model: `offset = language_mean + c0 + 120 * disconfirmation
#'   + 250 * non-answer - 70 * gaze + e`, where `c0` is a by-conversation
#'   offset (SD 60 ms) and `e` is ex-Gaussian (a normal with SD 200 ms plus
#'   an exponential with mean 150 ms, centred). Language means range from 10
#'   ms (Japanese) to 460 ms (Danish). Loosely based on the design and
#'   findings of Stivers et al. (2009); the language means are invented, not
#'   their values.
#' @source `data-raw/turn_taking.R`
#' @examples
#' head(turn_taking)
"turn_taking"

#' Attitudes towards a regional dialect
#'
#' 320 respondents rate speakers of a regional dialect on 12 statements (1 =
#' strongly disagree, 5 = strongly agree). The items measure three correlated
#' attitudes: status, solidarity and vitality. Two items are negatively
#' worded and need reverse-coding. Dialect speakers rate solidarity and
#' vitality higher. About 2% of answers are missing. For factor analysis and
#' scale construction.
#'
#' @format A tibble with 320 rows and 15 columns:
#' \describe{
#'   \item{respondent}{Respondent ID, `R001` to `R320`.}
#'   \item{age}{Age in years.}
#'   \item{dialect_speaker}{Whether the respondent speaks the dialect,
#'     `"yes"` or `"no"`.}
#'   \item{intelligent, educated, competent, lazy}{Status items: dialect
#'     speakers sound intelligent / educated / competent / lazy. *lazy* is
#'     negatively worded.}
#'   \item{friendly, warm, trustworthy, cold}{Solidarity items. *cold* is
#'     negatively worded.}
#'   \item{used_by_young, will_survive, teach_school, identity}{Vitality
#'     items: the dialect is used by young people / will survive / should be
#'     taught at school / is important for local identity.}
#' }
#' @details True model: three latent attitudes with correlations 0.2
#'   (status-solidarity), 0.3 (status-vitality) and 0.5
#'   (solidarity-vitality). Dialect speakers score 0.6 SD higher on
#'   solidarity and 0.5 SD higher on vitality; vitality falls by 0.01 SD per
#'   year of age. Loadings are 0.55 to 0.8 (negative for *lazy* and *cold*);
#'   responses are the latent item scores cut at -1.3, -0.4, 0.4 and 1.3.
#' @source `data-raw/language_attitudes.R`
#' @examples
#' head(language_attitudes)
"language_attitudes"

#' A dialect survey of degemination in Italy
#'
#' Degemination (*gatto* pronounced with a single *t*) in the speech of 4 speakers at
#' each of 145 towns in mainland Italy and Sicily, with coordinates for
#' mapping. Northern dialects degeminate, central and southern ones keep
#' geminates, with a sharp transition along a stylised La Spezia-Rimini line
#' at about 44.1° N. Older speakers degeminate more. Each speaker reads 10
#' words with a geminate.
#'
#' @format A tibble with 580 rows and 7 columns:
#' \describe{
#'   \item{town}{Town name.}
#'   \item{lat, long}{Coordinates of the town in decimal degrees.}
#'   \item{speaker}{Speaker ID, `town_1` to `town_4`.}
#'   \item{age}{Age in years.}
#'   \item{words}{Words read with a geminate: always 10.}
#'   \item{degeminated}{Of these, words produced with a single consonant.}
#' }
#' @details True model, in log-odds: `-1.5 + 6 * (lat - 44.1) + t0 + 0.03 *
#'   (age - 50)`, with by-town intercepts `t0` (SD 0.6). Town names and
#'   coordinates are the Italian towns of over 50,000 inhabitants in
#'   `maps::world.cities` (without Sardinia); the dialect data are simulated,
#'   not real survey results.
#' @source `data-raw/dialect_survey.R`
#' @examples
#' head(dialect_survey)
"dialect_survey"
