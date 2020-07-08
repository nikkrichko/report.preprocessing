# TODO documentation
#' This function provide plot with response times with errors for labels.
#' @param input_dt input cleaned jmeter log data table
#' @param scenario_name add string to highlight scenario name in subtitle.
#' @param interactive convert ggplot to interactive plotly.
#' @keywords vizualization
#' @keywords response_time
#' @export
#' @examples
#' get_thoghput_per_second_plot(jdt)
#' @import data.table
#' @import ggplot2
#' @import plotly


get_thoghput_per_second_plot <-
function(input_dt, scenario_name=NULL, interactive=FALSE){
    input_dt <- clean_jmeter_log(report.preprocessing::jdt_dirty)
    input_dt <- input_dt[,.(date_time=floor_date(ymd_hms(input_dt$date_time), "seconds"), label,recieved_byted=bytes, sent_bytes)]
    input_dt[,":="("recieved_per_second"=sum(recieved_byted), "sent_per_second"=sum(sent_bytes)),by=date_time][,"bytes_thoghput_per_second":=recieved_per_second+sent_per_second]

    result_plot <- ggplot() +
      theme_minimal() +
      labs(x="time",
           y="bytes thoghput per second",
           title =  "Bytes thoghput per second graph",
           subtitle = toupper(scenario_name),
           caption = NULL,
           colour="legend")+
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1),
            plot.subtitle = element_text(face = "bold",size =15)) +
      geom_point(data=input_dt, aes(x=date_time, y=bytes_thoghput_per_second, color="Total throughput (sum)"), show.legend = TRUE)+
      geom_point(data=input_dt, aes(x=date_time, y=sent_per_second, color="sent_bytes"), show.legend = TRUE)+
      geom_point(data=input_dt, aes(x=date_time, y=recieved_per_second, color="recieved_bytes") , show.legend = TRUE)+
      guides(col = guide_legend(override.aes = list(shape = 15, size = 10)))


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
