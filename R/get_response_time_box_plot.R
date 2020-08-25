#' Return box plot of response times
#'
#' This function provide response times boxplots for labels.
#' @param input_dt input cleaned jmeter log data table
#' @param scenario_name add string to highlight scenario name in subtitle.
#' @param group_by_label split labels by colors.
#' @param interactive convert ggplot to interactive plotly.
#' @keywords vizualization
#' @keywords response_time
#' @export
#' @examples
#' get_response_time_box_plot(jdt)
#' @import data.table
#' @import ggplot2
#' @import plotly


get_response_time_box_plot <-
function(input_dt, scenario_name=NULL, group_by_label=TRUE, interactive=FALSE){

    input_dt$request_name <- as.factor(input_dt$label)
    plot_title <- "Response time box plot"

    gp <- ggplot(input_dt,aes(y = response_time)) +
      theme_minimal() +
      labs(x="request_name",
           y="response time",
           title = plot_title,
           subtitle = toupper(scenario_name),
           caption = NULL,
           color="Request name")+
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1),
            plot.subtitle = element_text(face = "bold",size =15))


    if(group_by_label){
      result_plot <-  gp + geom_boxplot(aes(x=request_name,fill=request_name))

    } else {
      result_plot <-  gp + geom_boxplot(fill="#0c4c8a") +
        theme(axis.title.x = element_blank(),
              axis.text.x = element_blank())
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

