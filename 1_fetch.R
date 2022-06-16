source("1_fetch/src/download_nwis_site_data.R")
source("1_fetch/src/nwis_site_info.R")
source("1_fetch/src/bind_site_data.R")



# For each site, download data and write to csv
p1_targets_list <- list(
  tar_target(
    p1_site_data_01427207, 
    download_nwis_site_data(site_num = "01427207",
                            parameterCd = parameterCd,
                            startDate = startDate,
                            endDate = endDate)
  ),
  tar_target(
    p1_site_data_01432160,
    download_nwis_site_data(site_num = "01432160",
                            parameterCd = parameterCd,
                            startDate = startDate,
                            endDate = endDate)
  ),
  tar_target(
    p1_site_data_01436690,
    download_nwis_site_data(site_num = "01436690",
                            parameterCd = parameterCd,
                            startDate = startDate,
                            endDate = endDate)
  ),
  tar_target(
    p1_site_data_01466500,
    download_nwis_site_data(site_num = "01466500",
                            parameterCd = parameterCd,
                            startDate = startDate,
                            endDate = endDate)
  ),
  tar_target(
    # Merge data from all sites
    p1_site_data_csv,
    bind_site_data(out_file = "1_fetch/out/nwis_site_data.csv",
                   in_data = bind_rows(p1_site_data_01427207, 
                                       p1_site_data_01432160,
                                       p1_site_data_01436690,
                                       p1_site_data_01466500)),
    format = "file"
  ),
  tar_target(
    # Download pertinent site information for each site
    p1_site_info_csv,
    nwis_site_info(out_file = "1_fetch/out/site_info.csv", 
                   site_data_file = p1_site_data_csv),
    format = "file"
  )
)