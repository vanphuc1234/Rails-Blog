# This file is used by Rack-based servers to start the application.
require 'grape/jbuilder'

require_relative 'config/environment'

use Rack::Config do |env|
  env['api.tilt.root'] = Rails.root.join 'app', 'views', 'api'
end

run Rails.application
Rails.application.load_server
