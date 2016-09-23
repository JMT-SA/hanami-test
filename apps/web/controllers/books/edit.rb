module Web::Controllers::Books
  class Edit
    include Web::Action

    expose :jmt_layout
    # expose :book

    def call(params)
      # puts ">>> ePARAMS: #{params.inspect}"
      # puts ">>> eID: #{params[:id]}"
      # @book = BookRepository.find(params[:id])
      book = BookRepository.find(params[:id])
      # @jmt_layout = JmtLayout::Page.new form_object: book, name: 'book'
      @jmt_layout = FloatingCanvas::Layout::Page.new form_object: book, name: 'book'
    end
  end
end
