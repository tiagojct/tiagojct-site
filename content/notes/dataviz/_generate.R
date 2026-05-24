## _generate.R — fictional hypertension cohort + figures for the
## data-visualisation primer at notes/dataviz/index.qmd.
##
## Run once locally; commits the PNGs (and figures/cohort.csv) into
## figures/. The note's R code blocks are deliberate excerpts of what
## happens here, so any edit to a chunk should be mirrored in both
## places.
##
##   Rscript notes/dataviz/_generate.R

suppressPackageStartupMessages({
  library(pequod)
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(scales)
})

set.seed(11)  # Pequod's house seed.

# ── 1. The cohort ──────────────────────────────────────────────────────

n <- 600

cohort <- tibble(
  id     = seq_len(n),
  age    = pmin(85, pmax(30, round(rnorm(n, 58, 12)))),
  sex    = factor(sample(c("F", "M"), n, replace = TRUE, prob = c(0.55, 0.45))),
  region = factor(sample(c("North", "Centre", "South", "Islands"), n,
                         replace = TRUE, prob = c(0.42, 0.30, 0.20, 0.08))),
  bmi    = round(rnorm(n, 28, 4.5), 1),
  comorbidities = pmin(4L, rpois(n, 1.2)),
  treatment = factor(sample(c("Placebo", "ACEi", "ARB", "CCB"), n,
                            replace = TRUE, prob = c(0.20, 0.30, 0.25, 0.25)),
                     levels = c("Placebo", "ACEi", "ARB", "CCB")),
  sbp_baseline = pmin(200, pmax(120, round(rnorm(n, 148, 16)))),
  dbp_baseline = pmin(120, pmax(70,  round(rnorm(n, 90, 10)))),
  follow_up_months = pmin(24L, pmax(3L, round(runif(n, 3, 24))))
)

# Treatment-specific 6-month effects (placebo is regression to the mean only)
trt_shift_sbp <- c(Placebo = 3, ACEi = 14, ARB = 12, CCB = 11)
trt_shift_dbp <- c(Placebo = 1, ACEi =  8, ARB = 7,  CCB = 6)

cohort <- cohort |>
  mutate(
    sbp_6m = round(sbp_baseline - trt_shift_sbp[treatment] + rnorm(n, 0, 6)),
    dbp_6m = round(dbp_baseline - trt_shift_dbp[treatment] + rnorm(n, 0, 4)),
    delta_sbp = sbp_baseline - sbp_6m,
    delta_dbp = dbp_baseline - dbp_6m,
    controlled_6m = sbp_6m < 140 & dbp_6m < 90,
    bp_class_6m = factor(case_when(
      sbp_6m < 130 & dbp_6m < 80                      ~ "Normal",
      sbp_6m < 140 & dbp_6m < 90                      ~ "Pre-hypertension",
      sbp_6m < 160 & dbp_6m < 100                     ~ "Stage 1",
      TRUE                                            ~ "Stage 2"
    ), levels = c("Normal", "Pre-hypertension", "Stage 1", "Stage 2"))
  )

OUT <- file.path("notes", "dataviz", "figures")
if (!dir.exists(OUT)) dir.create(OUT, recursive = TRUE)
write.csv(cohort, file.path(OUT, "cohort.csv"), row.names = FALSE)

# ── theme / helpers ────────────────────────────────────────────────────

PAPER       <- pequod_log[["Log 50"]]
PAPER_TEXT  <- pequod_log[["Log 800"]]
INK         <- pequod_log[["Log 950"]]
INK_TEXT    <- pequod_log[["Log 100"]]
MUTED_LIGHT <- pequod_log[["Log 600"]]
MUTED_DARK  <- pequod_log[["Log 300"]]
GRID_LIGHT  <- pequod_log[["Log 200"]]
GRID_DARK   <- pequod_log[["Log 800"]]

base_family <- "Atkinson Hyperlegible Next"
mono_family <- "JetBrains Mono"

