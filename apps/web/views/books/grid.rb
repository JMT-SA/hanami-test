module Web::Views::Books
  class Grid
    include Web::View

    format :json

    def render
      Web::Logger.debug ">>> ---rendering---"
      #JSON.generate({ errors: mapped_errors.to_h })
      #jsn = JSON.generate(hs)
      jsn = hs.to_json
      Web::Logger.debug ">>> #{jsn.inspect}"
      raw jsn
      #raw %(<h1>BYPASS - without HTML layout</h1>)
    end
  end
end

