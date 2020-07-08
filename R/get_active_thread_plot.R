# TODO documentation
#' This function provide plot active threads during tests.
#' @param input_dt input cleaned jmeter log data table
#' @param scenario_name add string to highlight scenario name in subtitle.
#' @param interactive convert ggplot to interactive plotly.
#' @keywords vizualization
#' @keywords response_time
#' @export
#' @examples
#' get_active_thread_plot(jdt)
#' @import data.table
#' @import ggplot2
#' @import plotly

get_active_thread_plot <-
function(input_dt, scenario_name=NULL, interactive=FALSE){


    input_dt <- unique(input_dt[,.(date_time,all_threads)])


    gp <- ggplot() +
      theme_minimal() +
      labs(x="time",
           y="Active thread",
           title =  "Active threads graph",
           subtitle = toupper(scenario_name),
           caption = NULL)+
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1),
            plot.subtitle = element_text(face = "bold",size =15)) +
      geom_point(data=input_dt, aes(x=date_time, all_threads), color="#0c4c8a")
    result_plot <- gp

    if(interactive){
      result_plot <- plotly::ggplotly(result_plot) %>%
        plotly::layout(title = list(text = paste0("Active thread graph",
                                                  '<br>',
                                                  '<sup><b>',
                                                  toupper(scenario_name),
                                                  '</b></sup>')))

    }

    result_plot
  }
