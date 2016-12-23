class UserRepository < Hanami::Repository

  def authenticate(name, password)
    record = users.where(user_name: name).first

    return nil unless record

    record = User.new(record)
    return record if record.password?(password)

    nil
  end
end
