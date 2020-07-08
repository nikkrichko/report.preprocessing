#' Return plot of response times with errors
#'
#' This function provide plot with response times with errors for labels.
#' @param input_dt input cleaned jmeter log data table
#' @param scenario_name add string to highlight scenario name in subtitle.
#' @param group_by_label split labels by colors.
#' @param interactive convert ggplot to interactive plotly.
#' @keywords vizualization
#' @keywords response_time
#' @export
#' @examples
#' get_response_times_with_errors_plot(jdt)
#' @import data.table
#' @import ggplot2
#' @import plotly



get_response_times_with_errors_plot <-
function(input_dt, scenario_name=NULL, group_by_label=TRUE, interactive=FALSE){

    input_dt$request_name <- as.factor(input_dt$label)
    input_dt$response_code <- as.factor(input_dt$response_code)

    input_dt <- unique(input_dt[,.(date_time,response_time,request_name,success, response_code)])


    gp <- ggplot() +
      theme_minimal() +
      labs(x="time",
           y="request per second",
           title =  "Response time splited response code graph",
           subtitle = toupper(scenario_name),
           caption = NULL,
           color="Response code",
           shape="Request name")+
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1),
            plot.subtitle = element_text(face = "bold",size =15))

    if(group_by_label){
      result_plot <-  gp + geom_point(data=input_dt[response_code == 200],
                                        aes(x = date_time, y = response_time, shape=request_name), color="#00ff00") +
                           geom_point(data=input_dt[response_code != 200],
                                       aes(x = date_time, y = response_time,shape=request_name, color=response_code))
    } else {
      result_plot <-  gp + geom_point(data=input_dt[response_code == 200],
                                      aes(x = date_time, y = response_time), color="#00ff00") +
                          geom_point(data=input_dt[response_code != 200],
                                     aes(x = date_time, y = response_time, color=response_code))
    }

    if(interactive){
      result_plot <- plotly::ggplotly(result_plot) %>%
        plotly::layout(title = list(text = paste0("Response time graph",
                                                  '<br>',
                                                  '<sup><b>',
                                                  toupper(scenario_name),
                                                  '</b></sup>')))

    }

    result_plot
  }
