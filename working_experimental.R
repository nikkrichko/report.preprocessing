#install.packages("devtools")
library("devtools")
#devtools::install_github("klutometis/roxygen")
library(roxygen2)
library(here)
library(tidyverse)
library(data.table)
library(usethis)

#install.packages("devtools")
devtools::install_github("nikkrichko/report.preprocessing")


getwd()



detach("report.preprocessing", character.only = TRUE)

# rm(list = c(".N", "get_html_report", "get_response_time_box_plot_vs_threads", "get_response_time_violin_plot_vs_threads"))

setwd("D:/github/report.preprocessing")
devtools::document()
# check()
setwd("D:/github/report.preprocessing/..")
# setwd("..")

devtools::install("report.preprocessing")
library(report.preprocessing)

# report.preprocessing:::get_html_report()
report.preprocessing:::generate_report(input_jtl_file_path="D:/github/jmeter_test_log.jtl", output_file = "jtl.html")
report.preprocessing:::generate_report(input_data_table=report.preprocessing::jdt_dirty, output_file = "jtl_input_dt.html")
report.preprocessing:::generate_test_report()


# path <- "D:/github/jmeter_test_log.jtl"
# jdt <- fread(path) %>% as.data.table() %>% clean_jmeter_log()


# DONE - add throughtput splitted by labels
# TODO - change plot title policy
# DONE - connect time over time
# DONE - latancies ofer time
# TODO - add to hint (response time plot) latency and connections
# DONE - response times distribution (by label)
# DONE - response times density (by label)
# DONE - Response times percentiles (by label)
# DONE - Response times boxplot (by label + load group)
# DONE - Response times violin plot (by label + load group)
# DONE - add to boxplots load group
# DONE - add to violin load group
# TODO - response time over thread
# TODO - RT  over load group
# TODO - RT over RPS
# TODO - RT over RPS - load group
# TODO - RT vs resopnse code
# TODO - RPS by label and all
# TODO - percentile distribution by labels general) and splited by load groups




jdt <- clean_jmeter_log(report.preprocessing::jdt_dirty)
get_response_time_plot(jdt)



#install.packages("devtools")
devtools::install_github("nikkrichko/report.preprocessing")

dump("get_response_time_plot", file = "report.preprocessing/R/get_response_time_plot.R")
dump("get_rps_plot", file = "report.preprocessing/R/get_rps_plot.R")
dump("get_response_times_with_errors_plot", file = "report.preprocessing/R/get_response_times_with_errors_plot.R")
dump("get_active_thread_plot", file = "report.preprocessing/R/get_active_thread_plot.R")
dump("get_thoghput_per_second_plot", file = "report.preprocessing/R/get_thoghput_per_second_plot.R")
dump("get_thoghput_per_second_by_labels_plot", file = "report.preprocessing/R/get_thoghput_per_second_by_labels_plot.R")
dump("get_connect_time_plot", file = "report.preprocessing/R/get_connect_time_plot.R")
dump("get_latency_time_plot", file = "report.preprocessing/R/get_latency_time_plot.R")
dump("get_histogram_response_times_distribution_plot", file = "report.preprocessing/R/get_histogram_response_times_distribution_plot.R")
dump("get_density_response_times_distribution_plot", file = "report.preprocessing/R/get_density_response_times_distribution_plot.R")
dump("get_quantile_plot", file = "report.preprocessing/R/get_quantile_plot.R")
dump("get_response_time_box_plot", file = "report.preprocessing/R/get_response_time_box_plot.R")
dump("get_response_time_violin_plot", file = "report.preprocessing/R/get_response_time_violin_plot.R")
dump("get_response_time_box_plot_vs_threads", file = "report.preprocessing/R/get_response_time_box_plot_vs_threads.R")
dump("get_response_time_violin_plot_vs_threads", file = "report.preprocessing/R/get_response_time_violin_plot_vs_threads.R")
dump("get_html_report", file = "report.preprocessing/R/get_html_report.R")
dump("get_bar_quantile_plot", file = "report.preprocessing/R/get_bar_quantile_plot.R")



get_bar_quantile_plot


get_html_report <- function(){
  rmarkdown::render("test.Rmd")
}

  knitr::render_html()
jdt_dirty <- jdt


#### CREATE INTERNAL DATA ----------------------
library(truncnorm)
library(data.table)
library(tidyverse)
setwd("D:/github/report.preprocessing")
path <- "D:/github/jmeter_test_log.jtl"
report.preprocessing::clean_jmeter_log(fread(path))
jdt_dirty <- fread(path) %>% as.data.table()


l_labels <- rep(c("POST - auth"," GET - get_query", "GET - get_friends"," GET - get_recommendations"), 2192/4) %>%
paste(., sample(1000,2192/4), sep =" - ")

jdt_dirty[!(label %like% "auth")][label %like% "POST"]$label <- l_labels


jdt_dirty[(label %like% "JDBC count orgids for next steps")]$label <- "JDBC count DB elemnets for next steps"
jdt_dirty[(label %like% "add transaction (variables)")]$label <- "transaction (variables)"
jdt_dirty[(label %like% "init JDBC get DB name")]$label <- "init config get DB name (preps)"



jdt_dirty[!(label %like% "with password")][(label %like% "POST - auth")]$URL <- rep(c("https://google.com/auth_v3",
                                                                                         "https://yandex.com/auth_v2"),548/2)



