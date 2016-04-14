require 'digest'

class User < ActiveRecord::Base

  has_many :comments, dependent: :destroy

  attr_accessor :password

  attr_accessible :login, :avatar_link, :password, :password_confirmation

  validates :login, :presence => true,
            :length => { :maximum => 50 },
            :uniqueness => true

  validates :password, :presence => true,
            :confirmation => true,
            :length => { :within => 6..40 }

  before_save :encrypt_password, :default_values
  before_create :create_remember_token


  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(login, submitted_password)
    user = find_by_login(login)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt_token(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def default_values
      if new_record?
        if self.avatar_link == ''
          avatar_link_adr = 'http://claimmyrun.com/static/img/default-avatar-160.png'
          self.avatar_link = avatar_link_adr
        end
      end
    end

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password) if new_record?
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
      #secure_hash(string)
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

    def create_remember_token
      self.remember_token = User.encrypt_token(User.new_remember_token)
    end
end
