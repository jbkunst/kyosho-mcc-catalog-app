library(tidyverse)

data <- fs::dir_ls("data/json/") |>
  map(read_lines) |>
  map(jsonlite::fromJSON) |>
  map(as_data_frame) |>
  bind_rows() |>
  type_convert()

glimpse(data)
