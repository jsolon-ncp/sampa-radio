# test rotation
rm(list = ls())

library(eulerr)

# Create a sample data frame with set memberships
n <- 100  # number of observations
set.seed(123)  # for reproducibility

# Create sample data as sets (similar to venn_radio_4.R approach)
A <- which(sample(c(TRUE, FALSE), n, replace = TRUE))
B <- which(sample(c(TRUE, FALSE), n, replace = TRUE))
C <- which(sample(c(TRUE, FALSE), n, replace = TRUE))

# Create sets list (following the working approach from venn_radio_4.R)
sets <- list(
    A = A,
    B = B,
    C = C
)

# Create euler diagram with circles
fit <- euler(sets, shape = "circle")

# Print diagnostic information
print("Diagram fit information:")
print(fit)

# Get the circles information before rotation
circles <- coef(fit)
print("Original circles information:")
print(circles)

# Plot original diagram
plot(fit,
     quantities = TRUE,
     fills = c("#86C5D8", "#F9C48D", "#F9A48D"),
     alpha = 0.7,
     main = "Original Example")

# Rotate the diagram using the circle centers from coef()
rotation_angle <- pi / 2
centers <- matrix(c(circles$h, circles$k), ncol = 2)
rotation_matrix <- matrix(c(cos(rotation_angle), -sin(rotation_angle),
                          sin(rotation_angle), cos(rotation_angle)), 2, 2)
rotated_centers <- centers %*% rotation_matrix

# Update the circle coordinates
circles$h <- rotated_centers[,1]
circles$k <- rotated_centers[,2]

# Update the fit object
fit$circles <- circles

# Plot rotated diagram
plot(fit,
     quantities = TRUE,
     fills = c("#86C5D8", "#F9C48D", "#F9A48D"),
     alpha = 0.7,
     main = "Rotated Example")

print("Rotated circles information:")
print(coef(fit))