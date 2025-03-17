# test rotation
rm(list = ls())

library(eulerr)


# Create small example sets
A <- 1:10
B <- 5:15
C <- 8:18

sets_example <- list(A = A, B = B, C = C)

# Create euler diagram with circles
fit_example <- euler(sets_example, shape = "circle")

# Check stress and centers
print("Example Stress:")
print(fit_example$stress)
print("Example Centers:")
print(fit_example$centers)

# Plot the example
plot(fit_example,
     quantities = TRUE,
     main = "Example (Circles)")

# Attempt rotation (if centers are not NULL)
if (!is.null(fit_example$centers)) {
  rotation_angle <- pi / 2
  original_centers <- as.matrix(fit_example$centers)
  rotation_matrix <- matrix(c(cos(rotation_angle), -sin(rotation_angle),
                              sin(rotation_angle), cos(rotation_angle)), 2, 2)
  rotated_centers <- original_centers %*% rotation_matrix
  fit_example$centers <- rotated_centers
  
  plot(fit_example,
       quantities = TRUE,
       main = "Rotated Example (Circles)")
} else {
  print("Example: fit$centers is NULL")
}