theme_paper <- function() {
  theme_minimal(base_family = base_family) +
    theme(
      plot.background  = element_rect(fill = PAPER, colour = NA),
      panel.background = element_rect(fill = PAPER, colour = NA),
      panel.grid.major = element_line(colour = GRID_LIGHT, linewidth = 0.3),
      panel.grid.minor = element_blank(),
      axis.text  = element_text(colour = MUTED_LIGHT, family = mono_family),
      axis.title = element_text(colour = PAPER_TEXT),
      plot.title = element_text(colour = PAPER_TEXT, face = "bold",
                                hjust = 0, margin = margin(b = 12)),
      plot.subtitle = element_text(colour = MUTED_LIGHT, hjust = 0,
                                   margin = margin(b = 14)),
      strip.text = element_text(colour = PAPER_TEXT, face = "bold")
    )
}

theme_ink <- function() {
  theme_minimal(base_family = base_family) +
    theme(
      plot.background  = element_rect(fill = INK, colour = NA),
      panel.background = element_rect(fill = INK, colour = NA),
      panel.grid.major = element_line(colour = GRID_DARK, linewidth = 0.3),
      panel.grid.minor = element_blank(),
      axis.text  = element_text(colour = MUTED_DARK, family = mono_family),
      axis.title = element_text(colour = INK_TEXT),
      plot.title = element_text(colour = INK_TEXT, face = "bold",
                                hjust = 0, margin = margin(b = 12)),
      plot.subtitle = element_text(colour = MUTED_DARK, hjust = 0,
                                   margin = margin(b = 14)),
      strip.text = element_text(colour = INK_TEXT, face = "bold")
    )
}

save_fig <- function(name, plot, w = 6.4, h = 4.0, dpi = 200) {
  ggsave(file.path(OUT, name), plot, width = w, height = h,
         dpi = dpi, bg = "transparent")
  message("wrote ", name)
}

# ── §5.1 Pie vs ordered bar ───────────────────────────────────────────

bp_counts <- cohort |>
  count(bp_class_6m) |>
  mutate(pct = n / sum(n))

p1_bad <- ggplot(bp_counts, aes("", n, fill = bp_class_6m)) +
  geom_col(width = 1, colour = PAPER) +
  coord_polar(theta = "y") +
  scale_fill_pequod_d(palette = "crew") +
  labs(title = "BP class at 6 months",
       fill = NULL, x = NULL, y = NULL) +
  theme_paper() +
  theme(
    axis.text  = element_blank(),
    panel.grid = element_blank(),
    legend.position = "right"
  )

save_fig("01-pie-bad.png", p1_bad)

p1_good <- ggplot(bp_counts, aes(reorder(bp_class_6m, n), n)) +
  geom_col(fill = pequod_crew_dark[["Starbuck"]], width = 0.7) +
  geom_text(aes(label = sprintf("%d  (%.0f%%)", n, 100 * pct)),
            hjust = -0.15, family = mono_family, size = 3.4,
            colour = PAPER_TEXT) +
  coord_flip(clip = "off") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.32))) +
  labs(title = "BP class at 6 months",
       subtitle = "Ordered by frequency; one bar, one number, one comparison.",
       x = NULL, y = "Participants (n)") +
  theme_paper() +
  theme(panel.grid.major.y = element_blank())

save_fig("01-bar-good.png", p1_good)

# ── §5.2 Rainbow heatmap vs sequential ramp ───────────────────────────

# Continuous variable to plot: mean delta_sbp by age band × bmi band.
heat <- cohort |>
  mutate(
    age_band = cut(age, breaks = c(29, 45, 55, 65, 75, 86),
                   include.lowest = TRUE,
                   labels = c("30-44", "45-54", "55-64", "65-74", "75-85")),
    bmi_band = cut(bmi, breaks = c(0, 22, 25, 30, 35, 100),
                   include.lowest = TRUE,
                   labels = c("<22", "22-25", "25-30", "30-35", ">35"))
  ) |>
  group_by(age_band, bmi_band) |>
  summarise(delta = mean(delta_sbp), n = n(), .groups = "drop") |>
  filter(!is.na(age_band), !is.na(bmi_band))

