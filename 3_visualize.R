source("3_visualize/src/plot_timeseries.R")

# Create figure 1
p3_targets_list <- list(
  tar_target(
    p3_figure_1_png,
    plot_nwis_timeseries(out_file = "3_visualize/out/figure_1.png", 
                         in_file = p2_site_data_styled_rds),
    format = "file"
  )
)

