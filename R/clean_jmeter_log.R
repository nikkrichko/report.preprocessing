library(data.table)
library(janitor)
library(randomNames)
library(tidyverse)
library(scales)
options(scipen = 99999)




#' A clean jmeter logs
#'
#' This function allows you to clean jmeter jtl log file and prepare it for further analysis.
#' @param input_dt Do you love cats? Defaults to TRUE.
#' @param delete_ending_digets if label have numeric variables in the end and you want to delete it leave TRUE.
#' @param delete_words_from_labels some times you want to clean some words for more easily reading or grouping by label. You can add words what do you want to delete.
#' @param labels_to_delete_list delete some requests which you dont want to see in report. You and add full label name or at least some words. not case sensitive.
#' @keywords clean
#' @keywords preprocessing
#' @export
#' @examples
#' clean_jmeter_log(jdt_dirty)
#' @import data.table


clean_jmeter_log <- function(input_dt,
                             delete_ending_digets=TRUE,
                             delete_words_from_labels = c("new", "post","variables"),
                             labels_to_delete_list=c("init","JDBC","auth - with password","Debug", "JSR223", "config") ){
  require(data.table)

  input_dt <- as.data.table(input_dt)
  input_dt$timeStamp <- as.numeric(input_dt$timeStamp)
  input_dt$dateTime <- as.POSIXct(input_dt$timeStamp/1000, origin="1970-01-01")
  input_dt$responseCode <- as.factor(input_dt$responseCode)
  input_dt$responseMessage <- as.factor(input_dt$responseMessage)
  input_dt$elapsed <- as.numeric(input_dt$elapsed)
  input_dt$date <- as.Date(input_dt$dateTime)
  input_dt$time <- format(input_dt$dateTime, "%H:%M:%OS3")
  input_dt$fulltime <- as.POSIXct(input_dt$timeStamp/1000, origin="1970-01-01")
  input_dt$success <- as.logical(input_dt$success)
  input_dt$Latency <- as.numeric(input_dt$Latency)
  input_dt$response_time <- input_dt$elapsed


  input_dt <- delete_specific_words(input_dt,delete_words_from_labels)
  # input_dt <- trim_spaces_start_end(input_dt)
  # input_dt <- delete_label(input_dt,input_list_to_delete=labels_to_delete_list)

  input_dt <- input_dt %>%
    trim_spaces_start_end() %>%
    add_load_group() %>%
    add_rps_and_group() %>%
    delete_label(.,input_list_to_delete=labels_to_delete_list)

  if(delete_ending_digets){
    input_dt <- delete_digets_in_the_end(input_dt)
  }

  input_dt <- input_dt[timeStamp > 1]
  input_dt <- janitor::clean_names(input_dt, "snake")
  input_dt

}

delete_label <- function(input_dt, input_list_to_delete=c("init","JDBC","auth - with password","Debug"), na.rm.label=TRUE){
  require(data.table)
  input_dt <- as.data.table(input_dt)

  for (item in input_list_to_delete){
    input_dt <- input_dt[!grepl(tolower(item),tolower(label)),]
  }

  if(na.rm.label){
    input_dt <- input_dt[!is.na(label)][!(label %like% "NA")][!is.na(label)]
  }
  input_dt
}

add_load_group <- function(input_dt){
  require(data.table)
  input_dt <- as.data.table(input_dt)
  input_dt[,":="("load_group"=cut(allThreads, breaks = c(1,seq(5,10001,5)), include.lowest = TRUE)),]
  input_dt[allThreads == 1,load_group :="1"]
  input_dt
}

add_rps_and_group <- function(input_dt){
  require(data.table)
  input_dt <- as.data.table(input_dt)
  input_dt[,":="("rps"=.N),by=dateTime]
  input_dt[,":="("load_rps_group"=cut(rps, breaks = c(1,seq(5,10001,5)), include.lowest = TRUE)),]
  input_dt[rps == 1,load_rps_group :="1"]
  input_dt
}

trim_spaces_start_end <- function(input_dt){
  input_dt$label <- input_dt$label %>% gsub(" $", "",.) %>% gsub("^ ", "",.)
  input_dt
}

