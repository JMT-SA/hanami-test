module Web::Views::Grids
  class PrintGrid
    include Web::View
    layout 'print'
    template 'home/jsprint'

    def jmt_layout
      locals[:jmt_layout].build do |page|

        page.add_grid('jmtPrintGrid', nil, caption: 'All Books', for_print: true)

      end
    end
  end
end

