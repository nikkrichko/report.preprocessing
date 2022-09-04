library(optparse)
library(data.table)
options(scipen = 999)



compres_numbers <- function(number) { 
  div <- findInterval(as.numeric(gsub("\\,", "", number)), 
                      c(0, 1e3, 1e6, 1e9, 1e12) )  # modify this if negative numbers are possible
  paste(round( as.numeric(gsub("\\,","",number))/10^(3*(div-1)), 2), 
        c("","K","M","B","T")[div] )
}

compres_numbers_title <- function(number) { 
  div <- findInterval(as.numeric(gsub("\\,", "", number)), 
                      c(0, 1e3, 1e6, 1e9, 1e12) )  # modify this if negative numbers are possible
  paste(round( as.numeric(gsub("\\,","",number))/10^(3*(div-1)), 2), 
        c("","thouthands","Millions","Billions","Trillions")[div] )
}

# like_in <- function(input_dt, input_column, like_in_list){
#   input_dt[Reduce(`|`, Map(`%like%`, list(get(input_column)), like_in_list))]
# }

"%like_in%" <- function(vector, pattern_list, ignore.case = TRUE, fixed = FALSE) {
  pattern <- paste(condition_list, collapse = "|")
  grepl(pattern, vector, ignore.case = ignore.case, fixed = fixed)
}

save_plot <- function(file_path_name,plot_to_save, input_width=16, input_height=9){
  if(!is.null(file_path_name)){
    fileName_to_save <- paste(file_path_name,".png",sep="")
    ggsave(fileName_to_save,plot_to_save,width = input_width, height = input_height, dpi = 250, units = "in", device='png')
    print(paste("plot successfully saved:",getwd(),"/",fileName_to_save))
  }
}

add_company_logo <- function(input_gg_plot, img_url){
  logo_img <- image_read(img_url) 
  input_gg_plot <- ggdraw() + 
    draw_plot(input_gg_plot,x = 0, y = 0.025, width = 1, height = .97)+
    draw_image(logo_img,x = 0.83, y = 0.86, width = 0.15, height = 0.15)
  input_gg_plot
}


text_x_angle <- function(input_ggplot, input_angle=45){
  input_ggplot + theme(axis.text.x = element_text(angle = input_angle, vjust = 0.9, hjust=1))
}


text_y_angle <- function(input_ggplot, input_angle=45){
  input_ggplot + theme(axis.text.y = element_text(angle = input_angle, vjust = 0.9, hjust=1))
}


get_hm <- function(input_time){
  minute_value <- as.character(minute(input_time))
  hour_value <- as.character(hour(input_time))
  
  minute_value <- ifelse(nchar(minute_value)<2,paste("0",minute_value, sep = ""),minute_value)
  hour_value <- ifelse(nchar(hour_value)<2,paste("0",hour_value, sep = ""),hour_value)
  
  paste(hour_value,":",minute_value,sep="")
}


get_hm_hundreds <- function(input_time){
  require(lubridate)
  return(as.numeric(paste(hour(input_time),minute(input_time),sep="")))
}


rounded_quantile <- function(input_field, input_quantile){
  result <- round(quantile(input_field, input_quantile, na.rm = TRUE) *100,2)
  return(result)
}

rounded_max <- function(input_field){
  result <- round(max(input_field, na.rm = TRUE) *100,2)
  return(result)
}

rounded_min <- function(input_field){
  result <- round(min(input_field, na.rm = TRUE) *100,2)
  return(result)
}

render_table <- function(input_dt){
  require(DT)
  DT::datatable(input_dt, filter = 'top',
                class = 'cell-border stripe',
                extensions = "Buttons", 
                options = list(paging = TRUE,
                               scrollX=TRUE, 
                               searching = TRUE,
                               ordering = TRUE,
                               dom = 'lBfrtip',
                               lengthMenu = list(c(10, 20,50, -1), c('10', '20','50', 'All')),
                               pageLength = 10,
                               
                               
                               buttons = c('copy', 'csv', 'excel')
                ))
}

