# Load required libraries
library(tidyverse)
library(eulerr)

# Define the counts for your Venn diagram regions
counts <- c(
  "Ultrasound" = 290,
  "FE-1" = 380,
  "CT Scan" = 21,
  "Ultrasound&FE-1" = 1182,
  "Ultrasound&CT Scan" = 55,
  "FE-1&CT Scan" = 257,
  "Ultrasound&FE-1&CT Scan" = 257
)

# Create a euler diagram
fit <- euler(counts)

# Check the stress value of the fit
cat("Stress value:", round(fit$stress, 4),
    "\n(Values close to 0 indicate a good representation)\n")

# Plot the diagram to the screen
plot(fit,
     quantities = TRUE,
     fills = c("#86C5D8", "#F9C58D", "#F9A48D"),
     alpha = 0.7,
     labels = list(font = 2),
     edges = list(lwd = 1),
     main = "Study Participant Distribution")

# Save the plot to a PNG file
dev.copy(png, "venn_radio.png", width = 800, height = 600)
dev.off() # Close the PNG device