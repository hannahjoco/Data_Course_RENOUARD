csv_files <- list.files("Data",pattern="\\.csv$",full.names=TRUE,recursive=TRUE)
length(csv_files)
df <- read.csv("Data/wingspan_vs_mass.csv")
head(df)
b_files <- list.files(
  "Data",
  pattern="^b",
  recursive=TRUE,
  full.names=TRUE
  )
for (f in b_files) {
  cat("File:", f, "\n")
  cat(readLines(f, n=1), "\n\n")
  }
for (f in csv_files) {
  cat("File:", f, "\n")
  cat(readLines(f, n=1), "\n\n")
}