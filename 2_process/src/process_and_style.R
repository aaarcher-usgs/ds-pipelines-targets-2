# This function processes the site data by joining it with site_info by site_no
# and then cleans up several variables in preparation for plotting
process_data <- function(site_data_file, site_info_file, out_file){
  
  require(tidyverse)
  
  # Read site info from csv 
  site_info <- readr::read_csv(site_info_file, show_col_types = F)
  
  site_data <- readr::read_csv(site_data_file, show_col_types = F)
  
  # Join site info to site_data and clean up vars
  
  site_data_processed <- left_join(site_data, site_info, by = "site_no") %>% #merge
    # rename vars for readability
    rename(water_temperature = X_00010_00000,
           station_name = station_nm,
           latitude = dec_lat_va,
           longitude = dec_long_va) %>%
    # Change station name to factor for figure styling
    mutate(station_name = as.factor(station_name))%>%
    # Clean up data.frame to maintain only wanted vars
    select(site_no, dateTime, water_temperature, latitude, longitude, station_name)
  
  # Write processed data as .Rdata
  saveRDS(site_data_processed, file = out_file)
  
  return(out_file)
}

