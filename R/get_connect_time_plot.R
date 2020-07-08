#' Return connection times plot
#'
#' This function provide plot with connection times for labels.
#' @param input_dt input cleaned jmeter log data table
#' @param scenario_name add string to highlight scenario name in subtitle.
#' @param group_by_label split labels by colors.
#' @param interactive convert ggplot to interactive plotly.
#' @keywords vizualization
#' @keywords response_time
#' @export
#' @examples
#' get_connect_time_plot(jdt)
#' @import data.table
#' @import ggplot2
#' @import plotly


get_connect_time_plot <-
function(input_dt, scenario_name=NULL, group_by_label=TRUE, interactive=FALSE){

    input_dt$request_name <- as.factor(input_dt$label)

    plot_title <- "Connect times graph"

    gp <- ggplot(input_dt,aes(x = date_time, y = connect)) +
      theme_minimal() +
      labs(x="time",
           y="connection time",
           title =  plot_title,
           subtitle = toupper(scenario_name),
           caption = NULL,
           color="Request name")+
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1),
            plot.subtitle = element_text(face = "bold",size =15))


    if(group_by_label){
      result_plot <-  gp + geom_point(aes(color=request_name))
    } else {
      result_plot <-  gp + geom_point(color="#0c4c8a")
    }

    if(interactive){
      result_plot <- plotly::ggplotly(result_plot) %>%
        plotly::layout(title = list(text = paste0(plot_title,
                                                  '<br>',
                                                  '<sup><b style="font-size:15px">',
                                                  toupper(scenario_name),
                                                  '</b></sup>')))

    }

    result_plot
  }
