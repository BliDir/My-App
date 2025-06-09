require 'sinatra/base'
require 'sinatra/namespace'
require_relative '../config/logger'

module Routes
  class Hello < Sinatra::Base
    register Sinatra::Namespace

    namespace '/v1' do
      get '/hello' do
        LOGGER.info('Hello world! (v1)')
        { version: 'v1', message: 'Hello world!' }.to_json
      end

      get '/hello/:name' do
        LOGGER.info("Hello #{params[:name]}! (v1)")
        { version: 'v1', message: "Hello #{params[:name]}!" }.to_json
      end
    end

    namespace '/v2' do
      get '/hello' do
        LOGGER.info('Hello world! (v2)')
        { 
          version: 'v2',
          message: 'Hello world!',
          timestamp: Time.now.iso8601
        }.to_json
      end

      get '/hello/:name' do
        LOGGER.info("Hello #{params[:name]}! (v2)")
        { 
          version: 'v2',
          message: "Hello #{params[:name]}!",
          timestamp: Time.now.iso8601
        }.to_json
      end
    end
  end
end