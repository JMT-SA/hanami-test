module Web::Controllers::Grids
  class PrintGrid
    include Web::Action

    expose :jmt_layout

    def call(params)
      # @jmt_layout = JmtLayout::Page.new grid_url: params[:grid_url]
      @jmt_layout = FloatingCanvas::Layout::Page.new grid_url: params[:grid_url]
    end

  end
end


