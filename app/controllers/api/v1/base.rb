require 'grape-swagger'

module Api
  module V1
    class Base < Grape::API
      version 'v1', using: :path

      format :json

      prefix :api

      mount Api::V1::Articles
    end
  end
end
