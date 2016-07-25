module Web::Views::Books
  class New
    include Web::View

    template 'home/jstest'

    # def render
    #   raw %(<h1>BYPASS - without HTML layout</h1>)
    # end
  end
end