# Rainbow uses base R's classic rainbow().
rainbow_hex <- rainbow(11)

p2_ugly <- ggplot(heat, aes(bmi_band, age_band, fill = delta)) +
  geom_tile(colour = "white", linewidth = 0.4) +
  scale_fill_gradientn(colours = rainbow_hex, name = "Δ SBP") +
  labs(title = "Mean SBP reduction by age and BMI band",
       subtitle = "Rainbow palette: non-monotonic luminance, fights the eye.",
       x = "BMI band (kg/m²)", y = "Age band (years)") +
  theme_paper()

save_fig("02-rainbow-ugly.png", p2_ugly)

p2_good <- ggplot(heat, aes(bmi_band, age_band, fill = delta)) +
  geom_tile(colour = PAPER, linewidth = 0.4) +
  scale_fill_pequod_c(palette = "log-cool", name = "Δ SBP\n(mmHg)") +
  geom_text(aes(label = sprintf("%.1f", delta),
                colour = delta > mean(range(heat$delta, na.rm = TRUE))),
            family = mono_family, size = 3.1, show.legend = FALSE) +
  scale_colour_manual(values = c(`TRUE` = INK_TEXT, `FALSE` = PAPER_TEXT)) +
  labs(title = "Mean SBP reduction by age and BMI band",
       subtitle = "Sequential ramp: luminance maps directly to magnitude.",
       x = "BMI band (kg/m²)", y = "Age band (years)") +
  theme_paper()

save_fig("02-sequential-good.png", p2_good)

# ── §5.3 Truncated y-axis vs honest baseline ──────────────────────────

trt_summary <- cohort |>
  group_by(treatment) |>
  summarise(
    sbp_6m_mean = mean(sbp_6m),
    se = sd(sbp_6m) / sqrt(n()),
    .groups = "drop"
  )

p3_wrong <- ggplot(trt_summary, aes(treatment, sbp_6m_mean)) +
  geom_col(fill = pequod_crew_dark[["Ahab"]], width = 0.65) +
  geom_errorbar(aes(ymin = sbp_6m_mean - se, ymax = sbp_6m_mean + se),
                width = 0.15, colour = PAPER_TEXT) +
  coord_cartesian(ylim = c(132, 146)) +   # truncated!
  labs(title = "Mean SBP at 6 months",
       subtitle = "y-axis starts at 132 — a 10-mmHg gap looks like a chasm.",
       x = NULL, y = "SBP (mmHg)") +
  theme_paper()

save_fig("03-truncated-wrong.png", p3_wrong)

p3_good <- ggplot(trt_summary, aes(treatment, sbp_6m_mean)) +
  geom_col(fill = pequod_crew_dark[["Ahab"]], width = 0.65) +
  geom_errorbar(aes(ymin = sbp_6m_mean - se, ymax = sbp_6m_mean + se),
                width = 0.15, colour = PAPER_TEXT) +
  geom_text(aes(label = sprintf("%.1f", sbp_6m_mean)),
            vjust = -1.6, family = mono_family, colour = PAPER_TEXT,
            size = 3.4) +
  scale_y_continuous(limits = c(0, 160), expand = expansion(mult = c(0, 0.05))) +
  labs(title = "Mean SBP at 6 months",
       subtitle = "Zero-anchored axis — the eye reads proportional differences honestly.",
       x = NULL, y = "SBP (mmHg)") +
  theme_paper()

save_fig("03-honest-good.png", p3_good)

# ── §5.4 3D-style donut vs 2D dot plot ────────────────────────────────

# Treatment counts by control status.
ctrl <- cohort |>
  count(treatment, controlled_6m) |>
  group_by(treatment) |>
  mutate(pct = n / sum(n)) |>
  ungroup() |>
  filter(controlled_6m)

# A faux-3D donut: stacked bar in polar projection with a hole and a
# heavy fill gradient that distorts comparison.
ctrl_full <- cohort |>
  count(treatment, controlled_6m) |>
  group_by(treatment) |>
  mutate(pct = n / sum(n))

