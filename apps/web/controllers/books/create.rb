module Web::Controllers::Books
  class Create
    include Web::Action

    expose :book
    
    params do
      required(:book).schema do
        required(:title).filled(:str?)
        required(:author).filled(:str?)
      end
      # param :book do
      #   param :title,  presence: true
      #   param :author, presence: true
      # end
    end

    def call(params)
      if params.valid?
        repository = BookRepository.new
        @book = repository.create(Book.new(params[:book]))

        # redirect_to routes.books_path
        redirect_to routes.bookcontainer_path
      end
    end
  end
end
