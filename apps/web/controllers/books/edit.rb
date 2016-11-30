module Web::Controllers::Books
  class Edit
    include Web::Action

    expose :crossbeams_layout
    # expose :book

    def call(params)
      # puts ">>> ePARAMS: #{params.inspect}"
      # puts ">>> eID: #{params[:id]}"
      # @book = BookRepository.find(params[:id])
      repository = BookRepository.new
      book = repository.find(params[:id])
      @crossbeams_layout = Crossbeams::Layout::Page.new form_object: book, name: 'book'
    end
  end
end
