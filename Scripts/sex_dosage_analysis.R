# Import chromosome classification file
chromosome_groups <- read.csv(file.choose())

# View the imported data
print(chromosome_groups)

# Import chromosome coverage results
coverage_data <- read.delim(file.choose(), check.names = FALSE)

# Display coverage data
print(coverage_data)

# Check column names
colnames(coverage_data)

# Rename #rname to rname for easier processing
names(coverage_data)[names(coverage_data) == "#rname"] <- "rname"

# Match coverage data with chromosome classification
merged_data <- merge(chromosome_groups, coverage_data, by = "rname")

# View matched chromosomes
print(merged_data)

# Calculate median autosomal coverage
autosome_depth <- median(
  merged_data$meandepth[merged_data$group == "A"],
  na.rm = TRUE
)

# Calculate X chromosome coverage
x_depth <- merged_data$meandepth[merged_data$group == "X"]

# Calculate X-to-autosome ratio
x_to_autosome_ratio <- x_depth / autosome_depth

# Display results
cat("Median autosomal depth:", autosome_depth, "\n")
cat("X chromosome depth:", x_depth, "\n")
cat("X-to-autosome ratio:", x_to_autosome_ratio, "\n")

# Plot chromosome mean depth

barplot(
  merged_data$meandepth,
  names.arg = merged_data$group,
  col = c("skyblue", "skyblue", "skyblue",
          "skyblue", "skyblue", "pink"),
  main = "Chromosome Mean Depth",
  xlab = "Chromosome Group",
  ylab = "Mean Sequencing Depth",
  border = "black"
)

# Add horizontal line representing median autosomal depth
abline(h = autosome_depth, lty = 2, col = "red", lwd = 2)

# Create a summary table of results

dosage_results <- data.frame(
  Species = "Caenorhabditis elegans",
  Sex_system = "XX/XO",
  Median_autosomal_depth = autosome_depth,
  X_chromosome_depth = x_depth,
  X_to_autosome_ratio = x_to_autosome_ratio,
  Dosage_interpretation = "XX-like"
)

# View results
print(dosage_results)

# Save as CSV
write.csv(
  dosage_results,
  "sex_dosage_results.csv",
  row.names = FALSE
)

# Save chromosome coverage data
write.csv(merged_data,
  "chromosome_coverage_results.csv",
  row.names = FALSE)

getwd()