jdt_dirty[!(label %like% "with password")][(URL %like% "https://google.com/auth_v3")]$elapsed <- round(rnorm(NROW(jdt_dirty[!(label %like% "with password")][(URL %like% "https://google.com/auth_v3")]),300,50))
jdt_dirty[!(label %like% "with password")][(URL %like% "https://yandex.com/auth_v2")]$elapsed <- round(rnorm(NROW(jdt_dirty[!(label %like% "with password")][(URL %like% "https://yandex.com/auth_v2")]),2800,300))


##############

jdt_dirty[URL %like% "kronos"]$URL <- paste("https://AWS.developer.api",paste(sample(c(letters[1:6],0:9),64,replace=TRUE),collapse=""))

jdt_dirty[(label %like% "GET - get_query")]$URL <- "https://google.com/query?hello_world"
jdt_dirty[(label %like% "GET - get_query")]$URL <- "https://yandex.com/query?hahaha"

jdt_dirty[(label %like% "GET - get_query")][(URL %like% "https://google.com/query?hello_world")]$elapsed <- round(rnorm(NROW(jdt_dirty[!(label %like% "with password")][(URL %like% "https://google.com/query?hello_world")]),1300,50))
jdt_dirty[(label %like% "GET - get_query")][(URL %like% "https://yandex.com/query?hahaha")]$elapsed <- round(rnorm(NROW(jdt_dirty[!(label %like% "with password")][(URL %like% "https://yandex.com/query?hahaha")]),500,50))


##############

jdt_dirty[(label %like% "GET - get_friends")]$URL <- "https://facebook.com/get_friends"
jdt_dirty[(label %like% "GET - get_recommendations")]$URL <- "https://facebook.com/get_recommendations"

jdt_dirty[(label %like% " GET - get_friends")][(URL %like% "https://facebook.com/get_friends")]$elapsed <- round(rnorm(NROW(jdt_dirty[!(label %like% "with password")][(URL %like% "https://facebook.com/get_friends")]),200,50))
jdt_dirty[(label %like% " GET - get_recommendations")][(URL %like% "https://facebook.com/get_recommendations")]$elapsed <- round(rnorm(NROW(jdt_dirty[!(label %like% "with password")][(URL %like% "https://facebook.com/get_recommendations")]),1000,40))


jdt_dirty <- jdt_dirty[!(label %like% "transaction")]
jdt_dirty$allThreads <- sample(c(1,5,10,15,20), 2208, replace = TRUE)
jdt_dirty[,elapsed := elapsed * allThreads * 0.75 ]

temp_dt <- jdt_dirty[(label %like% " GET - get_recommendations")]
temp_dt$label <- "POST - get_query"
temp_dt$URL <- "https://facebook.com/get_query"

# table(temp_dt$allThreads)

# [, id := range01(seq_len(.N)), by = label]

temp_dt[, elapsed := abs(rnorm(seq_len(.N), allThreads* 100 * 0.33, 150)), by = label]
temp_dt[allThreads == 15]$elapsed <- abs(rnorm(seq_len(NROW(temp_dt[allThreads == 15])), 500, 200))
temp_dt[allThreads == 20]$elapsed <- abs(rnorm(seq_len(NROW(temp_dt[allThreads == 20])), 500, 600))




temp_dt2 <- jdt_dirty[(label %like% " GET - get_recommendations")]
temp_dt2$label <- "GET - get_paymants"
temp_dt2$URL <- "https://facebook.com/get_paymants"

temp_dt2[, elapsed := abs(rnorm(seq_len(.N), allThreads* 100 * 0.33, 100)), by = label]
temp_dt2[allThreads == 15]$elapsed <- abs(rtruncnorm(seq_len(NROW(temp_dt2[allThreads == 15])),0,1000, 400, 100))
temp_dt2[allThreads == 20]$elapsed <- abs(rtruncnorm(seq_len(NROW(temp_dt2[allThreads == 20])),0,900, 375, 300))
NROW(temp_dt2[allThreads == 20])
lq <- quantile(temp_dt2[allThreads == 20]$elapsed, 0.25)
uq <- quantile(temp_dt2[allThreads == 20]$elapsed, 0.75)
med <- quantile(temp_dt2[allThreads == 20]$elapsed, 0.5)

temp_dt2[allThreads == 20]$elapsed <- c(rtruncnorm(seq_len(NROW(temp_dt2[allThreads == 20])/2),0,lq+100, lq, 25),rtruncnorm(seq_len(NROW(temp_dt2[allThreads == 20])/2),uq-100,900, uq, 25))
temp_dt2[allThreads == 20][elapsed >= med]$responseCode <- 200
temp_dt2[allThreads == 20][elapsed < med]$responseCode <- 400
temp_dt2[allThreads == 20][elapsed < med]$success <- FALSE



jdt_dirty <- rbindlist(list(jdt_dirty, temp_dt, temp_dt2))

str(jdt_dirty)
jdt_dirty$timeStamp <- as.character(jdt_dirty$timeStamp)
##############

# assign("jdt_dirty", "jdt_prep")
# use_data(jdt_dirty, pkg = ".")
#
# use_data(jdt_dirty, internal = TRUE)
usethis::use_data(jdt_dirty, internal = FALSE, overwrite = TRUE)
table(jdt_dirty$allThreads)












