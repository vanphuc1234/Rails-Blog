module Api
  module V1
    class Articles < Grape::API
      formatter :json, Grape::Formatter::Jbuilder

      resource :articles do
        desc 'Return all article'
        params do
          requires :page, type: Integer, description: 'Page', default: 1
          optional :per_page, type: Integer, description: 'Per page', default: 5
        end
        get '', jbuilder: 'index' do
          limit = params[:per_page]
          offset = (params[:page] - 1) * limit
          @all_articles = Article.offset(offset).limit(limit).order(:id)
          @articles_count = Article.count(:id)
        end

        desc 'Return an article'
        get ':id', jbuilder: 'show_article' do
          @article = Article.find_by_id(params[:id])
        end

        desc 'Post new article' do
        end
        params do
          requires :title, type: String, description: 'Title'
          requires :description, type: String, description: 'Description'
        end
        post '', jbuilder: 'new_article' do
          @article = Article.new(title: params[:title], text: params[:description])
          @article.save
        end

        desc 'Update an article' do
        end
        params do
          requires :title, type: String, description: 'Title'
          requires :description, type: String, description: 'Description'
        end
        put ':id' do
          @article = Article.find_by_id(params[:id])
          return { 'message': 'Data not found' } unless @article

          @article.update(title: params[:title], text: params[:description])
          return { 'message': @article.errors.full_messages.to_sentence } unless @article.errors.blank?

          env['api.tilt.template'] = 'edit_article'
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
