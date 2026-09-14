# Set environment variable to download static libv8 for V8 package compilation
Sys.setenv(DOWNLOAD_STATIC_LIBV8 = "1")

# 0. Install CRAN Packages that failed to build in Nix
message("Installing CRAN packages that failed to build in Nix...")
failed_packages <- c("arrow", "V8", "gt", "almanac", "vcdExtra", "gtsummary", "rUM")
for (pkg in failed_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    message(paste("Installing", pkg, "..."))
    install.packages(pkg, repos = "https://cloud.r-project.org")
  }
}

# 1. Install GitHub Packages
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

message("Installing GitHub-only packages...")
remotes::install_github(c(
  "hadley/emo",
  "wch/extrafont",
  "tgerke/ggconsort",
  "hollyyfc/lme4u",
  "e-mitchell/meps_r_pkg/MEPS",
  "r-causal/propensity"
), upgrade = "never")

# 2. Install Your Personal Dev Packages (from local source paths)
message("Installing local development packages...")
local_dev_packages <- c(
  "/home/kyle/dev/sumExtras",
  "/home/kyle/dev/froggeR",
  "/home/kyle/dev/nascaR.data",
  "/home/kyle/dev/nhanesdata"
)

for (pkg_path in local_dev_packages) {
  if (dir.exists(pkg_path)) {
    message("Installing: ", basename(pkg_path))
    devtools::install(pkg_path, upgrade = FALSE, quick = TRUE)
  } else {
    warning("Directory does not exist: ", pkg_path)
  }
}

message("Non-Nix package installation complete!")
