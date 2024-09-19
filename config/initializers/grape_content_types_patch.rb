# Fix issue: uninitialized constant Grape::ContentTypes::CONTENT_TYPES
module Grape
  module ContentTypes
    CONTENT_TYPES = {
      'json' => 'application/json',
      'xml' => 'application/xml'
      # Add more content types if needed
    }
  end
end
