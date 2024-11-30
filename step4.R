# load R packages
library(tidyverse)
library(tidytext)

# load data
articles <- read_tsv("clean/processed_titles.tsv")

# Break the title down into words
titles_tokens <- articles %>%
  unnest_tokens(word, title)

# Count the total frequency of each word and choose the 12 most common words
top_words <- titles_tokens %>%
  count(word, sort = TRUE) %>%
  top_n(12, n) %>%
  pull(word)

# Filter out the most common words and count them by year
word_year_counts <- titles_tokens %>%
  filter(word %in% top_words) %>%
  count(Year, word, sort = TRUE)

# Plot the frequency change of each word in different years
ggplot(word_year_counts, aes(x = Year, y = n, color = word, group = word)) +
  geom_line() +
  geom_point() +
  facet_wrap(~ word, scales = "free_y") +
  labs(title = "Top 12 Most Common Words Frequency Over Time",
       x = "Year",
       y = "Frequency",
       color = "Word") +
  theme_light() +
  theme(panel.grid.major.x = element_blank(), 
        panel.grid.minor = element_blank(), 
        legend.position = "bottom")

# save results
ggsave("clean/top_12_words_frequency_over_time.png", width = 12, height = 8)
