# frozen_string_literal: true

require_relative '../config/database'

# Repository for books
class BooksRepository
  def initialize(db = DB)
    @books = db[:books]
  end

  def all
    @books.all
  end

  def find(id)
    @books.where(id: id).first
  end

  # Create a new book
  # @param book [Hash] The book to create
  # @return [Hash] The created book
  # @raise [StandardError] If the title or author is not provided
  def create(book)
    validate_book(book)

    @books.insert(book)
  end

  # Update an existing book
  # @param id [String] The ID of the book to update
  # @param book [Hash] The book to update
  # @return [Hash] The updated book
  def update(id, book)
    validate_book(book)

    book[:updated_at] = Time.now.utc
    @books.where(id: id).update(book)
  end

  # Delete a book
  # @param id [String] The ID of the book to delete
  # @return [Hash] The deleted book
  # @raise [StandardError] If the book doesn't exist
  def delete(id)
    book = find(id)
    raise 'Book not found' if book.nil?

    @books.where(id: id).delete
  end

  private

  def validate_book(book)
    raise 'Title is required' if book[:title].nil?
    raise 'Author is required' if book[:author].nil?
  end
end
