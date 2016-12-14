module Web::Controllers::Search
  class Run
    include Web::Action

    expose :crossbeams_layout

    def call(params)
      report = DataminerControl.get_report(params[:id])
      DataminerControl.setup_report_with_parameters(report, params)
      @crossbeams_layout = Crossbeams::Layout::Page.new form_object: report
    end

  end
end