makeInitials <- function(charVec) {
  vapply(strsplit(toupper(charVec), " "), 
         function(x) paste(substr(x, 1, 1), collapse = ""), 
         vector("character", 1L))
}

make_abreviature <- function(input_string){
  temp_res <- str_extract_all(input_string, '[A-Z1-9]+')
  paste(temp_res[[1]],collapse = "")
}


wrapped_expandable_ggplot <- function(input_ggplot, input_title){
  cat("\n\n")
  cat("\n\n")
  cat("<details><summary style='background-color: #EEEEEE;color: #333333; padding: 2px 6px 2px 6px; border-top: 1px solid #CCCCCC; border-right: 1px solid #333333; border-bottom: 1px solid #333333; border-left: 1px solid #CCCCCC;'>", input_title, "  (expand & click)</summary>")
  cat("\n\n")
  print(input_ggplot)
  cat("\n\n")
  cat("</details>")
  cat("\n\n")
  
  cat("\n\n --- \n\n <input type=\"button\" onclick=\"location.href='#top';\" value=\"Back to top\" />")
  cat("\n\n")
}

get_system_variable <- function(var_name){
  sys_var <- Sys.getenv(var_name, unset = NA)
  if(is.na(sys_var)){
    if("rstudioapi" %in% rownames(installed.packages())){
      sys_var <- rstudioapi::showPrompt(title="Input your variable", 
                                        message=paste("Enter value for",var_name), 
                                        default = NULL)
      print(paste("Value for",var_name, "successfully enter with interactive window"))
      # return(sys_var)
    } else {
      print(paste("ERROR : there is no system variable with named >>",var_name,"<<"))
      print(paste("ERROR : check >>",var_name,"<< in your system variables"))
      print(paste0("ERROR : try to export it like:", sep=""))
      print(paste0("export ",var_name,"=%your_value%"), sep="")
      opt <- options(show.error.messages = FALSE)
      on.exit(options(opt))
      stop()
    }
  }
  sys_var
}

read_jmeter_logs <- function(input_file){
  print(input_file)
  temp_file <- read_csv(input_file) %>% as.data.table()
  if(NROW(temp_file)>1){
    
    temp_file <- temp_file %>% report.preprocessing::clean_jmeter_log()
    random_name_id <- randomNames::randomNames(1, name.sep = "_")
    temp_file$id_test_run <- random_name_id
      
    return(temp_file)
  } else {
    return(NA)
  }
}


read_jmeter_logs_from_folders <- function(input_folder){
  lf <- paste(input_folder,
              list.files(path=input_folder,pattern = ".jtl", recursive = TRUE),sep = "/")
  
  jl_list <- lapply(lf, read_jmeter_logs)
  
  temp_list <- list()
  for(item_list in seq_along(jl_list)){
    print(item_list)
    if(is.data.frame(jl_list[item_list][[1]])){
      temp_list[item_list] <- jl_list[item_list]
    }
  }
  
  result_dt <- rbindlist(temp_list, use.names = TRUE, fill = TRUE)
  rm(temp_list)
  rm(jl_list)
  result_dt
}

