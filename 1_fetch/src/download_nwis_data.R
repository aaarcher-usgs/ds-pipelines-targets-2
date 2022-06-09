
download_nwis_data <- function(site_nums = c("01427207", "01432160", "01436690", "01466500")){
  
  # create the file names that are needed for download_nwis_site_data
  # tempdir() creates a temporary directory that is wiped out when you start a new R session; 
  # replace tempdir() with "1_fetch/out" or another desired folder if you want to retain the download
  download_files <- file.path(tempdir(), paste0('nwis_', site_nums, '_data.csv'))
  data_out <- data.frame()
  # loop through files to download 
  for (download_file in download_files){
    download_nwis_site_data(download_file, parameterCd = '00010')
    # read the downloaded data and append it to the existing data.frame
    these_data <- read_csv(download_file, col_types = 'ccTdcc')
    data_out <- bind_rows(data_out, these_data)
  }
  return(data_out)
}
