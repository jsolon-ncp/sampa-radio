library(eulerr)
library(grid)

# Define the set sizes and overlaps
fit <- euler(c(
  "USS" = 1784 - 1439 - 312 + 257, 
  "FE-1" = 1821 - 1439 - 259 + 257, 
  "CT" = 335 - 312 - 259 + 257,  
  "USS&FE-1" = 1439 - 257, 
  "FE-1&CT" = 259 - 257, 
  "USS&CT" = 312 - 257, 
  "USS&FE-1&CT" = 257
))



# Open a new plotting window
grid.newpage()




# Add a rectangle enclosing the Venn diagram
grid.rect(gp = gpar(lwd = 2, col = "black", fill=NA))



# Plot the Euler diagram
plot(fit, fills = c("palegreen", "pink", "lightblue"),mar=c(1, 1, 1, 1), edges = list(col = c("darkgreen", "red", "blue")),
     quantities = TRUE, lwd=3)





# Add total counts outside the circles using grid text
library(grid)

#USS
grid.text("1784", x = 0.07, y = 0.8, gp = gpar(fontsize = 12, col = "darkgreen"))

#FE-1
grid.text("1821", x = 0.85, y = 0.9, gp = gpar(fontsize = 12, col = "red"))


#CT
grid.text("335", x = 0.25, y = 0.98, gp = gpar(fontsize = 12, col = "blue"))











