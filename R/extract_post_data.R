library(rmarkdown)
library(yaml)
library(jsonlite)

# Function to extract metadata and content from an Rmd file
extract_post_data <- function(filepath) {
  rmd_content <- readLines(filepath)
  yaml_end <- grep("^---$", rmd_content)[2]
  yaml_header <- paste(rmd_content[1:yaml_end], collapse = "\n")
  metadata <- yaml::yaml.load(yaml_header)

  ep_id = strsplit(filepath, split = "/")
  
  content <- paste(rmd_content[(yaml_end + 16):length(rmd_content)], 
                   collapse = "\n")
  list(
    id = ep_id[[1]][2],
    doi = metadata$doi,
    abstract = metadata$abstract,
    language = metadata$lang,
    url = paste0("https://www.nohaytesispodcast.com/episodes/",ep_id[[1]][2]),
    title = gsub(".*- ","", metadata$title),
    content_text = content,
    date_published = metadata$date,
    author = metadata$author
  )
}
