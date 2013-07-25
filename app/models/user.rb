class User < ActiveRecord::Base
  has_secure_password
  validates :name, :email, presence: true, uniqueness: true

  attr_accessor :current_password

  belongs_to :grade
  has_and_belongs_to_many :roles

  def self.find_or_create_from_auth_hash auth_hash
    @user = self.where(uid: auth_hash.uid, provider: :github).
         first_or_create(name: auth_hash.info.name,
                         email: auth_hash.info.email,
                         password: 666666,
                         password_confirmation: 666666,
                         nickname: auth_hash.info.nickname)
  end
end