p4_ugly <- ggplot(ctrl_full,
                  aes(x = 2, y = pct, fill = controlled_6m)) +
  geom_col(width = 1, colour = PAPER) +
  coord_polar(theta = "y", start = 0) +
  facet_wrap(~ treatment, nrow = 1) +
  xlim(0.4, 2.5) +
  scale_fill_manual(values = c(`FALSE` = pequod_crew_light[["Stubb"]],
                               `TRUE`  = pequod_crew_dark[["Queequeg"]]),
                    name = "Controlled") +
  labs(title = "Proportion controlled at 6 months",
       subtitle = "Donuts in a row: angle judgement is harder than length.") +
  theme_paper() +
  theme(
    axis.text  = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    legend.position = "bottom"
  )

save_fig("04-3d-ugly.png", p4_ugly, w = 7.2, h = 3.6)

p4_good <- ggplot(ctrl, aes(reorder(treatment, pct), pct)) +
  geom_segment(aes(xend = treatment, y = 0, yend = pct),
               colour = pequod_log[["Log 300"]], linewidth = 0.5) +
  geom_point(colour = pequod_crew_dark[["Queequeg"]], size = 4.2) +
  geom_text(aes(label = scales::percent(pct, accuracy = 1)),
            hjust = -0.5, family = mono_family, size = 3.4,
            colour = PAPER_TEXT) +
  coord_flip() +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1),
                     limits = c(0, 1),
                     expand = expansion(mult = c(0, 0.12))) +
  labs(title = "Proportion controlled at 6 months",
       subtitle = "Dot plot: position on a common scale, sortable by effect.",
       x = NULL, y = "Controlled (%)") +
  theme_paper() +
  theme(panel.grid.major.y = element_blank())

save_fig("04-dotplot-good.png", p4_good)

# ── §5.5 Dual-axis vs small multiples ─────────────────────────────────

# Aggregate by age band: mean SBP at 6m and mean BMI.
da <- cohort |>
  mutate(age_band = cut(age, breaks = c(30, 45, 55, 65, 75, 85),
                        include.lowest = TRUE,
                        labels = c("30-44", "45-54", "55-64", "65-74", "75-85"))) |>
  group_by(age_band) |>
  summarise(sbp = mean(sbp_6m), bmi = mean(bmi), .groups = "drop")

# Dual-axis trick: scale BMI to look like SBP.
sbp_range <- range(da$sbp)
bmi_range <- range(da$bmi)
scale_bmi <- function(x) (x - bmi_range[1]) / diff(bmi_range) *
  diff(sbp_range) + sbp_range[1]
unscale_bmi <- function(y) (y - sbp_range[1]) / diff(sbp_range) *
  diff(bmi_range) + bmi_range[1]

p5_bad <- ggplot(da, aes(age_band, group = 1)) +
  geom_line(aes(y = sbp, colour = "SBP"), linewidth = 1.2) +
  geom_point(aes(y = sbp, colour = "SBP"), size = 2.5) +
  geom_line(aes(y = scale_bmi(bmi), colour = "BMI"), linewidth = 1.2) +
  geom_point(aes(y = scale_bmi(bmi), colour = "BMI"), size = 2.5) +
  scale_y_continuous(
    name = "SBP at 6m (mmHg)",
    sec.axis = sec_axis(~ unscale_bmi(.), name = "BMI (kg/m²)")
  ) +
  scale_colour_manual(values = c(SBP = pequod_crew_dark[["Ahab"]],
                                 BMI = pequod_crew_dark[["Starbuck"]]),
                      name = NULL) +
  labs(title = "SBP and BMI by age band",
       subtitle = "Two y-axes invent a correlation that is not in the data.",
       x = "Age band (years)") +
  theme_paper() +
  theme(legend.position = "bottom")

save_fig("05-dualaxis-bad.png", p5_bad)

da_long <- da |>
  pivot_longer(c(sbp, bmi), names_to = "metric", values_to = "value") |>
  mutate(metric = recode(metric,
                         sbp = "SBP at 6m (mmHg)",
                         bmi = "BMI (kg/m²)"))

