require 'bcrypt'
class User < ActiveRecord::Base
  include BCrypt

  def self.find_or_create_from_auth_hash auth_hash
    p auth_hash
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    password = Password.create(new_password)
    self.password_hash = password
  end
end
