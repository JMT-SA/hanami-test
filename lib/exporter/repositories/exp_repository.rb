class ExpRepository
  include Hanami::Repository

  # Shortcut for repository to return results from a query. (An Array of Hashes)
  def self.raw_query(sql)
    fetch(sql)
  end

end
