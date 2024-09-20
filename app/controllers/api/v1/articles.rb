module Api
  module V1
    class Articles < Grape::API
      resource :articles do
        desc 'Return all article'

        get do
          all_articles = Article.all
          articles_count = Article.count(:id)
          { 'success': true,
            'count': articles_count,
            'data': all_articles }
        end

        desc 'Return an article'
        get ':id' do
          article = Article.find_by_id(params[:id])
          if article
            { 'success': true, 'data': article }
          else
            { 'message': 'Data not found' }
          end
        end

        desc 'Post new article' do
        end
        params do
          requires :title, type: String, description: 'Title'
          requires :description, type: String, description: 'Description'
        end
        post do
          article = Article.new(title: params[:title], text: params[:description])
          article.save
          return { 'message': article.errors.full_messages.to_sentence } unless article.errors.blank?

          { 'success': true, 'data': article }
        end

        desc 'Update an article' do
        end
        params do
          requires :title, type: String, description: 'Title'
          requires :description, type: String, description: 'Description'
        end
        put ':id' do
          article = Article.find_by_id(params[:id])
          return { 'message': 'Data not found' } unless article

          article.update(title: params[:title], text: params[:description])
          return { 'message': article.errors.full_messages.to_sentence } unless article.errors.blank?

          { 'success': true, 'message': 'Update succesfully article', 'data': article }
        end

        desc 'Delete an article' do
        end

        delete ':id' do
          article = Article.find_by_id(params[:id])
          return { 'message': 'Data not found' } unless article

          article.destroy
          { 'success': true, 'message': 'Delete succesfully article' }
        end
        ###########
      end
    end
  end
end
