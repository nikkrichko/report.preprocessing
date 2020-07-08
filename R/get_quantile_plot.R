#' Return plot of response times in quantile order
#'
#' This function provide quantile order with response times for labels.
#' @param input_dt input cleaned jmeter log data table
#' @param scenario_name add string to highlight scenario name in subtitle.
#' @param group_by_label split labels by colors.
#' @param interactive convert ggplot to interactive plotly.
#' @keywords vizualization
#' @keywords response_time
#' @export
#' @examples
#' get_response_time_plot(jdt)
#' @import data.table
#' @import ggplot2
#' @import plotly

get_quantile_plot <-
function(input_dt, scenario_name=NULL, group_by_label=TRUE, interactive=FALSE){

  plot_title <- "Response times in quantile order"

  input_dt$request_name <- as.factor(input_dt$label)

  if(group_by_label){
    setorder(input_dt,label,response_time)
    input_dt[, id := range01(seq_len(.N)), by = label]
  } else {
    setorder(input_dt,response_time)
  }

  gp <- ggplot(input_dt) +
    scale_x_continuous(labels = scales::percent)+
    geom_vline(xintercept=0.5, linetype="dashed",
               color = "darkgreen", size=1.5) +
    geom_text(aes(x=0.5, label="Median",
                  y=quantile(response_time, 0.25)),
              colour="darkgreen",
              angle=90, vjust = -1,
              text=element_text(size=11))+
    geom_vline(xintercept=0.9, linetype="dashed",
               color = "orange", size=1.5) +
    geom_text(aes(x=0.9, label="90 quantile",
                  y=quantile(response_time, 0.50)),
              colour="orange",
              angle=90, vjust = -1,
              text=element_text(size=11)) +
    geom_vline(xintercept=0.95, linetype="dashed",
               color = "red", size=1.5) +
    geom_text(aes(x=0.95, label="95 quantile",
                  y=quantile(response_time, 0.25)),
              colour="red",
              angle=90, vjust = -1,
              text=element_text(size=11)) +
    theme_minimal() +
    labs(x="quantile",
         y="response time",
         title =  plot_title,
         subtitle = toupper(scenario_name),
         caption = NULL,
         color="Request name")+
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1),
          plot.subtitle = element_text(face = "bold",size =15))



  if(group_by_label){
    result_plot <- gp + geom_point(data=input_dt, aes(x=id, y=response_time, color=request_name))
  } else {
    x_axis <- range01(sort(seq_len(NROW(input_dt))))
    result_plot <- gp + geom_point(aes(x=x_axis, y=response_time),color="blue")
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


range01 <- function(x){(x-min(x))/(max(x)-min(x))}
