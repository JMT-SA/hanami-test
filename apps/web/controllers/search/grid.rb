module Web::Controllers::Search
  class Grid
    include Web::Action

    def call(params)
      self.format = :json
      data        = DataminerControl.grid_from_dataminer_search(params)
      self.status = 200
      self.body   = data
    end
  end
end
