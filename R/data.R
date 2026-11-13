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
