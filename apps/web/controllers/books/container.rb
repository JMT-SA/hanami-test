module Web::Controllers::Books
  class Container
    include Web::Action

    expose :jmt_layout

    def call(params)
      the_tester  = Struct.new(:customer, :voyage, :invoice_date, :notes).new('Kromco', 'LOCAL_123', Date.today, 'Some notes for testing')
      #@jmt_layout = JmtLayout::Page.new form_object: the_tester
      @jmt_layout = FloatingCanvas::Layout::Page.new form_object: the_tester
    end

  end
end
