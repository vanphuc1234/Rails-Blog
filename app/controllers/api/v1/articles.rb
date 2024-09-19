module Api
  module V1
    class Articles < Grape::API
      resource :articles do
        desc 'Return all article'
        get do
          Article.limit(10)
        end
      end
    end
  end
end