p5_good <- ggplot(da_long, aes(age_band, value, group = 1)) +
  geom_line(colour = pequod_crew_dark[["Ahab"]], linewidth = 1.1) +
  geom_point(colour = pequod_crew_dark[["Ahab"]], size = 2.4) +
  facet_wrap(~ metric, scales = "free_y", ncol = 2) +
  labs(title = "SBP and BMI by age band",
       subtitle = "Small multiples: each scale on its own panel, no false correlation.",
       x = "Age band (years)", y = NULL) +
  theme_paper()

save_fig("05-smallmult-good.png", p5_good, w = 7.2)

# ── §5.6 Mean ± SE bar vs distribution ────────────────────────────────

p6_bad <- ggplot(cohort, aes(treatment, sbp_6m)) +
  stat_summary(fun = mean, geom = "col", width = 0.6,
               fill = pequod_crew_light[["Tashtego"]]) +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.18,
               colour = PAPER_TEXT) +
  labs(title = "SBP at 6 months by treatment",
       subtitle = "Mean ± SE bar — the distribution is invisible, the n is invisible.",
       x = NULL, y = "SBP (mmHg)") +
  scale_y_continuous(limits = c(0, NA),
                     expand = expansion(mult = c(0, 0.05))) +
  theme_paper()

save_fig("06-bar-mean-bad.png", p6_bad)

p6_good <- ggplot(cohort, aes(treatment, sbp_6m, colour = treatment)) +
  geom_jitter(width = 0.18, alpha = 0.25, size = 1.4) +
  geom_boxplot(width = 0.4, fill = NA, outlier.shape = NA, linewidth = 0.6) +
  stat_summary(fun = median, geom = "point", shape = 18, size = 3.2,
               colour = PAPER_TEXT) +
  scale_colour_pequod_d(palette = "crew") +
  labs(title = "SBP at 6 months by treatment",
       subtitle = "Box + jittered points: distribution, sample, outliers all visible.",
       x = NULL, y = "SBP (mmHg)") +
  theme_paper() +
  theme(legend.position = "none")

save_fig("06-distribution-good.png", p6_good)

# ── §5.7 Spaghetti vs small multiples by treatment ────────────────────

# Synthetic 4-timepoint trajectories: baseline, 1m, 3m, 6m.
traj <- cohort |>
  slice_sample(n = 120) |>     # subsample so spaghetti has fewer strands
  mutate(t0 = sbp_baseline,
         t1 = sbp_baseline - trt_shift_sbp[treatment] * 0.4 +
              rnorm(n(), 0, 6),
         t3 = sbp_baseline - trt_shift_sbp[treatment] * 0.7 +
              rnorm(n(), 0, 6),
         t6 = sbp_6m) |>
  pivot_longer(c(t0, t1, t3, t6),
               names_to = "month", values_to = "sbp") |>
  mutate(month = recode(month, t0 = 0L, t1 = 1L, t3 = 3L, t6 = 6L))

p7_ugly <- ggplot(traj, aes(month, sbp, group = id, colour = treatment)) +
  geom_line(alpha = 0.35, linewidth = 0.45) +
  scale_colour_pequod_d(palette = "crew") +
  scale_x_continuous(breaks = c(0, 1, 3, 6)) +
  labs(title = "SBP trajectories",
       subtitle = "All 120 lines on one panel — patterns drown in the noise.",
       x = "Months from baseline", y = "SBP (mmHg)", colour = NULL) +
  theme_paper() +
  theme(legend.position = "bottom")

save_fig("07-spaghetti-ugly.png", p7_ugly, w = 6.8, h = 4.2)

traj_summary <- traj |>
  group_by(treatment, month) |>
  summarise(sbp = mean(sbp), .groups = "drop")

