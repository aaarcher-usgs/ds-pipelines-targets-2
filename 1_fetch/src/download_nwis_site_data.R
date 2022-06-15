# This function downloads data for a NWIS site and has a built in function to return an error
# if the download fails.
download_nwis_site_data <- function(site_num, parameterCd, startDate, endDate, out_file){
  
  # readNWISdata is from the dataRetrieval package
  data_out <- dataRetrieval::readNWISdata(sites=site_num, service="iv", 
                                          parameterCd = parameterCd, 
                                          startDate = startDate, 
                                          endDate = endDate)

  # -- simulating a failure-prone web-sevice here, do not edit --
  set.seed(Sys.time())
  if (sample(c(T,F,F,F), 1)){
    stop(site_num, ' has failed due to connection timeout. Try tar_make() again')
  }
  # -- end of do-not-edit block
  
 return(data_out)
}

