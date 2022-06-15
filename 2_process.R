source("2_process/src/process_and_style.R")

# Process and annotate site_data
p2_targets_list <- list(
  tar_target(
    p2_site_data_styled_rds,
    process_data(site_data_file = p1_site_data_csv, 
                 site_info_file = p1_site_info_csv,
                 out_file = "2_process/out/processed_data.rds"),
    format = "file"
  )
)
