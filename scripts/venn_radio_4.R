/* R Script for Venn Diagram
Sampa 
J Solon
v4
*/
  
  if (!require("haven")) {
    install.packages("haven")
  }

if (!require("tidyverse")) {
  install.packages("tidyverse")
}

if (!require("eulerr")) {
  install.packages("eulerr")
}


# Load required packages
library(tidyverse) # error so load individual components
library(eulerr)

rm(list = ls())

getwd()


# Read Sampa data
df <- read_dta("./data-temp/sampa_consort.dta")

head(df)
summary(df)

# Create sets (indices where each variable equals 1)
uss_set <- which(df$radio2 == 1)
fe1_set <- which(df$assay_fecal_elastase == 1)
ct_set <- which(df$ct2 == 1)

# Create combinations using set operations
uss_and_ct <- intersect(uss_set, ct_set)  # Participants with both USS and CT
uss_and_fe1 <- intersect(uss_set, fe1_set)  # Participants with both USS and FE_1
ct_and_fe1 <- intersect(ct_set, fe1_set)  # Participants with both CT and FE_1
all_three <- intersect(intersect(uss_set, ct_set), fe1_set)  # Participants with all three

# Print counts to verify
cat("Participants with USS:", length(uss_set), "\n")
cat("Participants with CT scan:", length(ct_set), "\n")
cat("Participants with FE-1:", length(fe1_set), "\n")
cat("Participants with both USS and CT:", length(uss_and_ct), "\n")
cat("Participants with both USS and FE-1:", length(uss_and_fe1), "\n")
cat("Participants with both CT and FE-1:", length(ct_and_fe1), "\n")
cat("Participants with all three:", length(all_three), "\n")

# Method 1: Using the list of sets approach
# This is the simplest approach - just provide the sets directly
sets <- list(
  Ultrasound = uss_set,
  CT_Scan = ct_set,
  FE_1 = fe1_set
)

# Create the euler diagram using circles
fit <- euler(sets, shape = "circle")

# Check fit quality (stress value)
cat("Stress value:", round(fit$stress, 4),
    "\n(Values close to 0 indicate a good representation)\n")

# Plot the diagram
plot(fit,
     quantities = TRUE,
     fills = c("#86C5D8", "#F9C48D", "#F9A48D"),
     alpha = 0.7,
     labels = list(font = 2),
     edges = list(lwd = 1),
     main = "Study Participant Distribution (Circles)")

#Now that circles are being used, you can rotate the diagram.
rotation_angle <- pi / 2
original_centers <- as.matrix(fit$centers)
rotation_matrix <- matrix(c(cos(rotation_angle), -sin(rotation_angle),
                            sin(rotation_angle), cos(rotation_angle)), 2, 2)
rotated_centers <- original_centers %*% rotation_matrix
fit$centers <- rotated_centers

plot(fit,
     quantities = TRUE,
     fills = c("#86C5D8", "#F9C48D", "#F9A48D"),
     alpha = 0.7,
     labels = list(font = 2),
     edges = list(lwd = 1),
     main = "Rotated Study Participant Distribution (Circles)")