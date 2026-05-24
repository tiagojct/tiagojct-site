# Sample figures for the scientific writing note.
# Illustrates common data-visualisation errors and a publication-ready
# counterpart, using a fictional acute heart failure cohort (NT-proBNP
# at discharge compared between readmitted and non-readmitted patients).
#
# Run from the repo root:
#   Rscript notes/sw/figures.R

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
})

set.seed(42)
n <- 200

# NT-proBNP is highly right-skewed in heart failure cohorts.
# Simulate on a log-normal scale to keep this realistic.
d <- data.frame(
  group    = rep(c("Readmitted", "Not readmitted"), each = n),
  ntprobnp = c(rlnorm(n, meanlog = log(1500), sdlog = 0.65),
               rlnorm(n, meanlog = log(700),  sdlog = 0.60))
)
# Cap at a plausible upper bound
d$ntprobnp <- pmin(d$ntprobnp, 10000)

summary_df <- d |>
  group_by(group) |>
  summarise(mean = mean(ntprobnp), sd = sd(ntprobnp), .groups = "drop")

out <- "notes/sw/figures"
dir.create(out, recursive = TRUE, showWarnings = FALSE)

# 1. UGLY — defaults, harsh colours, no proper labels. Technically correct.
png(file.path(out, "01-ugly.png"), width = 1000, height = 750, res = 150)
par(mar = c(4, 4, 3, 1))
boxplot(ntprobnp ~ group, data = d,
        col  = c("red", "green"),
        main = "ntprobnp vs group",
        xlab = "", ylab = "")
dev.off()

# 2. BAD — bar + SD on a skewed continuous outcome. Hides that the
#    distribution is log-normal, not symmetric; bars imply a symmetric
#    sampling distribution that does not exist here.
p_bar <- ggplot(summary_df, aes(x = group, y = mean, fill = group)) +
  geom_col(width = 0.6) +
  geom_errorbar(aes(ymin = pmax(mean - sd, 0), ymax = mean + sd),
                width = 0.15) +
  scale_fill_manual(values = c("#E69F9F", "#9FCF9F")) +
  labs(x = NULL, y = "Mean NT-proBNP (\u00B1 SD), pg/mL",
       title = "Bad: bar + SD on a skewed outcome hides the distribution") +
  theme_minimal(base_size = 12) +
  theme(legend.position = "none")
ggsave(file.path(out, "02-bad-bar.png"), p_bar,
       width = 6, height = 4, dpi = 150)

# 3. BAD — truncated y-axis exaggerates a SMALL real difference.
#    Separate scenario: a ~15% between-group difference (1000 vs 1150 pg/mL,
#    clinically modest) is made to look like a 4x effect by starting the
#    axis near the smaller bar instead of at zero.
trunc_df <- data.frame(
  group = factor(c("Not readmitted", "Readmitted"),
                 levels = c("Not readmitted", "Readmitted")),
  mean  = c(1000, 1150)
)

p_trunc <- ggplot(trunc_df, aes(x = group, y = mean, fill = group)) +
  geom_col(width = 0.6) +
  coord_cartesian(ylim = c(950, 1200)) +
  scale_fill_manual(values = c("#E69F9F", "#9FCF9F")) +
  labs(x = NULL, y = "Mean NT-proBNP (pg/mL)",
       title = "Bad: truncated y-axis exaggerates a small difference") +
  theme_minimal(base_size = 12) +
  theme(legend.position = "none")
ggsave(file.path(out, "03-bad-truncated.png"), p_trunc,
       width = 6, height = 4, dpi = 150)

# 4. GOOD — boxplot + jittered raw data, site palette (softsage + warmtaupe),
#    log-scaled y-axis (appropriate for a right-skewed biomarker), and a
#    clear caption. Complementary hues that also differ in lightness, so
#    the contrast survives greyscale printing and deuteranopia.
site_palette <- c("Not readmitted" = "#7A9B9E",   # softsage
                  "Readmitted"     = "#C4A57B")   # warmtaupe

p_good <- ggplot(d, aes(x = group, y = ntprobnp, fill = group)) +
  geom_boxplot(outlier.shape = NA, width = 0.5, alpha = 0.85,
               colour = "#2C3E50") +            # deepnavy outline
  geom_jitter(width = 0.15, alpha = 0.35, size = 1, colour = "#2C3E50") +
  scale_fill_manual(values = site_palette) +
  scale_y_log10(breaks = c(100, 300, 1000, 3000, 10000),
                labels = c("100", "300", "1,000", "3,000", "10,000")) +
  labs(
    x = NULL,
    y = "NT-proBNP at discharge (pg/mL, log scale)",
    caption = paste(
      "Boxes: median and IQR. Whiskers: 1.5 \u00D7 IQR. Points: individual patients.",
      "n = 200 per group."
    )
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position  = "none",
        plot.caption     = element_text(hjust = 0, size = 9,
                                        colour = "#2C3E50"),
        axis.title       = element_text(colour = "#2C3E50"),
        axis.text        = element_text(colour = "#2C3E50"))
ggsave(file.path(out, "04-good.png"), p_good,
       width = 6, height = 4, dpi = 150)

# 5 + 6. "Overkill": visualising a single proportion ("83% female")
#   as a pie chart or a two-bar chart. Both waste space compared with
#   writing "Participants were mostly female, 3,300 (83%)" in prose.
sex_df <- data.frame(
  sex = factor(c("Female", "Male"), levels = c("Female", "Male")),
  n   = c(3300, 676)
)
sex_df$pct <- sex_df$n / sum(sex_df$n) * 100

p_pie <- ggplot(sex_df, aes(x = "", y = n, fill = sex)) +
  geom_col(width = 1, colour = "white") +
  coord_polar(theta = "y") +
  scale_fill_manual(values = c("Female" = "#7A9B9E", "Male" = "#C4A57B")) +
  labs(title = "Overkill: pie chart for one proportion", fill = NULL) +
  theme_void(base_size = 12) +
  theme(plot.title      = element_text(hjust = 0.5, colour = "#2C3E50"),
        legend.position = "right",
        legend.text     = element_text(colour = "#2C3E50"))
ggsave(file.path(out, "05-pie-overkill.png"), p_pie,
       width = 5, height = 4, dpi = 150)

p_bar_prop <- ggplot(sex_df, aes(x = sex, y = pct, fill = sex)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = sprintf("%.0f%%", pct)), vjust = -0.4,
            colour = "#2C3E50", size = 4) +
  scale_fill_manual(values = c("Female" = "#7A9B9E", "Male" = "#C4A57B")) +
  scale_y_continuous(limits = c(0, 100), expand = expansion(mult = c(0, 0.08))) +
  labs(title = "Overkill: bar chart for one proportion",
       x = NULL, y = "Percentage of participants (%)") +
  theme_minimal(base_size = 12) +
  theme(legend.position = "none",
        plot.title   = element_text(colour = "#2C3E50"),
        axis.title   = element_text(colour = "#2C3E50"),
        axis.text    = element_text(colour = "#2C3E50"))
ggsave(file.path(out, "06-bar-overkill.png"), p_bar_prop,
       width = 5, height = 4, dpi = 150)

message("Wrote figures to ", out, "/")