p7_good <- ggplot(mapping = aes(month, sbp)) +
  geom_line(data = traj, aes(group = id),
            colour = MUTED_LIGHT, alpha = 0.35, linewidth = 0.4) +
  geom_line(data = traj_summary, aes(group = treatment, colour = treatment),
            linewidth = 1.4) +
  geom_point(data = traj_summary, aes(colour = treatment), size = 2.4) +
  scale_colour_pequod_d(palette = "crew") +
  scale_x_continuous(breaks = c(0, 1, 3, 6)) +
  facet_wrap(~ treatment, nrow = 1) +
  labs(title = "SBP trajectories by treatment",
       subtitle = "Small multiples + group mean — the signal stands out, the spread stays.",
       x = "Months from baseline", y = "SBP (mmHg)", colour = NULL) +
  theme_paper() +
  theme(legend.position = "none")

save_fig("07-smallmult-mean-good.png", p7_good, w = 8.0, h = 3.8)

# ── Hero ───────────────────────────────────────────────────────────────

# Variant of 07-good without the per-id grey lines; punchier.
hero <- ggplot(traj_summary, aes(month, sbp, colour = treatment)) +
  geom_line(linewidth = 1.4) +
  geom_point(size = 2.6) +
  scale_colour_pequod_d(palette = "crew") +
  scale_x_continuous(breaks = c(0, 1, 3, 6)) +
  labs(title = "Mean SBP by treatment over six months",
       subtitle = "Pequod accents on Log 50 paper. Hypertension cohort, simulated.",
       x = "Months from baseline", y = "SBP (mmHg)", colour = NULL) +
  theme_paper() +
  theme(legend.position = "right")

save_fig("hero.png", hero, w = 8.4, h = 4.4)

# ── Common chart types (directory) ────────────────────────────────────

## type-01 Histogram + density: one variable's distribution
type01 <- ggplot(cohort, aes(sbp_baseline)) +
  geom_histogram(aes(y = after_stat(density)),
                 binwidth = 5, fill = pequod_crew_light[["Starbuck"]],
                 colour = PAPER, linewidth = 0.4) +
  geom_density(colour = pequod_crew_dark[["Ahab"]], linewidth = 1.0) +
  labs(title = "Histogram + density: SBP at baseline",
       subtitle = "Bin width 5 mmHg; density curve smooths the silhouette.",
       x = "SBP at baseline (mmHg)", y = "Density") +
  theme_paper()

save_fig("type-01-histogram.png", type01, w = 7.0, h = 3.6)

## type-02 Boxplot + strip + violin: distribution by group
type02 <- ggplot(cohort, aes(treatment, dbp_baseline, colour = treatment,
                             fill = treatment)) +
  geom_violin(alpha = 0.18, linewidth = 0.4) +
  geom_jitter(width = 0.16, alpha = 0.30, size = 1.3) +
  geom_boxplot(width = 0.18, fill = NA, outlier.shape = NA, linewidth = 0.5) +
  scale_colour_pequod_d(palette = "crew") +
  scale_fill_pequod_d(palette = "crew") +
  labs(title = "Box + strip + violin: DBP at baseline by treatment arm",
       subtitle = "Layered: violin for shape, box for quartiles, dots for n and outliers.",
       x = NULL, y = "DBP at baseline (mmHg)") +
  theme_paper() +
  theme(legend.position = "none")

save_fig("type-02-distribution.png", type02, w = 7.0, h = 4.0)

## type-03 Scatter with regression line
type03 <- ggplot(cohort, aes(sbp_baseline, dbp_baseline)) +
  geom_point(alpha = 0.30, colour = pequod_crew_dark[["Queequeg"]],
             size = 1.4) +
  geom_smooth(method = "lm", se = TRUE,
              colour = pequod_crew_dark[["Ahab"]],
              fill   = pequod_crew_light[["Ahab"]], alpha = 0.25) +
  labs(title = "Scatter: SBP vs DBP at baseline",
       subtitle = "One point per participant; regression line with 95% CI.",
       x = "SBP at baseline (mmHg)", y = "DBP at baseline (mmHg)") +
  theme_paper()

save_fig("type-03-scatter.png", type03, w = 7.0, h = 4.4)

