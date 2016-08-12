module Web::Views::Books
  class Edit
    include Web::View
    template 'home/jstest'

    def jmt_layout
      #puts Hanami.env
      locals[:jmt_layout].with_form do |form, page_config|

          form.action routes.book_path(id: page_config.form_object.id)
          # form.action routes.book_path(id: book.id)
          form.method :update

          form.add_field :title
          form.add_field :author
          # form.row do |row|
          # end
      end
      # locals[:jmt_layout].build do |page, page_config|
      #
      #   page.form do |form|
      #     form.action routes.book_path(id: page_config.form_object.id)
      #     # form.action routes.book_path(id: book.id)
      #     form.method :update
      #
      #     form.row do |row|
      #
      #       row.column(:half) do |column|
      #         column.add_field :title
      #         column.add_field :author
      #       end
      #
      #     end
      #   end
      # end
    end
  end
end
