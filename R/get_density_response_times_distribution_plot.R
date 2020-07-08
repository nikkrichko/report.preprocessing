#' Return destiny of response times
#'
#' This function provide plot with destiny of response times times for labels.
#' @param input_dt input cleaned jmeter log data table
#' @param scenario_name add string to highlight scenario name in subtitle.
#' @param group_by_label split labels by colors.
#' @param interactive convert ggplot to interactive plotly.
#' @keywords vizualization
#' @keywords response_time
#' @export
#' @examples
#' get_density_response_times_plot(jdt)
#' @import data.table
#' @import ggplot2
#' @import plotly


get_density_response_times_plot <-
function(input_dt, scenario_name=NULL, group_by_label=TRUE, interactive=FALSE){
  input_dt$request_name <- as.factor(input_dt$label)
  input_dt[,":="("response_time_group"=cut(response_time, breaks = c(seq(0,max(input_dt$response_time+100),100)), include.lowest = TRUE,dig.lab = 5)),]

  plot_title <- "Response times density"

  gp <- ggplot() +
    theme_minimal() +
    labs(x="time",
         y="density",
         title =  plot_title,
         subtitle = toupper(scenario_name),
         caption = NULL,
         color="Request name")+
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1),
          plot.subtitle = element_text(face = "bold",size =15))


  if(group_by_label){
    result_plot <-  gp + geom_density(alpha=.3,data=input_dt,aes(x = response_time,fill=request_name))
  } else {
    result_plot <-  gp + geom_density(alpha=.3,data=input_dt,aes(x = response_time), fill="#0c4c8a")
  }

  if(interactive){
    result_plot <- plotly::ggplotly(result_plot) %>%
      plotly::layout(title = list(text = paste(plot_title,
                                                '<br>',
                                                '<sup><b style="font-size:15px">',
                                                toupper(scenario_name),
                                                '</b></sup>')))

  }

  result_plot
}
