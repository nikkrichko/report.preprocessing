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
