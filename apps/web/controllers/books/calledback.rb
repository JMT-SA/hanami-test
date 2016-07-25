module Web::Controllers::Books
  class Calledback
    include Web::Action

    expose :books

    def call(params)
      @books = BookRepository.all
    end
  end
end
