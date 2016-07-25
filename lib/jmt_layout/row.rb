module JmtLayout
  class Row
    attr_reader :sequence, :nodes, :page_config

    def initialize(page_config, section_sequence, sequence)
      @sequence = sequence
      @nodes  = []
      @page_config = page_config
    end

    def column(column_size=:full)
      column = Column.new(page_config, column_size, sequence, nodes.length+1)
      yield column
      @nodes << column
    end

    def render
      col_renders = nodes.map {|s| s.render }.join("\n<!-- End Col -->\n")
      <<-EOS
      <div class="pure-g">
      #{col_renders}
      </div>
      EOS
    end
  end
end

