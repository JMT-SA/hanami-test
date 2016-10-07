module Web::Controllers::Grids
  class PrintGrid
    include Web::Action

    expose :crossbeams_layout

    def call(params)
      @crossbeams_layout = Crossbeams::Layout::Page.new grid_url: params[:grid_url]
    end

  end
end


