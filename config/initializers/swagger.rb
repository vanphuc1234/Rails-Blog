GrapeSwaggerRails.options.app_name = 'Rails aricles'
GrapeSwaggerRails.options.before_action do
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
end
