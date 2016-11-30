module Web::Controllers::Books
  class Calledback
    include Web::Action

    expose :books

    def call(params)
      repository = BookRepository.new
      @books = repository.all
    end
  end
end
