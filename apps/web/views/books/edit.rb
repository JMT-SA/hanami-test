module Web::Views::Books
  class Edit
    include Web::View
    template 'home/jstest'

    def jmt_layout
      locals[:jmt_layout].build do |page, page_config|

        page.form do |form|
          form.action routes.book_path(id: page_config.form_object.id)
          # form.action routes.book_path(id: book.id)
          form.method :update

          form.row do |row|

            row.column(:half) do |column|
              column.add_field :title
              column.add_field :author
            end

          end
        end
      end
    end
  end
end
