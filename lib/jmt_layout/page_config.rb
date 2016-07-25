module JmtLayout
  class PageConfig
    attr_reader :form_object, :name
    def initialize(options={})
      @form_object = options[:form_object]# || blank_object?
      @name        = options[:name] || 'jmt'
    end

    def form_object=(obj)
      puts ">>> OBJ: #{obj}"
      @form_object = obj
      @name        = (obj.class.name || 'jmt').downcase if name == 'jmt'
    end
  end
end
