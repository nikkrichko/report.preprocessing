library(report.preprocessing)


jdt <- clean_jmeter_log(report.preprocessing::jdt_dirty)

### get_response_time_plot - tests ---------------------

report.preprocessing::get_response_time_plot(jdt)
report.preprocessing::get_response_time_plot(jdt, scenario_name = "Hello world scenario")
report.preprocessing::get_response_time_plot(jdt, group_by_label = FALSE)
report.preprocessing::get_response_time_plot(jdt, interactive = TRUE)
report.preprocessing::get_response_time_plot(jdt, scenario_name = "Hello world scenario", interactive = TRUE)
report.preprocessing::get_response_time_plot(jdt, group_by_label = FALSE, interactive = TRUE)
### get_connect_time_plot - tests ---------------------

report.preprocessing::get_connect_time_plot(jdt)
report.preprocessing::get_connect_time_plot(jdt, scenario_name = "Hello world scenario")
report.preprocessing::get_connect_time_plot(jdt, group_by_label = FALSE)
report.preprocessing::get_connect_time_plot(jdt, interactive = TRUE)
report.preprocessing::get_connect_time_plot(jdt, scenario_name = "Hello world scenario", interactive = TRUE)
report.preprocessing::get_connect_time_plot(jdt, group_by_label = FALSE, interactive = TRUE)
### get_connect_time_plot - tests ---------------------

report.preprocessing::get_latency_time_plot(jdt)
report.preprocessing::get_latency_time_plot(jdt, scenario_name = "Hello world scenario")
report.preprocessing::get_latency_time_plot(jdt, group_by_label = FALSE)
report.preprocessing::get_latency_time_plot(jdt, interactive = TRUE)
report.preprocessing::get_latency_time_plot(jdt, scenario_name = "Hello world scenario", interactive = TRUE)
report.preprocessing::get_latency_time_plot(jdt, group_by_label = FALSE, interactive = TRUE)

### get_RPS_plot - tests ---------------------

report.preprocessing::get_rps_plot(jdt)
report.preprocessing::get_rps_plot(jdt, scenario_name = "Hello world scenario")
report.preprocessing::get_rps_plot(jdt, group_by_label = FALSE)
report.preprocessing::get_rps_plot(jdt, interactive = TRUE)
report.preprocessing::get_rps_plot(jdt, scenario_name = "Hello world scenario", interactive = TRUE)
report.preprocessing::get_rps_plot(jdt, group_by_label = FALSE, interactive = TRUE)### get_RPS_plot - tests ---------------------

### get_histogram_response_times_distribution_plot - tests --------------------------------

report.preprocessing::get_histogram_response_times_distribution_plot(jdt)
report.preprocessing::get_histogram_response_times_distribution_plot(jdt, scenario_name = "Hello world scenario")
report.preprocessing::get_histogram_response_times_distribution_plot(jdt, group_by_label = FALSE)
report.preprocessing::get_histogram_response_times_distribution_plot(jdt, interactive = TRUE)
report.preprocessing::get_histogram_response_times_distribution_plot(jdt, scenario_name = "Hello world scenario", interactive = TRUE)
report.preprocessing::get_histogram_response_times_distribution_plot(jdt, group_by_label = FALSE, interactive = TRUE)

### get_density_response_times_plot - tests --------------------------------

report.preprocessing::get_density_response_times_plot(jdt)
report.preprocessing::get_density_response_times_plot(jdt, scenario_name = "Hello world scenario")
report.preprocessing::get_density_response_times_plot(jdt, group_by_label = FALSE)
report.preprocessing::get_density_response_times_plot(jdt, interactive = TRUE)
report.preprocessing::get_density_response_times_plot(jdt, scenario_name = "Hello world scenario", interactive = TRUE)
report.preprocessing::get_density_response_times_plot(jdt, group_by_label = FALSE, interactive = TRUE)

#### get_response_times_with_errors_plot - tests ---------------------

report.preprocessing::get_response_times_with_errors_plot(jdt)
report.preprocessing::get_response_times_with_errors_plot(jdt, scenario_name = "Hello world scenario")
report.preprocessing::get_response_times_with_errors_plot(jdt, group_by_label = FALSE)
report.preprocessing::get_response_times_with_errors_plot(jdt, interactive = TRUE)
report.preprocessing::get_response_times_with_errors_plot(jdt, scenario_name = "Hello world scenario", interactive = TRUE)
report.preprocessing::get_response_times_with_errors_plot(jdt, group_by_label = FALSE, interactive = TRUE)
#### get_response_times_with_errors_plot - tests ---------------------

report.preprocessing::get_quantile_plot(jdt)
report.preprocessing::get_quantile_plot(jdt, scenario_name = "Hello world scenario")
report.preprocessing::get_quantile_plot(jdt, group_by_label = FALSE)
report.preprocessing::get_quantile_plot(jdt, interactive = TRUE)
report.preprocessing::get_quantile_plot(jdt, scenario_name = "Hello world scenario", interactive = TRUE)
report.preprocessing::get_quantile_plot(jdt, group_by_label = FALSE, interactive = TRUE)
#### get_response_time_box_plot - tests ---------------------

report.preprocessing::get_response_time_box_plot(jdt)
report.preprocessing::get_response_time_box_plot(jdt, scenario_name = "Hello world scenario")
report.preprocessing::get_response_time_box_plot(jdt, group_by_label = FALSE)
report.preprocessing::get_response_time_box_plot(jdt, interactive = TRUE)
report.preprocessing::get_response_time_box_plot(jdt, scenario_name = "Hello world scenario", interactive = TRUE)
report.preprocessing::get_response_time_box_plot(jdt, group_by_label = FALSE, interactive = TRUE)
#### get_response_time_violin_plot - tests ---------------------

report.preprocessing::get_response_time_violin_plot(jdt)
report.preprocessing::get_response_time_violin_plot(jdt, scenario_name = "Hello world scenario")
report.preprocessing::get_response_time_violin_plot(jdt, group_by_label = FALSE)
report.preprocessing::get_response_time_violin_plot(jdt, interactive = TRUE)
report.preprocessing::get_response_time_violin_plot(jdt, scenario_name = "Hello world scenario", interactive = TRUE)
report.preprocessing::get_response_time_violin_plot(jdt, group_by_label = FALSE, interactive = TRUE)

#### get_active_thread_plot - test =====================

report.preprocessing::get_active_thread_plot(jdt)
report.preprocessing::get_active_thread_plot(jdt, scenario_name = "Hello world scenario")
report.preprocessing::get_active_thread_plot(jdt, interactive = TRUE)
report.preprocessing::get_active_thread_plot(jdt, scenario_name = "Hello world scenario", interactive = TRUE)


#### get_thoghput_per_second_plot - test =====================

report.preprocessing::get_thoghput_per_second_plot(jdt)
report.preprocessing::get_thoghput_per_second_plot(jdt, scenario_name = "Hello world scenario")
report.preprocessing::get_thoghput_per_second_plot(jdt, interactive = TRUE)
report.preprocessing::get_thoghput_per_second_plot(jdt, scenario_name = "Hello world scenario", interactive = TRUE)

#### get_thoghput_per_second_by_labels_plot - test

report.preprocessing::get_thoghput_per_second_by_labels_plot(jdt)
report.preprocessing::get_thoghput_per_second_by_labels_plot(jdt, scenario_name = "Hello world scenario")
report.preprocessing::get_thoghput_per_second_by_labels_plot(jdt, interactive = TRUE)
report.preprocessing::get_thoghput_per_second_by_labels_plot(jdt, scenario_name = "Hello world scenario", interactive = TRUE)




