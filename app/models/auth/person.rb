require 'bcrypt'

class Auth::Person < ActiveRecord::Base
  attr_accessible :email, :password
  attr_accessor :password
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true, :on => :create

  before_save :encrypt_password

  def self.authenticate(email,_password)
    user = find_by_email(email)
    if user && user.pass == BCrypt::Engine.hash_secret(_password, user.salt)
      user
    else
      nil
    end
  end

private

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.pass = BCrypt::Engine.hash_secret(password, self.salt)
    end
  end

  def updata_auth_token

  end

end
