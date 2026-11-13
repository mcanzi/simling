devtools::load_all(".", quiet = TRUE)
library(ggplot2)

p <- ggplot(pupil_noise, aes(time, pupil, colour = condition)) +
  geom_line(aes(group = trial_id), alpha = 0.08) +
  stat_summary(fun = mean, geom = "line", linewidth = 1.2) +
  scale_colour_manual(values = c(quiet = "#4f86b5", noise = "#e0735a")) +
  labs(x = "Time from stimulus onset (ms)",
       y = "Pupil size (baseline-corrected)") +
  theme_minimal()

ggsave("man/figures/README-pupil.png", p, width = 7, height = 4, dpi = 150, bg = "white")
