module Web::Views::Search
  class Run
    include Web::View
    template 'home/jstest'

    def crossbeams_layout
      locals[:crossbeams_layout].build do |page, page_config|
        # Add section with back link and toggle SQL...

        page.add_grid('grd1', routes.searchgrid_path(id:       params[:id],
                                                     json_var: params[:json_var],
                                                     limit:    params[:limit],
                                                     offset:   params[:offset]),
                      caption: page_config.form_object.caption)
      end
    end
  end
end
