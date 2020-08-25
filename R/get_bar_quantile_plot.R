#' Return bar plot of response times devided by quantiles
#'
#' This function provide bar plot with response times for labels devided by quantiles.
#' @param input_dt input cleaned jmeter log data table
#' @param scenario_name add string to highlight scenario name in subtitle.
#' @param interactive convert ggplot to interactive plotly.
#' @keywords vizualization
#' @keywords response_time
#' @export
#' @examples
#' get_bar_quantile_plot(jdt)
#' @import data.table
#' @import ggplot2
#' @import plotly
#' @import plyr


get_bar_quantile_plot <-
function(input_dt, scenario_name=NULL, interactive=FALSE){


csrt <- input_dt[,.(request_name,response_time)]
csrtshort <- csrt[, .("quantile_50" = as.double(median(response_time)),
                      "quantile_75" = quantile(response_time,0.75),
                      "quantile_90" = quantile(response_time,0.9),
                      "quantile_95" = quantile(response_time,0.95),
                      "quantile_99" = quantile(response_time,0.99)), by=request_name]
csrtshort[,"q50":=quantile_50]
csrtshort[,"q75":=quantile_75-quantile_50]
csrtshort[,"q90":=quantile_90-quantile_75]
csrtshort[,"q95":=quantile_95-quantile_90]
csrtshort[,"q99":=quantile_99-quantile_95]

gather_csrtshort<- gather(csrtshort, key = "quantile",value = "value", q50,q75,q90,q95,q99) %>% as.data.table()
setorder(gather_csrtshort, request_name)

gather_csrtshort <- gather_csrtshort[,.(request_name,quantile_99,quantile, value)]


gather_csrtshort_cum <- plyr::ddply(gather_csrtshort, "request_name",
                              transform,
                              label_ypos=round(cumsum(value),0)) %>% as.data.table()
#maxbp <- 3000


maxbp <- plyr::round_any((max(csrtshort$quantile_99)+100), 100, f = ceiling)
if(maxbp < 1000) {maxbp <- 1500}
# listOfThreads <- paste0(sort("inputThread"), collapse = ", ")
plot_title <- paste("Barplot response time witnin for different quantiles")
gp <- ggplot(data=gather_csrtshort, aes(x=reorder(request_name, quantile_99), y=value, fill=quantile)) +
  geom_bar(stat="identity", position = position_stack(reverse = TRUE)) +
  theme_minimal() +
  scale_fill_manual(values=c("#33FFFF", "#33FF33","#FFFF33","#FF9933","#FF3333")) +
  coord_flip() +
  labs(title = plot_title,
       subtitle = scenario_name,
       x= "Request name",
       y = "response time in ms") +
  scale_y_continuous(breaks = seq(0, maxbp, by = plyr::round_any(maxbp/10,100, f = ceiling))) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1),
        plot.subtitle = element_text(face = "bold",size =15))

result_plot <- gp

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
