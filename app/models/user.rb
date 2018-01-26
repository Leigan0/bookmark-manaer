require 'bcrypt'
require 'dm-validations'

class User
  include DataMapper::Resource
  include BCrypt

  property :id, Serial
  property :email_address, String, required: true
  property :password_hash, Text
  attr_accessor :password_confirmation
  attr_reader :password

  validates_confirmation_of :password
  validates_format_of :email_address, as: :email_address
  validates_uniqueness_of :email_address


  def password=(password)
    @password = password
    self.password_hash = BCrypt::Password.create(password)
  end

end
