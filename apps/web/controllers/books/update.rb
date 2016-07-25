module Web::Controllers::Books
  class Update
    include Web::Action

    expose :book
    
    params do
      param :id
      param :book do
        param :title,  presence: true
        param :author, presence: true
      end
    end

    def call(params)
      #puts ">>> uPARAMS: #{params.inspect}"
      puts ">>> uID: #{params['id']} #{params[:id]} #{params[:book].inspect}"
      @book = BookRepository.find(params[:id])
      if params.valid?
        #puts ">>> VALID..."
        @book.title = params[:book][:title]
        @book.author = params[:book][:author]
        BookRepository.update(@book)

        # redirect_to routes.books_path
        redirect_to routes.bookcontainer_path
      else
        #puts ">>> INVALID..."
      end
    end

  end
end
