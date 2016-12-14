module Web::Controllers::Search
  class Filter
    include Web::Action

    expose :rpt, :qps, :rpt_id, :load_params

    def call(params)
      rpt_name = params[:id]
      # Web.logger.debug ">>> #{rpt_name}"
      @rpt = DataminerControl.get_report(rpt_name)
      # Web.logger.debug ">>> #{@rpt.caption}"
        # @rpt = lookup_report(params[:id])
        @qps = @rpt.query_parameter_definitions
        @rpt_id = params[:id]
        @load_params = params[:back] && params[:back] == 'y'
        #
        # @menu = menu
        # @report_action = "/#{settings.url_prefix}run_rpt/#{params[:id]}"
        # @excel_action = "/#{settings.url_prefix}run_xls_rpt/#{params[:id]}"

    end
  end
end
