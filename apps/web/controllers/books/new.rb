module Web::Controllers::Books
  class New
    include Web::Action

    expose :jmt_layout

    def call(params)
      # @jmt_layout = JmtLayout::Page.build do |page|
      @jmt_layout = FloatingCanvas::Layout::Page.build do |page|
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
