# This function takes the full site data and extracts site information for only the
# sites that have been downloaded in upstream targets
nwis_site_info <- function(fileout, site_data_file){
  
  site_data <- readr::read_csv(site_data_file, show_col_types = FALSE)
  
  site_no <- unique(site_data$site_no)
  site_info <- dataRetrieval::readNWISsite(site_no)
  readr::write_csv(site_info, fileout)
  return(fileout)
}

