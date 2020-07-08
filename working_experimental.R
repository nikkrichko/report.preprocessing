#install.packages("devtools")
library("devtools")
#devtools::install_github("klutometis/roxygen")
library(roxygen2)
library(here)
library(tidyverse)
library(data.table)

#install.packages("devtools")
devtools::install_github("nikkrichko/report.preprocessing")


getwd()



detach("report.preprocessing", character.only = TRUE)


setwd("D:/github/report.preprocessing")
document()

setwd("D:/github/report.preprocessing/..")
# setwd("..")

install("report.preprocessing")
library(report.preprocessing)

# path <- "D:/github/jmeter_test_log.jtl"
# jdt <- fread(path) %>% as.data.table() %>% clean_jmeter_log()




jdt <- clean_jmeter_log(report.preprocessing::jdt_dirty)
get_response_time_plot(jdt)



#install.packages("devtools")
devtools::install_github("nikkrichko/report.preprocessing")

dump("get_response_time_plot", file = "report.preprocessing/R/get_response_time_plot.R")
dump("get_rps_plot", file = "report.preprocessing/R/get_rps_plot.R")
dump("get_response_times_with_errors_plot", file = "report.preprocessing/R/get_response_times_with_errors_plot.R")
dump("get_active_thread_plot", file = "report.preprocessing/R/get_active_thread_plot.R")
dump("get_thoghput_per_second_plot", file = "report.preprocessing/R/get_thoghput_per_second_plot.R")



jdt_dirty <- jdt


#### CREATE INTERNAL DATA ----------------------
path <- "D:/github/jmeter_test_log.jtl"
jdt <- fread(path) %>% as.data.table()


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
##############

# assign("jdt_dirty", "jdt_prep")
# use_data(jdt_dirty, pkg = ".")
#
# use_data(jdt_dirty, internal = TRUE)
use_data(jdt_dirty, internal = FALSE, overwrite = TRUE)



table(jdt_dirty$URL)
jdt_dirty[URL %like% "hintmd"]












