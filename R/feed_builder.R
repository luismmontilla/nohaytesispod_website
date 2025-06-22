source("R/extract_post_data.R")

post_files <- list.files(
  "episodes", 
  pattern = "\\.qmd$", 
  full.names = TRUE, 
  recursive = TRUE
  )

# Extract metadata and content for all posts
posts <- lapply(post_files, extract_post_data)

# Create the feed
feed <- list(
  version = "https://jsonfeed.org/version/1",
  title = "De esto no hay tesis",
  home_page_url = "https://www.nohaytesispodcast.com",
  feed_url = "https://www.nohaytesispodcast.com/episodes.json",
  items = posts
)

# Convert to JSON
feed_json <- toJSON(feed, pretty = TRUE, auto_unbox = TRUE)

# Save the JSON feed to a file
write(feed_json, file = "episodes.json")
