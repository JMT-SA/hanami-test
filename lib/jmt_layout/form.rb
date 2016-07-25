module JmtLayout
  class Form
    attr_reader :sequence, :nodes, :page_config, :form_action, :form_method

    def initialize(page_config, section_sequence, sequence)
      @sequence = sequence
      @form_action = '/' # work out from page_config.object?
      @nodes  = []
      @page_config = page_config
      @form_method = :create
    end

    def action(act)
      @form_action = act
    end

    def method(method)
      raise ArgumentError, "Invalid form method \"#{method}\"" unless [:create, :update].include?(method)
      @form_method = method
    end

    def row
      row = Row.new(page_config, sequence, nodes.length+1)
      yield row
      @nodes << row
    end

    def form_method_str
      case form_method
      when :create
        ''
      when :update
        '<input type="hidden" name="_method" value="PATCH">'
      end
    end

    def render
        # <form class="pure-form pure-form-aligned edit_user" id="edit_user_1" action="http://localhost:3002/users/1" accept-charset="UTF-8" method="post">
        # <input name="utf8" type="hidden" value="✓">
        # <input type="hidden" name="_method" value="patch"><input type="hidden" name="authenticity_token" value="XARxNVBl3eHsDuTDdLURzS3aTgDSaBOZGer6TMVgqmxEt6rj4LZ9Z1SWvta7jPFM3TT55OESF6Z4bdcoVkIX5A==">
      # <form class="pure-form pure-form-aligned edit_user" id="edit_user_1" action="#{form_action.sub(/\/(\d+)$/, "?id=#{1}")}" accept-charset="utf-8" method="POST">
      renders = nodes.map {|s| s.render }.join("\n<!-- End Row -->\n")
      <<-EOS
      <form class="pure-form pure-form-aligned edit_user" id="edit_user_1" action="#{form_action}" accept-charset="utf-8" method="POST">
      #{form_method_str}
      #{renders}
      <div class="actions pure-controls">
        <input type="submit" name="commit" value="Submit" data-disable-with="Submit" class="pure-button pure-button-primary">
      </div>
      </form>
      EOS
    end
  end
end

