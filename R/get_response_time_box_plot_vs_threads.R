#' Return BOX plots of response times vs active threads
#'
#' This function provide quantile order with response times for labels.
#' @param input_dt input cleaned jmeter log data table
#' @param input_request_name allow to filter input data for specific request.
#' @param scenario_name add string to highlight scenario name in subtitle.
#' @param group_by_label split labels by colors.
#' @param interactive convert ggplot to interactive plotly.
#' @param split_by_responseCode allow facet plot by response code.
#' @keywords vizualization
#' @keywords response_time
#' @export
#' @examples
#' get_response_time_box_plot_vs_threads(jdt)
#' @import data.table
#' @import ggplot2
#' @import plotly



get_response_time_box_plot_vs_threads <-
function(input_dt, scenario_name=NULL,input_request_name=NULL, group_by_label=TRUE, interactive=FALSE,split_by_responseCode=FALSE){

    if(!is.null(input_request_name)){
      input_dt <- input_dt[request_name == input_request_name]
    }
    input_dt$all_threads <- as.factor(input_dt$all_threads)
    input_dt$request_name <- as.factor(input_dt$request_name)


    plot_title <- "Response time box plot vs threads"

    gp <- ggplot(input_dt) +
      theme_minimal() +
      labs(x="active threads",
           y="response time",
           title = plot_title,
           subtitle = toupper(scenario_name),
           caption = NULL,
           color="Request name")+
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1),
            plot.subtitle = element_text(face = "bold",size =15))


    if(group_by_label){
      result_plot <-  gp + geom_boxplot(aes(x=all_threads, y=response_time, fill=request_name))
    } else {
      result_plot <-  gp + geom_boxplot(aes(x=all_threads, y=response_time), fill="#0c4c8a")
    }

    if(split_by_responseCode){
      result_plot <- result_plot + facet_wrap(.~response_code) + ggtitle(paste(plot_title), "splitted by response codes")
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
