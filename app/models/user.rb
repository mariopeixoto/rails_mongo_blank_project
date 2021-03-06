class User
  include MongoMapper::Document
  safe
  
  key :name, String
  key :username, String, :unique => true, :required => true
  key :email, String
  
  many :authentications
  
  key :roles, Set
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
         
  attr_accessor :login

  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    self.name = omniauth['user_info']['name'] if name.blank?
    self.username, domain = self.email.split "@" if username.blank?
    self.confirmed_at, self.confirmation_sent_at = Time.now  
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
  def role?(role)
    self.roles.member?(role.to_s)
  end
  
  
  protected
  
    def self.find_for_database_authentication(conditions)
     self.where({ :username => conditions[:login] }).first ||
         self.where({ :email => conditions[:login] }).first
    end

end
