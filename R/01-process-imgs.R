# packages ---------------------------------------------------------------
library(tidyverse)
library(fs)
library(ellmer)

# funs -------------------------------------------------------------------
save_json <- tool(
  function(json, file) {
    cli::cli_inform(file)

    file_out <- file
    file_out <- tools::file_path_sans_ext(basename(file_out))
    file_out <- str_glue("data/json/{file_out}.json")

    json |>
      jsonlite::fromJSON(simplifyVector = TRUE) |>
      jsonlite::toJSON(pretty = TRUE, auto_unbox = TRUE) |>
      write(file_out)

    cli::cli_inform("{file} ok!")
    return("ok!")
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

images_content <- map(images, content_image_file) |>
  map("data")

prompt <- read_lines("prompts/01-extract-image-info.md")

chat <- ellmer::chat_openai(
  system_prompt = prompt,
  model = "gpt-4o-mini",
  echo = "none"
)
# chat <- ellmer::chat_anthropic(system_prompt = prompt, echo = "none")

chat$register_tool(save_json)

# process ----------------------------------------------------------------
prompts <- interpolate("The image {{ images }} is {{images_content}}?")

length(prompts)

output <- map(prompts, chat = chat, .f = function(p, chat) {
  chat <- chat$clone()
  chat$chat(p)
})

# sometimes the chat don't use the tool :/
output |>
  map(1) |>
  map(str_remove, "```json") |>
  map(str_remove, "```$") |>
  map2(images, save_json)

# output <- parallel_chat(chat, prompts)
# output
