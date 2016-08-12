module Web::Controllers::Books
  class Grid
    include Web::Action

    # expose :hs

    def call(params)
      self.format = :json
      data = DataminerControl.grid_from_dataminer(BookRepository, 'book_index')
      #TODO: also pass in links, plugin, colour rules, multiselect, grouping, in-grid editing,
      #command button(s) [actually cmd buttons should just be part of the page above the grid.].

      self.status = 200
      self.body = data
      # rescue...

      # data = DataminerControl.grid_from_dataminer('book_index')
      # data = DataminerControl.grid_from_dataminer('book_index', dm_params: {author: {value: 'John', operator: '<>'}}, limit: 10)
      # data = DataminerControl.grid_from_dataminer('book_index', dm_params: {author: {value: 'John', operator: '<>'}}, limit: 10, order: 'id')
      # data = DataminerControl.grid_from_dataminer('book_index', quick_params: {author: 'John'}, limit: 10, order: 'id DESC')
    end

  end
end