get_aggregate_table <- function(input_dt, by_grp_threads=FALSE, target_column="response_time"){
  options(scipen = 99999)
  temp_dt_2 <- input_dt[,.("amount_of_samples"=.N,
                           "AVG"=round(mean(get(target_column), na.rm = TRUE)),
                           "q25"=round(quantile(get(target_column),.25, na.rm = TRUE)),
                           "minimum"=round(min(get(target_column),na.rm = TRUE)),
                           "median"=round(median(get(target_column), na.rm = TRUE)),
                           "q75"=round(quantile(get(target_column),.75, na.rm = TRUE)),
                           "q90"=round(quantile(get(target_column),.9, na.rm = TRUE)),
                           "q95"=round(quantile(get(target_column),.95, na.rm = TRUE)),
                           "q99"=round(quantile(get(target_column),.99, na.rm = TRUE)),
                           "maximum"=max(get(target_column), na.rm = TRUE),
                           "error_rate"=percent(-1*((sum(success)/.N)-1))
  ), by=request_name]
  
  if(by_grp_threads){
    temp_dt_2 <- input_dt[,.("amount_of_samples"=.N,
                             "AVG"=round(mean(get(target_column), na.rm = TRUE)),
                             "minimum"=round(min(get(target_column), na.rm = TRUE)),
                             "q25"=round(quantile(get(target_column),.25, na.rm = TRUE)),
                             "median"=round(median(get(target_column), na.rm = TRUE)),
                             "q75"=round(quantile(get(target_column),.75, na.rm = TRUE)),
                             "q90"=round(quantile(get(target_column),.9, na.rm = TRUE)),
                             "q95"=round(quantile(get(target_column),.95, na.rm = TRUE)),
                             "q99"=round(quantile(get(target_column),.99, na.rm = TRUE)),
                             "maximum"=max(get(target_column), na.rm = TRUE),
                             "error_rate"=percent(-1*((sum(success)/.N)-1))
    ), by=.(request_name,grp_threads)]
    temp_dt_2 <- add_type_to_dt(temp_dt_2)
    setorder(temp_dt_2, request_name,grp_threads)
    return(temp_dt_2)
  }
  
  
  result_dt <- temp_dt_2 %>% as.data.table()
  temp_dt_2 <- add_type_to_dt(temp_dt_2)
  setorder(temp_dt_2, request_name)
  result_dt
}

replace_brackets <- function(input_string){
  input_string %>% gsub("\\(|]|\\[","",.) %>% gsub(",","...",.)
}

get_all_results <- function(input_filtder_with_fst="/Users/mkrychko/jmeter_logs/clean_logs/"){
  require(tictoc)
  require(fst)
  require(fs)
  
  path_to_read <- input_filtder_with_fst
  fst_files <- fs::dir_ls(path_to_read)  %>% unlist()
  fst_files <- fst_files[endsWith(fst_files,".fst")]
  tic("read_big fst")
  big_fst_dt <- lapply(fst_files, read.fst, as.data.table=TRUE) %>% rbindlist(.,use.names = TRUE, fill=TRUE)
  toc()
  big_fst_dt
}

add_type_to_dt <- function(input_dt){
  input_dt$request_type <- "none"
  input_dt[request_name %like% "backend"]$request_type <- "backend"
  input_dt[request_name %like% "elk"]$request_type <- "elastic"
  input_dt[request_name %like% "elastic"]$request_type <- "elastic"
  input_dt[request_name %like% "web"]$request_type <- "web"
  input_dt
}

telegram_message <- function(input_msg, with_time=TRUE){
  require(lubridate)
  require(httr)
  require(tidyverse)
  
  TG_BOT_API_KEY <- get_system_variable("TG_BOT_API_KEY")
  CHAT_ID_MYKYTA_DIRECT <- get_system_variable("CHAT_ID_MYKYTA_DIRECT")
  CURRENT_COMPANY <- get_system_variable("CURRENT_COMPANY")
  
  if(with_time){
    time <- format(Sys.time(), "%H:%M:%OS")
    input_msg <- paste(time,input_msg,sep = "\n" )
  }
 
  input_msg <- paste(CURRENT_COMPANY,":",input_msg, sep = "\n" )
  
  input_msg <- input_msg %>% 
    gsub(":","%3A",.) %>% 
    gsub(" ", "%20",.) %>% 
    gsub("\\n","%0D%0A",.)
  
  telegram_api_request <- paste("https://api.telegram.org/bot",TG_BOT_API_KEY,
                      "/sendMessage?chat_id=",CHAT_ID_MYKYTA_DIRECT,
                      "&text=", 
                      input_msg, sep="")
  httr::GET(telegram_api_request)
}