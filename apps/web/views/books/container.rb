module Web::Views::Books
  class Container
    include Web::View
    template 'home/jstest'

    def jmt_layout
      locals[:jmt_layout].build do |page|

        page.section do |sect|
          sect.caption = 'Section One'

          sect.form do |form|
            form.action routes.books_path

            form.row do |row|

              row.column(:half) do |column|
                column.add_field :customer, :settings => {:a => :b}
                column.add_field :voyage
                column.add_text 'This is arbitrary text' # could use Hanami tags.
              end

              row.column(:half) do |column|
                column.add_field :invoice_date
              end

            end
          end

          sect.row do |row|
            row.column do |column|
              column.add_field :notes
            end
          end

        end

        page.callback_section do |sect|
          sect.caption = 'This section loaded via callback'
          sect.url     = routes.bookback_path
        end

        page.add_grid('grd1', routes.bookgrid_path, caption: 'All Books')

      end
    end
  end
end
