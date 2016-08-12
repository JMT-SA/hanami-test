module Web::Controllers::Books
  class Index
    include Web::Action

    expose :books, :more_books

    def call(params)
      @books = BookRepository.all
      # Call dm with filename & params
      # @more_books = BookRepository.dataminer_fetch('book_index')
      # @more_books = BookRepository.dataminer_fetch('book_index', dm_params: {author: {value: 'John', operator: '<>'}}, limit: 10)
      # @more_books = BookRepository.dataminer_fetch('book_index', dm_params: {author: {value: 'John', operator: '<>'}}, limit: 10, order: 'id')
      @more_books = BookRepository.dataminer_fetch('book_index', quick_params: {author: 'John'}, limit: 10, order: 'id DESC')
      #TODO: pass seamlessly into grid...
    end
  # def load_index
  #   hs = { columnDefs: [
  #   {headerName: "id", field: "id"},
  #   {headerName: "Name", field: "branch_name"},
  #   {headerName: "Created", field: "created_at"},
  #   {headerName: "Updated", field: "updated_at"},
  #   ], rowDefs: Branch.all}
  #   render json: hs, status: :ok
  # end

  end
end
