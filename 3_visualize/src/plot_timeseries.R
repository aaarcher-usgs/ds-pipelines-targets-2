# This function creates a time series of the NWIS site data by station_name and during 
# globally-defined start and end dates.
plot_nwis_timeseries <- function(out_file, in_file, width = 12, height = 7, units = 'in'){
  
  site_data_processed <- readRDS(in_file)
  
  ggplot(data = site_data_processed, aes(x = dateTime, y = water_temperature, color = station_name)) +
    geom_line() + theme_bw()
  ggsave(out_file, width = width, height = height, units = units)
  
  return(out_file)
}
