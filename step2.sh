#!/bin/bash

# setting files roads
ARTICLES_XML="raw/article-data-*.xml"
OUTPUT_FILE="clean/articles.tsv"

# write .tsv file
echo -e "PMID\tYear\tTitle" > "$OUTPUT_FILE"

# Iterate over each XML file
for file in $ARTICLES_XML
do

  # read file
  content=$(cat "$file")

  # get PMIDs
  pmid=$(echo "$content" | grep "<PMID" | sed 's/.*<PMID[^>]*>\(.*\)<\/PMID>.*/\1/')

  # get Year
  year=$(echo "$content" | grep "<PubDate>" -A 3 | grep "<Year>" | sed 's/.*<Year>\(.*\)<\/Year>.*/\1/')

  # get Title
  title=$(echo "$content" | grep "<ArticleTitle>" | sed 's/.*<ArticleTitle>\(.*\)<\/ArticleTitle>.*/\1/')

  #clean xml tag
  title=$(echo "$title" | sed 's/<i>//g')
  title=$(echo "$title" | sed 's/<\/i>//g')

  # If Title exists, written to the output file
  if [ -n "$pmid" ] && [ -n "$year" ] && [ -n "$title" ]; then
    echo -e "${pmid}\t${year}\t${title}" >> "$OUTPUT_FILE"
  fi
done

echo "Processing complete. Results saved to $OUTPUT_FILE"

echo "Done!"