## type-04 Line plot (longitudinal mean by group, no spaghetti)
type04 <- ggplot(traj_summary, aes(month, sbp, colour = treatment)) +
  geom_line(linewidth = 1.3) +
  geom_point(size = 2.4) +
  scale_colour_pequod_d(palette = "crew") +
  scale_x_continuous(breaks = c(0, 1, 3, 6)) +
  labs(title = "Line plot: mean SBP over six months by treatment",
       subtitle = "One line per arm; the slope is the visual unit.",
       x = "Months from baseline", y = "SBP (mmHg)", colour = NULL) +
  theme_paper() +
  theme(legend.position = "right")

save_fig("type-04-line.png", type04, w = 7.6, h = 3.8)

## type-05 Forest plot (effect of each active arm vs Placebo)
fit_lm <- lm(delta_sbp ~ treatment, data = cohort)
ci <- stats::confint(fit_lm)
co <- stats::coef(fit_lm)
forest_data <- data.frame(
  arm = sub("^treatment", "", names(co)[-1]),
  estimate = unname(co[-1]),
  lo = ci[-1, 1],
  hi = ci[-1, 2]
) |>
  mutate(arm = factor(arm, levels = rev(c("ACEi", "ARB", "CCB"))))

type05 <- ggplot(forest_data, aes(estimate, arm)) +
  geom_vline(xintercept = 0, colour = MUTED_LIGHT, linetype = "dashed") +
  geom_errorbar(aes(xmin = lo, xmax = hi), width = 0.18,
                colour = pequod_crew_dark[["Ahab"]], linewidth = 0.7,
                orientation = "y") +
  geom_point(colour = pequod_crew_dark[["Ahab"]], size = 4) +
  geom_text(aes(x = hi, label = sprintf("%.1f  (%.1f – %.1f)",
                                        estimate, lo, hi)),
            hjust = 0, nudge_x = 0.4, family = mono_family, size = 3.3,
            colour = PAPER_TEXT) +
  scale_x_continuous(limits = c(-1, max(forest_data$hi) + 8),
                     expand = expansion(mult = c(0.02, 0.05))) +
  labs(title = "Forest plot: Δ SBP vs Placebo at six months",
       subtitle = "Point estimates and 95% confidence intervals.",
       x = "Δ SBP (mmHg, vs Placebo)", y = NULL) +
  theme_paper() +
  theme(panel.grid.major.y = element_blank())

save_fig("type-05-forest.png", type05, w = 7.8, h = 3.4)

## type-06 Kaplan-Meier (synthetic time to BP control)
set.seed(11)
rate_by_arm <- c(Placebo = 0.04, ACEi = 0.55, ARB = 0.50, CCB = 0.45)
cohort_km <- cohort |>
  mutate(
    raw_time = stats::rexp(n(), rate = rate_by_arm[as.character(treatment)]),
    event_time = pmin(raw_time, 6),
    event = as.integer(raw_time <= 6)
  )

km_fit <- survival::survfit(survival::Surv(event_time, event) ~ treatment,
                            data = cohort_km)
km_summary <- summary(km_fit, times = seq(0, 6, by = 0.25), extend = TRUE)
km_df <- data.frame(
  time = km_summary$time,
  surv = km_summary$surv,
  treatment = factor(gsub("treatment=", "", as.character(km_summary$strata)),
                     levels = c("Placebo", "ACEi", "ARB", "CCB"))
)

type06 <- ggplot(km_df, aes(time, surv, colour = treatment)) +
  geom_step(linewidth = 1.1) +
  scale_colour_pequod_d(palette = "crew") +
  scale_y_continuous(labels = scales::percent_format(),
                     limits = c(0, 1)) +
  scale_x_continuous(breaks = 0:6) +
  labs(title = "Kaplan-Meier: time to BP control by treatment",
       subtitle = "Proportion still uncontrolled. Synthetic event times for illustration.",
       x = "Months from baseline", y = "Uncontrolled (%)", colour = NULL) +
  theme_paper() +
  theme(legend.position = "right")

save_fig("type-06-km.png", type06, w = 7.8, h = 3.8)

message("Done. ", length(list.files(OUT, pattern = "\\.png$")), " PNGs in ", OUT)
