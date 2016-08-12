module Web::Controllers::Books
  class Grid
    include Web::Action

    expose :hs

    def call(params)
      self.format = :json
      more_books = BookRepository.dataminer_fetch('book_index')
      # more_books = BookRepository.dataminer_fetch('book_index', quick_params: {author: 'John'}, limit: 10, order: 'id DESC')
      Web::Logger.debug ">>> ---acting---"
      @hs = { columnDefs: [
      {headerName: "id", field: "id"},
      {headerName: "Author", field: "author"},
      {headerName: "Title", field: "title"}
      ], rowDefs: more_books}
      #], rowDefs: more_books.to_json}
      Web::Logger.debug ">>> ---jsoning---"

      # This bypasses the view.
      # self.status = 200
      # self.body = @hs.to_json
      #
      # ...desired API:
      # self.format = :json
      # data = Repository.grid_from_dataminer('book_index')
      # self.status = 200
      # self.body = data
      # rescue...

      # @books = BookRepository.all
      # # Call dm with filename & params
      # # @more_books = BookRepository.dataminer_fetch('book_index')
      # # @more_books = BookRepository.dataminer_fetch('book_index', dm_params: {author: {value: 'John', operator: '<>'}}, limit: 10)
      # # @more_books = BookRepository.dataminer_fetch('book_index', dm_params: {author: {value: 'John', operator: '<>'}}, limit: 10, order: 'id')
      # @more_books = BookRepository.dataminer_fetch('book_index', quick_params: {author: 'John'}, limit: 10, order: 'id DESC')
      # #TODO: pass seamlessly into grid...
    end

  end
end

