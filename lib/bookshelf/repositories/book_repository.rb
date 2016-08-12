class BookRepository
  include Hanami::Repository

  #TODO: manage params with operators other than =.
  #      handle limit and offset
  #      handle multiple values and ranges
  def self.dataminer_fetch(file_name, options={})

    path            = File.join(Hanami.root, 'lib', 'bookshelf', 'dataminer_sources', file_name.sub('.yml', '') << '.yml')
    rpt_hash        = Dataminer::YamlPersistor.new(path)
    report          = Dataminer::Report.load(rpt_hash)
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
    # Web::Logger.debug ">>> #{parms.inspect}"
    # Web::Logger.debug ">>> #{report.runnable_sql}"

    fetch(report.runnable_sql)
  end
end
