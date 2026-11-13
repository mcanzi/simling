# All data sets are simulated. The code that generated each one is in
# data-raw/ (https://github.com/mcanzi/simling/tree/main/data-raw), so the
# true effects are known and listed under "True model".

#' Reaction times to high- and low-frequency words
#'
#' A simulated lexical decision task: 10 participants each respond to the same
#' 20 words, 10 of high and 10 of low frequency.
#'
#' @format A tibble with 200 rows and 5 columns:
#' \describe{
#'   \item{participant}{Participant ID, `P01` to `P10`.}
#'   \item{word}{Word ID, `w01` to `w20`.}
#'   \item{frequency}{Word frequency, `"high"` or `"low"`.}
#'   \item{rt}{Reaction time in ms.}
#'   \item{accuracy}{1 for a correct response, 0 for an error.}
#' }
#' @details True model: `rt` is normal with mean 600 ms for high- and 660 ms
#'   for low-frequency words, SD 80 ms. Accuracy is 90%. There are no
#'   participant or word effects.
#' @source `data-raw/rt_frequency.R`
#' @examples
#' head(rt_frequency)
"rt_frequency"

#' Formants of three vowels from two speakers
#'
#' F1 and F2 of /i a u/, 20 tokens per vowel from each of two speakers.
#' Speaker B has a shorter vocal tract, so all formants are 20% higher.
#'
#' @format A tibble with 120 rows and 6 columns:
#' \describe{
#'   \item{speaker}{`"A"` or `"B"`.}
#'   \item{vowel}{`"i"`, `"a"` or `"u"`.}
#'   \item{F1, F2}{First and second formant in Hz.}
#'   \item{token}{Token number, 1 to 20.}
#'   \item{k}{Scaling factor of the speaker's formants: 1 for A, 1.2 for B.}
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
#' 2000 words whose frequencies follow Zipf's law (frequency proportional to
#' 1 / rank), with a reaction time to each. Useful for log transformations.
#'
#' @format A tibble with 2000 rows and 3 columns:
#' \describe{
#'   \item{rank}{Frequency rank, 1 to 2000.}
#'   \item{freq}{Frequency per million tokens, `round(1e6 / rank)`.}
#'   \item{rt}{Reaction time in ms.}
#' }
#' @details True model: `log(rt) = 6.75 - 0.06 * log10(freq) + e`, with
#'   `e` normal, SD 0.18.
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
#' @details True model: `rt = 760 - 30 * log_freq + 14 * length + e`, with
#'   `e` normal, SD 45 ms. Syllables have no effect of their own.
#' @source `data-raw/word_rt.R`
#' @examples
#' head(word_rt)
"word_rt"

#' Vowel duration before voiced and voiceless consonants
#'
#' A simulated production study: 60 vowels before voiceless consonants
#' (*beat*) and 60 before voiced ones (*bead*).
#'
#' @format A tibble with 120 rows and 2 columns:
#' \describe{
#'   \item{voicing}{Voicing of the following consonant, `"voiceless"` or
#'     `"voiced"` (character, so `"voiced"` is the reference level in
#'     `lm()` unless releveled).}
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
#' @details True model: `rt = 700 - 25 * log_freq` for L1 and
#'   `900 - 55 * log_freq` for L2 speakers, plus normal noise with SD 40 ms.
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
#' @details True model: `rt = 760 - 30 * lf_c + 14 * len_c - 5 * lf_c * len_c
#'   + e`, with `e` normal, SD 40 ms.
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
#' @details True model: `rt = 650 + u0 + w0 + (-30 + u1) * freq_c + e`.
#'   By-participant intercepts `u0` have SD 70 ms and slopes `u1` SD 18 ms,
#'   correlated at -0.6; by-word intercepts `w0` have SD 30 ms; residual SD
#'   50 ms. Not to be confused with `languageR::lexdec`, which is real data.
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

#' Lexical decision accuracy
#'
#' 30 participants each respond to the same 60 words; the outcome is whether
#' the response was correct. For mixed-effects logistic regression.
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