delete_digets_in_the_end <- function(input_dt){
  input_dt$label <- input_dt$label %>% gsub("\\d+$", "",.) %>% gsub("\\W+$", "",.)  %>% gsub("^\\W+", "",.)
  input_dt
}

delete_specific_words <- function(input_dt, delete_words_list=NULL){
  if(!is.null(delete_words_list)){
    for (delete_word in delete_words_list){
      input_dt$label <- input_dt$label %>% sub(delete_word, "", ., ignore.case = TRUE)
    }
  }
  input_dt
}

get_uuid <- function(){
  if(.Platform$OS.type == "unix"){
    return(system("uuidgen", intern=T))
  }
  if(.Platform$OS.type == "linux"){
    return(system("uuid",intern=T))
  }
  if(.Platform$OS.type == "windows"){
    return(paste(
      substr(baseuuid,1,8),
      "-",
      substr(baseuuid,9,12),
      "-",
      "4",
      substr(baseuuid,13,15),
      "-",
      sample(c("8","9","a","b"),1),
      substr(baseuuid,16,18),
      "-",
      substr(baseuuid,19,30),
      sep="",
      collapse=""
    ))
  }
}

get_aggregate_table <- function(input_dt){
  temp_dt_1 <- input_dt
  temp_dt_1[,":="(start_time=min(date_time),end_time=max(date_time),amount=.N), by=label]
  temp_dt_1[,":="(duration=round(as.numeric(end_time-start_time,units="mins")))]
  temp_dt_1[,":="(troughput_per_min=round(amount/as.numeric(duration)))]
  temp_dt_1 <- unique(temp_dt_1[,.(label,troughput_per_min)]) %>% as.data.table()

  temp_dt_2 <- input_dt[,.("amount_of_samples"=.N,
                           "AVG"=round(mean(response_time)),
                           "minimum"=min(response_time),
                           "median"=round(median(response_time)),
                           "q90"=round(quantile(response_time,.9)),
                           "q95"=round(quantile(response_time,.95)),
                           "q99"=round(quantile(response_time,.99)),
                           "maximum"=max(response_time),
                           "error_rate"=percent(sum(success)/.N)
  ), by=label]

  result_dt <- left_join(temp_dt_2,temp_dt_1) %>% as.data.table()
  result_dt
}


# TODO CHECK RPS correctnes









# l1 <- c(" POST - getCustomerNotes - 7 "," GET - faceBook - 10 ")
#
# l1 <- l1 %>% gsub(" $", "",.) %>% gsub("^ ", "",.)
#
# l1 %>% gsub("\\d+$", "",.) %>% gsub("\\W+$", "",.)
#
#
# l2 <- c(" POST - getCustomerNotes - 7 "," GET - faceBook - 10 new","add transaction (variables)")
# l2 %>% sub("variables", "", ., ignore.case = TRUE)
#
#
# for (delete_word in delete_words){
#   l2 <- l2 %>% sub(delete_word, "", ., ignore.case = TRUE)
# }

# inputDataTable[,":="(api_start_time=min(date_time),api_end_time=max(date_time)), by=search_type]
# inputDataTable[,":="(api_duration=round(as.numeric(api_end_time-api_start_time,units="mins")))]
# inputDataTable[,":="(api_amount=.N),by=search_type]
# inputDataTable[,":="(api_per_min=round(api_amount/as.numeric(api_duration)))]
# inputDataTable[,":="(api_rps_per_request=.N), by=.(search_type,date_time)]

# if(is.null(inputBuildName)){
#   inputBuildName <- paste(randomNames(1,name.sep="_",name.order="first.last"), sample.int(1000, 1), sep="_")
# }
# input_dt$build_id <- inputBuildName
#
# dt[ , per := prop.table(`sum(count)`) , by = "x"]
#
# input_dt$success
# input_dt[,.() , by = label]
#
# table(input_dt$success)
# input_dt[rps == 2]$success <- FALSE
#
# percent()
#
#
# prop.table(input_dt$success)
#
#
# troughput
# recieved_kb.sec
# send_kb_sec
