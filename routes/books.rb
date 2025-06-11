# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/namespace'
require 'rack/request'
require_relative '../config/logger'
require_relative '../services/books_service'
require_relative '../lib/error_handler'

module Routes
  # Handles book-related HTTP endpoints
  class Books < Sinatra::Base
    register Sinatra::Namespace

    # Module containing route handlers and validation methods for book endpoints
    module Handlers
      extend Sinatra::Helpers

      # Register routes for the book endpoints
      def self.registered(app)
        define_list_route(app)
        define_show_route(app)
        define_create_route(app)
        define_update_route(app)
        define_delete_route(app)
      end

      def self.define_list_route(app)
        app.get '/books' do
          BooksService.new.list_books.to_json
        end
      end

      def self.define_show_route(app)
        app.get '/books/:id' do
          validate_id(params[:id])
          book = BooksService.new.get_book(params[:id])
          halt 404, { error: 'Book not found' }.to_json if book.nil?
          book.to_json
        end
      end

      def self.define_create_route(app)
        app.post '/books' do
          payload = JSON.parse(request.body.read)
          validate_book_data(payload)
          book = BooksService.new.create_book(payload)
          status 201
          book.to_json
        rescue StandardError => e
          LOGGER.error("Error creating book: #{e.message}")
          halt 500, { error: 'Internal Server Error' }.to_json
        end
      end

      def self.define_update_route(app)
        app.put '/books/:id' do
          validate_id(params[:id])
          payload = JSON.parse(request.body.read)
          validate_book_data(payload)
          book = BooksService.new.update_book(params[:id], payload)
          book.to_json
        end
      end

      def self.define_delete_route(app)
        app.delete '/books/:id' do
          validate_id(params[:id])
          BooksService.new.delete_book(params[:id])
          status 204
        rescue StandardError => e
          if e.message == 'Book not found'
            halt 404, { error: 'Book not found' }.to_json
          else
            LOGGER.error("Error deleting book: #{e.message}")
            halt 500, { error: 'Internal Server Error' }.to_json
          end
        end
      end
    end

    # Register the routes
    namespace '/v1' do
      register Handlers
    end

    private

    def validate_book_data(data)
      validate_required_fields(data)
      validate_field_types(data)
    end

    def validate_required_fields(data)
      required_fields = %w[title author]
      missing_fields = required_fields - data.keys

      halt 400, { error: "Missing required fields: #{missing_fields.join(', ')}" }.to_json if missing_fields.any?
    end

    def validate_field_types(data)
      validate_string_field(data, 'title')
      validate_string_field(data, 'author')
    end

    def validate_string_field(data, field)
      return if data[field].is_a?(String) && !data[field].empty?

      halt 400, { error: "#{field.capitalize} must be a non-empty string" }.to_json
    end

    def validate_id(id)
      return if id.empty? || !id.is_a?(String)
      return if id.match?(/\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i)

      halt 400, { error: 'Invalid ID format' }.to_json
    end
  end
end
