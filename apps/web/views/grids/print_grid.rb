module Web::Views::Grids
  class PrintGrid
    include Web::View
    layout 'print'
    template 'home/jsprint'

    def crossbeams_layout
      locals[:crossbeams_layout].build do |page|

        page.add_grid('crossbeamsPrintGrid', nil, caption: 'All Books', for_print: true)

      end
    end
  end
end

