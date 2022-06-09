

download_nwis_site_data <- function(site_num, parameterCd, startDate, endDate, out_dir){
  
  # readNWISdata is from the dataRetrieval package
  data_out <- readNWISdata(sites=site_num, service="iv", 
                           parameterCd = parameterCd, 
                           startDate = startDate, 
                           endDate = endDate)

  # -- simulating a failure-prone web-sevice here, do not edit --
  set.seed(Sys.time())
  if (sample(c(T,F,F,F), 1)){
    stop(site_num, ' has failed due to connection timeout. Try tar_make() again')
  }
  # -- end of do-not-edit block
  
 write.csv(data_out, file = file.path(paste0(out_dir, 'nwis_', site_num, '_data.csv')))
 return(data_out)
}

