library(report.preprocessing)
# options(scipen = 99999)
#
jdt <- report.preprocessing::clean_jmeter_log(report.preprocessing::jdt_dirty)

jdt <- report.preprocessing::clean_jmeter_log(jdt_dirty)
report.preprocessing::get_aggregate_table(jdt)


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
report.preprocessing::get_rps_plot(jdt, group_by_label = FALSE, interactive = TRUE)
### get_RPS_plot - tests ---------------------
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

#### get_response_time_violin_plot_vs_threads - tests ------------------------------
scenario_name <- "HELLO_WORLD_SCENARIO_NAME"
input_request_name <- "GET - get_paymants"

report.preprocessing::get_response_time_violin_plot_vs_threads(jdt,
                                                               scenario_name=NULL,
                                                               input_request_name=NULL,
                                                               group_by_label=TRUE,
                                                               interactive=FALSE,
                                                               split_by_responseCode=FALSE)

report.preprocessing::get_response_time_violin_plot_vs_threads(jdt,
                                                               scenario_name=NULL,
                                                               input_request_name=NULL,
                                                               group_by_label=FALSE,
                                                               interactive=FALSE,
                                                               split_by_responseCode=FALSE)

report.preprocessing::get_response_time_violin_plot_vs_threads(jdt,
                                                               scenario_name=NULL,
                                                               input_request_name=NULL,
                                                               group_by_label=TRUE,
                                                               interactive=TRUE,
                                                               split_by_responseCode=FALSE)

report.preprocessing::get_response_time_violin_plot_vs_threads(jdt,
                                                               scenario_name=NULL,
                                                               input_request_name=NULL,
                                                               group_by_label=TRUE,
                                                               interactive=TRUE,
                                                               split_by_responseCode=TRUE)


report.preprocessing::get_response_time_violin_plot_vs_threads(jdt,
                                                               scenario_name=scenario_name,
                                                               input_request_name=NULL,
                                                               group_by_label=TRUE,
                                                               interactive=FALSE,
                                                               split_by_responseCode=FALSE)

report.preprocessing::get_response_time_violin_plot_vs_threads(jdt,
                                                               scenario_name=scenario_name,
                                                               input_request_name=input_request_name,
                                                               group_by_label=TRUE,
                                                               interactive=FALSE,
                                                               split_by_responseCode=FALSE)

report.preprocessing::get_response_time_violin_plot_vs_threads(jdt,
                                                               scenario_name=NULL,
                                                               input_request_name=input_request_name,
                                                               group_by_label=TRUE,
                                                               interactive=TRUE,
                                                               split_by_responseCode=FALSE)

report.preprocessing::get_response_time_violin_plot_vs_threads(jdt,
                                                               scenario_name=NULL,
                                                               input_request_name=input_request_name,
                                                               group_by_label=FALSE,
                                                               interactive=TRUE,
                                                               split_by_responseCode=FALSE)

report.preprocessing::get_response_time_violin_plot_vs_threads(jdt,
                                                               scenario_name=NULL,
                                                               input_request_name=input_request_name,
                                                               group_by_label=TRUE,
                                                               interactive=TRUE,
                                                               split_by_responseCode=TRUE)

report.preprocessing::get_response_time_violin_plot_vs_threads(jdt,
                                                               scenario_name=NULL,
                                                               input_request_name=input_request_name,
                                                               group_by_label=FALSE,
                                                               interactive=TRUE,
                                                               split_by_responseCode=TRUE)

#### get_response_time_box_plot_vs_threads - tests ---------------
scenario_name <- "HELLO_WORLD_SCENARIO_NAME"
input_request_name <- "GET - get_paymants"

report.preprocessing::get_response_time_box_plot_vs_threads(jdt,
                                                               scenario_name=NULL,
                                                               input_request_name=NULL,
                                                               group_by_label=TRUE,
                                                               interactive=FALSE,
                                                               split_by_responseCode=FALSE)

report.preprocessing::get_response_time_box_plot_vs_threads(jdt,
                                                               scenario_name=NULL,
                                                               input_request_name=NULL,
                                                               group_by_label=FALSE,
                                                               interactive=FALSE,
                                                               split_by_responseCode=FALSE)

report.preprocessing::get_response_time_box_plot_vs_threads(jdt,
                                                               scenario_name=NULL,
                                                               input_request_name=NULL,
                                                               group_by_label=TRUE,
                                                               interactive=TRUE,
                                                               split_by_responseCode=FALSE)

report.preprocessing::get_response_time_box_plot_vs_threads(jdt,
                                                               scenario_name=NULL,
                                                               input_request_name=NULL,
                                                               group_by_label=TRUE,
                                                               interactive=TRUE,
                                                               split_by_responseCode=TRUE)


report.preprocessing::get_response_time_box_plot_vs_threads(jdt,
                                                               scenario_name=scenario_name,
                                                               input_request_name=NULL,
                                                               group_by_label=TRUE,
                                                               interactive=FALSE,
                                                               split_by_responseCode=FALSE)

report.preprocessing::get_response_time_box_plot_vs_threads(jdt,
                                                               scenario_name=scenario_name,
                                                               input_request_name=input_request_name,
                                                               group_by_label=TRUE,
                                                               interactive=FALSE,
                                                               split_by_responseCode=FALSE)

report.preprocessing::get_response_time_box_plot_vs_threads(jdt,
                                                               scenario_name=NULL,
                                                               input_request_name=input_request_name,
                                                               group_by_label=TRUE,
                                                               interactive=TRUE,
                                                               split_by_responseCode=FALSE)

report.preprocessing::get_response_time_box_plot_vs_threads(jdt,
                                                               scenario_name=NULL,
                                                               input_request_name=input_request_name,
                                                               group_by_label=FALSE,
                                                               interactive=TRUE,
                                                               split_by_responseCode=FALSE)

report.preprocessing::get_response_time_box_plot_vs_threads(jdt,
                                                               scenario_name=NULL,
                                                               input_request_name=input_request_name,
                                                               group_by_label=TRUE,
                                                               interactive=TRUE,
                                                               split_by_responseCode=TRUE)

report.preprocessing::get_response_time_box_plot_vs_threads(jdt,
                                                               scenario_name=NULL,
                                                               input_request_name=input_request_name,
                                                               group_by_label=FALSE,
                                                               interactive=TRUE,
                                                               split_by_responseCode=TRUE)


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

#### get_thoghput_per_second_by_labels_plot - test -------------

report.preprocessing::get_thoghput_per_second_by_labels_plot(jdt)
report.preprocessing::get_thoghput_per_second_by_labels_plot(jdt, scenario_name = "Hello world scenario")
report.preprocessing::get_thoghput_per_second_by_labels_plot(jdt, interactive = TRUE)
report.preprocessing::get_thoghput_per_second_by_labels_plot(jdt, scenario_name = "Hello world scenario", interactive = TRUE)


#### get_bar_quantile_plot - test ------------

report.preprocessing::get_bar_quantile_plot(input_dt=jdt, scenario_name=NULL, interactive=FALSE)
report.preprocessing::get_bar_quantile_plot(input_dt=jdt, scenario_name="Hello world scenario", interactive=FALSE)
report.preprocessing::get_bar_quantile_plot(input_dt=jdt, scenario_name=NULL, interactive=TRUE)
report.preprocessing::get_bar_quantile_plot(input_dt=jdt, scenario_name="Hello world scenario", interactive=TRUE)

