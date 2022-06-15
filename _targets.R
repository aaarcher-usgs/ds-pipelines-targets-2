library(targets)
source("1_fetch/src/download_nwis_site_data.R")
source("1_fetch/src/nwis_site_info.R")
source("1_fetch/src/bind_site_data.R")
source("2_process/src/process_and_style.R")
source("3_visualize/src/plot_timeseries.R")

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse", "dataRetrieval")) # Loading tidyverse because we need dplyr, ggplot2, readr, stringr, and purrr

# Global parameters
parameterCd <- '00010'
startDate <- "2014-05-01" 
endDate <- "2015-05-01"


# For each site, download data and write to csv
#         Note: this feels inefficient and hard to scale up. How can we "loop" over
#               multiple sites without making a target specified to each individually?
p1_targets_list <- list(
  tar_target(
    site_data_01427207, 
    download_nwis_site_data(site_num = "01427207",
                            parameterCd = parameterCd,
                            startDate = startDate,
                            endDate = endDate)
  ),
  tar_target(
    site_data_01432160,
    download_nwis_site_data(site_num = "01432160",
                            parameterCd = parameterCd,
                            startDate = startDate,
                            endDate = endDate)
  ),
  tar_target(
    site_data_01436690,
    download_nwis_site_data(site_num = "01436690",
                            parameterCd = parameterCd,
                            startDate = startDate,
                            endDate = endDate)
  ),
  tar_target(
    site_data_01466500,
    download_nwis_site_data(site_num = "01466500",
                            parameterCd = parameterCd,
                            startDate = startDate,
                            endDate = endDate)
  ),
  tar_target(
    # Merge data from all sites
    site_data_csv,
    bind_site_data(out_file = "1_fetch/out/nwis_site_data.csv",
                   in_data = bind_rows(site_data_01427207, 
                                       site_data_01432160,
                                       site_data_01436690,
                                       site_data_01466500)),
    format = "file"
  ),
  tar_target(
    # Download pertinent site information for each site
    site_info_csv,
    nwis_site_info(out_file = "1_fetch/out/site_info.csv", 
                   site_data_file = site_data_csv),
    format = "file"
  )
)

# Process and annotate site_data
p2_targets_list <- list(
  tar_target(
    site_data_styled_rds,
    process_data(site_data_file = site_data_csv, 
                 site_info_file = site_info_csv,
                 out_file = "2_process/out/processed_data.rds"),
    format = "file"
  )
)

# Create figure 1
p3_targets_list <- list(
  tar_target(
    figure_1_png,
    plot_nwis_timeseries(out_file = "3_visualize/out/figure_1.png", 
                         in_file = site_data_styled_rds),
    format = "file"
  )
)

# Return the complete list of targets
c(p1_targets_list, p2_targets_list, p3_targets_list)
