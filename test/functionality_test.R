library(report.preprocessing)


jdt <- clean_jmeter_log(report.preprocessing::jdt_dirty)

### get_response_time_plot - tests ---------------------

report.preprocessing::get_response_time_plot(jdt)
report.preprocessing::get_response_time_plot(jdt, scenario_name = "Hello world scenario")
report.preprocessing::get_response_time_plot(jdt, group_by_label = FALSE)
report.preprocessing::get_response_time_plot(jdt, interactive = TRUE)
report.preprocessing::get_response_time_plot(jdt, scenario_name = "Hello world scenario", interactive = TRUE)
report.preprocessing::get_response_time_plot(jdt, group_by_label = FALSE, interactive = TRUE)

### get_RPS_plot - tests ---------------------


report.preprocessing::get_rps_plot(jdt)
report.preprocessing::get_rps_plot(jdt, scenario_name = "Hello world scenario")
report.preprocessing::get_rps_plot(jdt, group_by_label = FALSE)
report.preprocessing::get_rps_plot(jdt, interactive = TRUE)
report.preprocessing::get_rps_plot(jdt, scenario_name = "Hello world scenario", interactive = TRUE)
report.preprocessing::get_rps_plot(jdt, group_by_label = FALSE, interactive = TRUE)

#### get_response_times_with_errors_plot - tests ---------------------

report.preprocessing::get_response_times_with_errors_plot(jdt)
report.preprocessing::get_response_times_with_errors_plot(jdt, scenario_name = "Hello world scenario")
report.preprocessing::get_response_times_with_errors_plot(jdt, group_by_label = FALSE)
report.preprocessing::get_response_times_with_errors_plot(jdt, interactive = TRUE)
report.preprocessing::get_response_times_with_errors_plot(jdt, scenario_name = "Hello world scenario", interactive = TRUE)
report.preprocessing::get_response_times_with_errors_plot(jdt, group_by_label = FALSE, interactive = TRUE)

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






