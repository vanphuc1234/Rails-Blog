module Api
  module V1
    class Comments < Grape::API
      resource :comments do
        desc 'Return all comments'
        get do
          all_comment = Comment.all
          comment_count = Comment.count(:id)
          { 'success': true,
            'count': comment_count,
            'data': all_comment }
        end

        desc 'Return a comment'
        get ':id' do
          comment = Comment.find_by_id(params[:id])
          if comment
            article = Article.find_by_id(comment.article_id)
            data = { 'comment': comment, 'article': article }
            { 'success': true, 'data': data }
          else
            { 'message': 'Data not found' }
          end
        end

        desc 'Post new comment' do
        end
        params do
          requires :commenter, type: String, description: 'Commenter'
          requires :body, type: String, description: 'Comment'
          requires :article_id, type: Integer, description: 'Article ID'
        end
        post do
          article = Article.find_by_id(params[:article_id])
          return { 'message': 'Article not found' } unless article

          comment = article.comments.create(commenter: params[:commenter], body: params[:body])

          { 'success': true, 'data': comment }
        end

        desc 'Update a comment' do
        end
        params do
          requires :body, type: String, description: 'Comment'
        end

        put ':id' do
          comment = Comment.find_by_id(params[:id])
          return { 'message': 'Comment not found' } unless comment

          comment.update(body: params[:body])
          return { 'message': comment.errors.full_messages.to_sentence } unless comment.errors.blank?

          { 'success': true, 'message': 'Update succesfully comment', 'data': comment }
        end

        desc 'Delete a comment' do
        end

        delete ':id' do
          comment = Comment.find_by_id(params[:id])
          return { 'message': 'Comment not found' } unless comment

          comment.destroy
          { 'success': true, 'message': 'Delete succesfully comment' }
        end
        #########
      end
    end
  end
end
