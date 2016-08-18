class DataminerControl

  #TODO: remove repository.
  #      Should use db connection directly.
  #      ...able to use > 1 database?
  def self.grid_from_dataminer(repository, file_name, options={})
    report = get_report_with_options(file_name, options)
    col_defs = []
    report.ordered_columns.each do | col|
      # Web::Logger.debug ">>> #{col.name} - #{col.hide}"
      hs                  = {headerName: col.caption, field: col.name, hide: col.hide} #, enableRowGroup: col.groupable
      hs[:width]          = col.width unless col.width.nil?
      hs[:enableRowGroup] = true unless col.name == 'id'
      hs[:enableValue]    = true if col.name == 'id'
      hs[:aggFunc]        = :avg if col.name == 'id'
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
      col_defs << hs
    end

    {
      columnDefs: col_defs,
      #rowDefs:    repository.raw_query(report.runnable_sql)
      rowDefs:    dataminer_query(report.runnable_sql)#repository.raw_query(report.runnable_sql)
    }.to_json
  end

  def self.dataminer_query(sql)
    this_db = Sequel.connect('postgres://postgres:postgres@localhost:5432/stargrow')
    this_db[sql].to_a
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
