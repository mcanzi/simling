devtools::load_all(".", quiet = TRUE)
library(ggplot2)

p <- ggplot(pupil_noise, aes(time, pupil, colour = condition)) +
  geom_line(aes(group = trial_id), alpha = 0.08) +
  stat_summary(fun = mean, geom = "line", linewidth = 1.2) +
  scale_colour_manual(values = c(quiet = "#4f86b5", noise = "#e0735a")) +
  labs(x = "Time from stimulus onset (ms)",
       y = "Pupil size (baseline-corrected)") +
  theme_minimal()

glacier <- p +
  scale_colour_manual(values = c(quiet = "#a9cbe0", noise = "#f2917a")) +
  theme(text = element_text(colour = "#dfe6ea"),
        axis.text = element_text(colour = "#98a8b3"),
        panel.grid = element_line(colour = "#34444f"),
        plot.background = element_rect(fill = "#1e2830", colour = NA))

ggsave("man/figures/README-pupil.png", glacier, width = 7, height = 4, dpi = 150)
