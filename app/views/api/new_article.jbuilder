if !@article.errors.blank?
  json.message @article.errors.full_messages.to_sentence
else
  json.success true
  json.data do
    json.call(@article, :id, :title, :text)
  end
end
