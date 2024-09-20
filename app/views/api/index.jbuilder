json.success true
json.count @articles_count
json.data @all_articles, :id, :title, :text
