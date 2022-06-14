# This function binds together the site data objects.
bind_site_data <- function(in1, in2, in3, in4, out_file){
  
  dplyr::bind_rows(in1, in2, in3, in4) %>% 
    readr::write_csv(file = out_file)
  
 return(out_file)
}

