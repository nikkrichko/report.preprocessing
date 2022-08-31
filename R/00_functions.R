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

add_percona_logo <- function(input_gg_plot, img_url){
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

input_time <- Sys.time()
Sys.time() %>% get_hm_hundreds()
Sys.time() %>% get_hm()


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
