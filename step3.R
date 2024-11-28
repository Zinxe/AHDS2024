library(tidyverse)
library(tidytext)
library(SnowballC)

# load data
dta <- read_tsv('clean/articles.tsv')

# process titles
tokens <- dta %>%
  unnest_tokens(word, Title) %>% # Segmentation
  anti_join(stop_words) %>%                  # Remove stop words
  filter(!str_detect(word, "\\d")) %>%       # Remove digits
  mutate(word = wordStem(word, language = "en")) %>%  #Reduce words to their stem

  # recombination
  group_by(PMID, Year) %>%
  summarize(title = paste(word, collapse = " "), .groups = "drop")

# save result
write_tsv(tokens, "clean/processed_titles.tsv")
