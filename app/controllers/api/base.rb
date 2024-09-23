require 'grape-swagger'

module Api
  class Base < Grape::API
    version 'v1', using: :path

    format :json
    formatter :json, Grape::Formatter::Jbuilder
    prefix :api

    mount Api::V1::Base

    add_swagger_documentation(
      mount_path: '/swagger_doc',
      format: :json, # Ensure you're specifying the correct format
      content_type: 'application/json'
    )
  end
end
