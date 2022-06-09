library(targets)
source("1_fetch/src/download_nwis_data.R")
source("1_fetch/src/nwis_site_info.R")
source("1_fetch/src/download_nwis_site_data.R")
source("2_process/src/process_and_style.R")
source("3_visualize/src/plot_timeseries.R")

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse", "dataRetrieval")) # Loading tidyverse because we need dplyr, ggplot2, readr, stringr, and purrr

# Global parameters
parameterCd <- '00010'
startDate <- "2014-05-01" 
endDate <- "2015-05-01"
#site_nums <- c("01427207", "01432160", "01436690", "01466500")

# For each site, download data and write to csv
#         Note: this feels inefficient and hard to scale up. How can we "loop" over
#               multiple sites without making a target specified to each individually?
p1_targets_list <- list(
  tar_target(
    site_data_01427207, 
    download_nwis_site_data(site_num = "01427207",
                            parameterCd = parameterCd,
                            startDate = startDate,
                            endDate = endDate,
                            out_dir = "1_fetch/out/"),
  ),
  tar_target(
    site_data_01432160,
    download_nwis_site_data(site_num = "01432160",
                            parameterCd = parameterCd,
                            startDate = startDate,
                            endDate = endDate,
                            out_dir = "1_fetch/out/"),
  ),
  tar_target(
    site_data_01436690,
    download_nwis_site_data(site_num = "01436690",
                            parameterCd = parameterCd,
                            startDate = startDate,
                            endDate = endDate,
                            out_dir = "1_fetch/out/"),
  ),
  tar_target(
    site_data_01466500,
    download_nwis_site_data(site_num = "01466500",
                            parameterCd = parameterCd,
                            startDate = startDate,
                            endDate = endDate,
                            out_dir = "1_fetch/out/"),
  ),
  tar_target(
    # Merge data from all sites
    site_data,
    rbind(site_data_01427207,
          site_data_01432160,
          site_data_01436690,
          site_data_01466500)
  ),
  tar_target(
    site_info_csv,
    nwis_site_info(fileout = "1_fetch/out/site_info.csv", site_data),
    format = "file"
  )
)

# Targets to process data
p2_targets_list <- list(
  tar_target(
    site_data_clean, 
    process_data(site_data)
  ),
  tar_target(
    site_data_annotated,
    annotate_data(site_data_clean, site_filename = site_info_csv)
  ),
  tar_target(
    site_data_styled,
    style_data(site_data_annotated)
  )
)

p3_targets_list <- list(
  tar_target(
    figure_1_png,
    plot_nwis_timeseries(fileout = "3_visualize/out/figure_1.png", site_data_styled),
    format = "file"
  )
)

# Return the complete list of targets
c(p1_targets_list, p2_targets_list, p3_targets_list)
