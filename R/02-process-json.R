library(tidyverse)

data <- fs::dir_ls("data/json/") |>
  map(read_lines) |>
  map(jsonlite::fromJSON) |>
  map(as_data_frame) |>
  map(function(df) {
    mutate(df, across(where(is.character), ~ na_if(trimws(.x), "")))
  }) |>
  # pasa lo que fue "" a NA (lgl)
  map(type_convert) |>
  bind_rows() |>
  type_convert()

data

glimpse(data)
