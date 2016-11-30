module Web::Controllers::Books
  class Update
    include Web::Action

    expose :book
    
    params do
      required(:id)
      required(:book).schema do
        required(:title).filled(:str?)
        required(:author).filled(:str?)
      end
      # param :id
      # param :book do
      #   param :title,  presence: true
      #   param :author, presence: true
      # end
    end

    def call(params)
      #puts ">>> uPARAMS: #{params.inspect}"
      puts ">>> uID: #{params[:id]} #{params[:book].inspect}"
      repository = BookRepository.new
      @book = repository.find(params[:id])
      if params.valid?
        #puts ">>> VALID..."
        @book.title = params[:book][:title]
        @book.author = params[:book][:author]
        repository.update(@book)

        # redirect_to routes.books_path
        redirect_to routes.bookcontainer_path
      else
        #puts ">>> INVALID..."
      end
    end

  end
end
