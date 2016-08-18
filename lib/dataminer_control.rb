class DataminerControl

  #TODO: remove repository.
  #      Should use db connection directly.
  #      ...able to use > 1 database?
  def self.grid_from_dataminer(repository, file_name, options={})
    report = get_report_with_options(file_name, options)
    col_defs = []
    report.ordered_columns.each do | col|
      # Web::Logger.debug ">>> #{col.name} - #{col.hide}"
      hs                  = {headerName: col.caption, field: col.name, hide: col.hide, headerTooltip: col.caption} #, enableRowGroup: col.groupable
      hs[:width]          = col.width unless col.width.nil?
      #agg_func            = agg_func_for_column(col)
      #hs[:enableValue]    = true unless agg_func.nil?
      hs[:enableValue]    = true if [:integer, :number].include?(col.data_type)
      #hs[:aggFunc]        = agg_func unless agg_func.nil? || agg_func == :sum
      hs[:enableRowGroup] = true unless hs[:enableValue]
      # hs[:enableRowGroup] = true unless col.name == 'id'
      # hs[:enableValue]    = true if col.name == 'id'
      # hs[:aggFunc]        = :avg if col.name == 'id'
      # if col.group_sum
      # hs[:enableValue] = true
      # elsif [col.group_avg, col.group_min, col.group_max].any?
      #   hs["aggFunc] = case
      #   when col.group_avg
      #     :avg
      #   when col.group_min
      #     :min
      #   when col.group_max
      #     :max
      #     ### count ?????
      #   end
      #
      #total_amount: jmtGridFormatters.numberWithCommas2
      # integer, number, date and boolean.
      if [:integer, :number].include?(col.data_type)
        hs[:cellClass] = 'grid-number-column'
        hs[:width]     = 100 if col.width.nil? && col.data_type == :integer
        hs[:width]     = 120 if col.width.nil? && col.data_type == :number
      end
      if col.format == :delimited_1000
        hs[:cellRenderer] = 'jmtGridFormatters.numberWithCommas2'
      end
      if col.format == :delimited_1000_4
        hs[:cellRenderer] = 'jmtGridFormatters.numberWithCommas4'
      end
      if col.data_type == :boolean
        hs[:cellRenderer] = 'jmtGridFormatters.booleanFormatter'
        hs[:cellClass]    = 'grid-boolean-column'
        hs[:width]        = 100 if col.width.nil?
      end
      #hs[:cellClassRules] = {"'grid-row-red'": "x === 'EUR'"} if col.name == 'currency_code' .... not working...
#     'rag-green-outer': function(params) { return params.value === 2008},
#     'rag-amber-outer': function(params) { return params.value === 2004},
#     'rag-red-outer': function(params) { return params.value === 2000}
# },
      #puts ">>> #{col.format.class}" if col.name == 'total_amount'
      #hs[:cellRenderer] = 'jmtGridFormatters.testRender' if col.name == 'total_amount'
      col_defs << hs
    end

    {
      columnDefs: col_defs,
      #rowDefs:    repository.raw_query(report.runnable_sql)
      rowDefs:    dataminer_query(report.runnable_sql)#repository.raw_query(report.runnable_sql)
    }.to_json
  end

  def self.agg_func_for_column(col)
    case
    when col.group_sum
      :sum
    when col.group_avg
      :avg
    when col.group_min
      :min
    when col.group_max
      :max
    else
      nil
      ### count ?????
    end
  end

  def self.dataminer_query(sql)
    this_db = Sequel.connect('postgres://postgres:postgres@localhost:5432/stargrow')
    #this_db[sql].to_a
    # Need to convert all BigDecimal to float for JSON (otherwise the aggregations don't work because amounts are returned as 0.1126673E5)
    # - Need to do some checking that the resulting float is an accurate representation of the decimal...
    this_db[sql].to_a.map {|m| m.keys.each {|k| if m[k].is_a?(BigDecimal) then m[k] = m[k].to_f; end }; m; }
  end

  def self.dataminer_fetch(repository, file_name, options={})
    report = get_report_with_options(file_name, options)
    this_db = Sequel.connect('postgres://postgres:postgres@localhost:5432/stargrow')
    this_db[report.runnable_sql]
    #Sequel.connect('postgres://user:password@host:port/database_name'){|db| db[:posts].delete}
    #repository.raw_query(report.runnable_sql)
  end

  private

  # Load a YML report.
  def self.get_report(file_name) #TODO:  'bookshelf' should be variable...
    #path     = File.join(Hanami.root, 'lib', 'bookshelf', 'dataminer_sources', file_name.sub('.yml', '') << '.yml')
    path     = File.join(Hanami.root, 'lib', 'exporter', 'dataminer_sources', file_name.sub('.yml', '') << '.yml')
    rpt_hash = Dataminer::YamlPersistor.new(path)
    Dataminer::Report.load(rpt_hash)
  end

  # Set up a YML-loaded report with options.
  def self.get_report_with_options(file_name, options={})
    report          = get_report(file_name)
    report.limit    = options[:limit]  if options[:limit]
    report.offset   = options[:offset] if options[:offset]
    report.order_by = options[:order]  if options[:order]

    dm_params = (options[:dm_params] || {})
    if options[:quick_params] && {} == dm_params
      options[:quick_params].each { |fld, val| dm_params[fld] = {value: val} }
    end

    parms = []
    dm_params.each do |f, op_value|
      field      = f.to_s
      value      = op_value[:value]
      oper       = op_value[:operator] || '='
      data_type  = op_value[:data_type]
      col        = report.column(field)
      param_name = col.nil? ? field : col.namespaced_name
      param_def  = report.parameter_definition(param_name)

      if param_def.nil?
        parms << Dataminer::QueryParameter.new(param_name, Dataminer::OperatorValue.new(oper, value, data_type))
      else
        parms << Dataminer::QueryParameter.from_definition(param_def, Dataminer::OperatorValue.new(oper, value, data_type))
      end
    end
    report.apply_params(parms) unless parms.empty?
    report
  end

end
