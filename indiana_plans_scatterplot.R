# H354 Health Economics: Indiana Marketplace Plans
# Scatter plot of monthly premium (x) vs. medical deductible (y)

# Put the Marketplace CSV in the same folder as this R script.
# The downloaded file has a descriptive row above the actual column headers,
# so skip that first row when importing it.
plans <- read.csv("indiana_aca_plans.csv",
                  skip = 1,
                  check.names = FALSE,
                  stringsAsFactors = FALSE)

# Keep Indiana plans only.
state_col <- "State Code"
plans <- plans[trimws(toupper(plans[[state_col]])) == "IN", ]

# Choose one premium and one deductible column for a consistent comparison.
premium_col <- "Premium Adult Individual Age 27"
deductible_col <- "Medical Deductible - Individual - Standard"

# Convert values such as "$1,234.56" to numeric values.
to_numeric <- function(x) {
  as.numeric(gsub("[$,]", "", trimws(as.character(x))))
}

plans$premium <- to_numeric(plans[[premium_col]])
plans$deductible <- to_numeric(plans[[deductible_col]])

# Print the number of Indiana plans after filtering.
cat("Indiana plans remaining after filtering:", nrow(plans), "\\n")

# Keep rows with usable premium and deductible values for the plot.
plot_plans <- plans[!is.na(plans$premium) & !is.na(plans$deductible), ]

# Save the scatter plot as a PNG file.
png("indiana_premium_vs_deductible.png",
    width = 1800, height = 1200, res = 200)

plot(plot_plans$premium, plot_plans$deductible,
     xlab = "Monthly Premium ($) — Adult Individual Age 27",
     ylab = "Medical Deductible ($) — Individual, Standard",
     main = "Indiana Marketplace Plans: Premium vs. Deductible",
     pch = 19, col = rgb(0.1, 0.35, 0.7, 0.55))

dev.off()

cat("Plans included in scatter plot:", nrow(plot_plans), "\\n")
cat("Saved graph to: indiana_premium_vs_deductible.png\\n")
