module JmtLayout
  class Column
    attr_reader :css_class, :nodes, :page_config

    def initialize(page_config, size, seq1, seq2)
      @nodes = []
      case size
      when :full
        @css_class = "pure-u-1"
      when :half
        @css_class = "pure-u-1 pure-u-md-1-2"
      when :third
        @css_class = "pure-u-1 pure-u-md-1-3"
      when :quarter
        @css_class = "pure-u-1 pure-u-md-1-4"
      else
        raise ArgumentError, "Unknown column size \"#{size}\"."
      end
      @page_config = page_config
    end

    def self.make_column(page_config)
      self.new(page_config, :full, nil, nil)
    end

    def add_field(name, options={})
      @nodes << Field.new(page_config, name, options)
    end

    def add_text(text)
      @nodes << Text.new(page_config, text)
    end

    def add_grid(grid_id, url, options={})
      @nodes << Grid.new(page_config, grid_id, url, options)
    end

    #TODO: add_link; add_link_collection

    def add_node(node)
      @nodes << node
    end

    def render
      field_renders = nodes.map {|s| s.render }.join("\n<!-- End Col -->\n")
      <<-EOS
      <div class="#{css_class}">
      #{field_renders}
      </div>
      EOS
    end
  end
end