#' Lexical decision by L1 and L2 speakers
#'
#' 30 participants (15 L1 and 15 L2 speakers of English) each respond to the
#' same 40 words. L2 speakers are slower and more sensitive to frequency.
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
#' @details True model: `rt = 700 + 120 * L2 + p0 + w0 + slope * (log_freq -
#'   3.5) + 12 * (length - 7) + e`, where `slope = -25 - 25 * L2 + p1`.
#'   By-participant intercepts `p0` have SD 60 ms and slopes `p1` SD 12 ms;
#'   by-word intercepts `w0` have SD 30 ms; residual SD 70 ms.
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
#'   VOT, 1.6 vs 1.2 vowel ratio and 5.2 vs 4.7 syllables/s; f0 is 210 Hz for
#'   female and 120 Hz for male speakers. H1-H2 varies by speaker only and
#'   intensity by token only.
#' @source `data-raw/accent.R`
#' @examples
#' head(accent)
"accent"

#' A pilot lexical decision study for power analysis
#'
#' 30 participants in two groups each respond to the same 40 words. Meant as
#' the pilot data from which to simulate a larger study.
#'
#' @format A tibble with 1200 rows and 5 columns:
#' \describe{
#'   \item{participant}{Factor, `P01` to `P30`.}
#'   \item{group}{Group, contrast-coded as -0.5 and 0.5.}
#'   \item{word}{Factor, `w01` to `w40`.}
#'   \item{freq_c}{Centred log10 word frequency, about -2.5 to 2.5.}
#'   \item{rt}{Reaction time in ms.}
#' }
#' @details True model: `rt = 750 + 120 * group + p0 + w0 + (-30 - 20 * group
#'   + p1) * freq_c + e`. By-participant intercepts `p0` have SD 60 ms and
#'   slopes `p1` SD 12 ms; by-word intercepts `w0` have SD 30 ms; residual SD
#'   70 ms.
#' @source `data-raw/pilot_rt.R`
#' @examples
#' head(pilot_rt)
"pilot_rt"

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
#' objects, only one of them edible. After a restrictive verb (*eat*) they
#' look at the target before the noun is heard. Looks to the target in 50 ms
#' bins from verb onset; the noun starts at 600 ms. 32 participants, 24
#' items, 12 per condition (two counterbalanced lists).
#'
#' @format A tibble with 23040 rows and 7 columns:
#' \describe{
#'   \item{participant}{Participant ID, `P01` to `P32`.}
#'   \item{list}{Counterbalancing list, 1 or 2.}
#'   \item{item}{Item ID, `i01` to `i24`.}
#'   \item{condition}{`"restrictive"` or `"non-restrictive"` verb.}
#'   \item{time}{Start of the 50 ms bin, ms from verb onset, 0 to 1450.}
#'   \item{target}{Eye-tracker samples on the target in this bin.}
#'   \item{samples}{Samples per bin: always 25 (500 Hz).}
#' }
#' @details True model: on the logit scale, looks to the target rise from
#'   chance (0.25) to about 0.88 along a logistic curve with width 90 ms,
#'   centred at 650 ms after restrictive and 900 ms after non-restrictive
#'   verbs. By-participant variation in the centre (SD 80 ms) and in the final
#'   level (SD 0.3 logits); by-item variation in the centre (SD 40 ms). Within
#'   a trial, deviations are AR(1) with rho 0.9.
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
#' from 12 to 30 months, for 80 children. Growth is S-shaped, and children
#' who hear more speech start their vocabulary spurt earlier. About 10% of
#' sessions are missing.
#'
#' @format A tibble with 715 rows and 4 columns:
#' \describe{
#'   \item{child}{Child ID, `C01` to `C80`.}
#'   \item{input}{Adult words per hour heard at home (one value per child).}
#'   \item{age}{Age in months.}
#'   \item{vocabulary}{Number of words produced, out of 680.}
#' }
#' @details True model: `vocabulary` is binomial out of 680 with probability
#'   `plogis((age - mid) / 2.8)`, where `mid = 23 - 2 * log2(input / 1200)`
#'   plus a by-child deviation (SD 1.8 months), and session-level noise on
#'   the logit scale (SD 0.15). Doubling the input moves the spurt 2 months
#'   earlier.
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
#' 400 invented languages from 60 invented families in six invented areas.
#' Languages mostly inherit their family's word order, so observations are
#' not independent. Adposition order and case marking correlate with word
#' order, in the spirit of Greenberg's universals. Family sizes are skewed:
#' a few large families and many small ones.
#'
#' @format A tibble with 400 rows and 8 columns:
#' \describe{
#'   \item{language}{Language ID, `L001` to `L400`.}
#'   \item{family}{`"Family 01"` to `"Family 60"`.}
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
#'   inventories are 3 plus a Poisson count (mean 2.5). All names and figures
#'   are invented, not real typological data.
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
