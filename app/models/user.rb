require 'bcrypt'
class User < ActiveRecord::Base
  validates :name, :email, :passswod_hash, presence: true
  validates :name, :email, uniqueness: true
  include BCrypt

  def self.find_or_create_from_auth_hash auth_hash
    self.where(uid: auth_hash.uid, provider: :github).
         first_or_create(name: auth_hash.extra.raw_info.name,
                         email: auth_hash.info.email,
                         password_hash: 666666,
                         nickname: auth_hash.info.nickname)
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    password = Password.create(new_password)
    self.password_hash = password
  end
end
