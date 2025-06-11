# frozen_string_literal: true

require_relative '../repositories/books_repository'

# Service for books
class BooksService
  def initialize(repository = BooksRepository.new)
    @repo = repository
  end

  def list_books
    @repo.all
  end

  def get_book(id)
    @repo.find(id)
  end

  def create_book(book)
    @repo.create(book.transform_keys(&:to_sym))
  end

  def update_book(id, book)
    @repo.update(id, book.transform_keys(&:to_sym))
    @repo.find(id)
  end

  def delete_book(id)
    @repo.delete(id)
  rescue StandardError => e
    raise e if e.message == 'Book not found'

    raise "Error deleting book: #{e.message}"
  end
end
