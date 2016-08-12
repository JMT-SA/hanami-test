module Web::Controllers::Books
  class Index
    include Web::Action

    expose :books, :more_books

    def call(params)
      @books = BookRepository.all
      # Call dm with filename & params
      # @more_books = DataminerControl.dataminer_fetch(BookRepository, 'book_index')
      # @more_books = DataminerControl.dataminer_fetch(BookRepository, 'book_index', dm_params: {author: {value: 'John', operator: '<>'}}, limit: 10)
      # @more_books = DataminerControl.dataminer_fetch(BookRepository, 'book_index', dm_params: {author: {value: 'John', operator: '<>'}}, limit: 10, order: 'id')
      @more_books = DataminerControl.dataminer_fetch(BookRepository, 'book_index', quick_params: {author: 'John'}, limit: 10, order: 'id DESC')
    end

  end
end
