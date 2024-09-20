if @article
  json.success true
  json.data do
    json.call(@article, :id, :title, :text)
  end
else
  json.message 'Article not found'
end
