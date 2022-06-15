# This function binds together the site data objects.
bind_site_data <- function(out_file, in_data){
  
  in_data %>% 
    readr::write_csv(file = out_file)
  
 return(out_file)
}

