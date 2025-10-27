# packages ---------------------------------------------------------------
library(tidyverse)
library(fs)
library(ellmer)

# funs -------------------------------------------------------------------
save_json <- tool(
  function(json, file) {
    cli::cli_inform("save_json func: {file} - start")

    file_out <- file
    file_out <- tools::file_path_sans_ext(basename(file_out))
    file_out <- str_glue("data/json/{file_out}.json")

    json |>
      jsonlite::fromJSON(simplifyVector = TRUE) |>
      jsonlite::toJSON(pretty = TRUE, auto_unbox = TRUE) |>
      write(file_out)

    cli::cli_inform("save_json func: {file} - end")
  },
  name = "save_json",
  description = "Save the JSON using the provided information",
  arguments = list(
    json = type_string("The JSON provided by the structured output"),
    file = type_string("The original filename of the image")
  )
)

# data -------------------------------------------------------------------
images <- fs::dir_ls("data/imgs/raw/") |>
  as.character()

# remove processed images
images <- tibble(image = images) |>
  mutate(f = basename(tools::file_path_sans_ext(image))) |>
  filter(
    !f %in% basename(tools::file_path_sans_ext(fs::dir_ls("data/json/")))
  ) |>
  pull(image)

chat <- ellmer::chat_openai(
  system_prompt = read_lines("prompts/01-extract-image-info.md"),
  model = "gpt-4o",
  # model = "gpt-4o-mini",
  echo = "none"
)
# chat <- ellmer::chat_anthropic(system_prompt = prompt, echo = "none")

chat$register_tool(save_json)

# process ----------------------------------------------------------------
# prompts <- interpolate("{{images_content}}")
# length(prompts)
# output <- parallel_chat(chat, prompts)

output <- map(images, chat = chat, .f = function(image_path, chat) {
  cli::cli_inform("the {image_path}")
  chat <- chat$clone()
  chat$chat(
    str_glue("the image file name is {image_path} and the content is"),
    content_image_file(image_path)
  )
})

# # sometimes the chat don't use the tool :/
output |>
  map(1) |>
  map(str_remove, "```json") |>
  map(str_remove, "```$") |>
  walk2(images, save_json)

# json <- output |>
#   map(1) |>
#   map(str_remove, "```json") |>
#   map(str_remove, "```$") |>
#   first()
# file <- "miniature_lexus_lfa.jpg"
