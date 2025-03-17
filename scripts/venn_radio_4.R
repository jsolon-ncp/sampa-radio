# ==============================================================================
#  R Script for Venn Diagram - Sampa Study
#  Author: J Solon
#  Version: 4.0
# ==============================================================================

# Load required packages
library(haven)      # For reading Stata files
library(dplyr)      # For data manipulation
library(eulerr)     # For Venn diagrams

# Read data
df <- read_dta("./data-temp/sampa_consort.dta")

# Create sets (using safe names)
sets <- list(
  Ultrasound = which(df$radio2 == 1),
  CT_Scan = which(df$ct2 == 1),
  FE_1 = which(df$assay_fecal_elastase == 1)
)

# Define display labels
labels <- c("Ultrasound", "CT Scan", "FE-1")
names(labels) <- c("Ultrasound", "CT_Scan", "FE_1")

# Print statistics
cat("\nParticipant Statistics:\n")
cat("=======================\n")
cat("Ultrasound:", length(sets$Ultrasound), "\n")
cat("CT scan:", length(sets$CT_Scan), "\n")
cat("FE-1:", length(sets$FE_1), "\n")
cat("USS and CT:", length(intersect(sets$Ultrasound, sets$CT_Scan)), "\n")
cat("USS and FE-1:", length(intersect(sets$Ultrasound, sets$FE_1)), "\n")
cat("CT and FE-1:", length(intersect(sets$CT_Scan, sets$FE_1)), "\n")
cat("All three:", length(Reduce(intersect, sets)), "\n")

# Create and plot diagram
fit <- euler(sets, shape = "circle")

# Plot to screen
plot(fit,
     quantities = TRUE,
     fills = c("#86C5D8", "#F9C48D", "#F9A48D"),
     alpha = 0.7,
     labels = labels,
     edges = list(lwd = 1),
     main = "Study Participant Distribution")

# Save plot
png("./figures/venn_diagram.png", width = 800, height = 800, res = 100)
plot(fit,
     quantities = TRUE,
     fills = c("#86C5D8", "#F9C48D", "#F9A48D"),
     alpha = 0.7,
     labels = labels,
     edges = list(lwd = 1),
     main = "Study Participant Distribution")
dev.off()

# Print fit quality
cat("\nStress value:", round(fit$stress, 4),
    "\n(Values close to 0 indicate a good representation)\n")