module JmtLayout
  class Page
    attr_reader :nodes, :page_config, :sequence

    def initialize(options={})
      @nodes = []
      @page_config = PageConfig.new(options)
      @sequence = 1
    end

    def self.build(&block)
      self.new.build(&block)
    end

    def build
      yield self, page_config
      self
    end

    def form_object(obj)
      @page_config.form_object = obj
    end

    def section
      section = Section.new(page_config, nodes.length+1)
      yield section
      @nodes << section
    end

    def callback_section
      section = CallbackSection.new(page_config, nodes.length+1)
      yield section
      @nodes << section
    end

    def row
      row = Row.new(page_config, sequence, rows.length+1)
      yield row
      @nodes << row
    end

    def form
      form = Form.new(page_config, sequence, nodes.length+1)
      yield form
      @nodes << form
    end

    def render
      "A string rendered from JmtLayout<br>" << nodes.map {|s| s.render }.join("\n<!-- End Section -->\n")
    end
  end

end