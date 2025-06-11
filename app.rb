require 'bundler/setup'
require 'sinatra/base'
require_relative 'config/environment'
require_relative 'routes/books'

class App < Sinatra::Base
  use Routes::Books

  error do
    LOGGER.error(env['sinatra.error'].message)
    status 500
    { error: 'Internal Server Error' }.to_json
  end
end

if $PROGRAM_NAME == __FILE__
  App.run!
end