% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clean_jmeter_log.R
\name{clean_jmeter_log}
\alias{clean_jmeter_log}
\title{A clean jmeter logs}
\usage{
clean_jmeter_log(
  input_dt,
  delete_ending_digets = TRUE,
  delete_words_from_labels = c("new", "post", "variables"),
  labels_to_delete_list = c("init", "JDBC", "auth - with password", "Debug", "JSR223",
    "config")
)
}
\arguments{
\item{input_dt}{Do you love cats? Defaults to TRUE.}

\item{delete_ending_digets}{if label have numeric variables in the end and you want to delete it leave TRUE.}

\item{delete_words_from_labels}{some times you want to clean some words for more easily reading or grouping by label. You can add words what do you want to delete.}

\item{labels_to_delete_list}{delete some requests which you dont want to see in report. You and add full label name or at least some words. not case sensitive.}
}
\description{
This function allows you to clean jmeter jtl log file and prepare it for further analysis.
}
\examples{
clean_jmeter_log(jdt_dirty)
}
\keyword{clean}
\keyword{preprocessing}
