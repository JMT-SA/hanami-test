module Web::Controllers::Books
  class New
    include Web::Action

    expose :crossbeams_layout

    def call(params)
      @crossbeams_layout = Crossbeams::Layout::Page.build do |page|
        page.form_object Book.new
        page.form do |form|
          form.action routes.books_path

          form.row do |row|

            row.column(:half) do |column|
              column.add_field :title
              column.add_field :author
            end

          end
        end
      end
      # # self.body = 'BYPASS - without any layout...'
    end
  end
end
