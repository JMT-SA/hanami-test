require 'bcrypt'
class User < Hanami::Entity

  def password?(unencrypted)
    BCrypt::Password.new(self.hashed_password) == unencrypted
  end

  # Helper to calculate hash for a password
  def self.hash_password(unencrypted)
    BCrypt::Password.create(unencrypted).to_s
  end

end
