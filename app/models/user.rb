class User
  include MongoMapper::Document
  
  key :name, String
  key :username, String, :unique => true, :required => true
  
  many :authentications
  
  key :roles, Set
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
         
  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    self.name = omniauth['user_info']['name'] if name.blank?
    self.username, domain = self.email.split "@" if username.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
  def role?(role)
    self.roles.member?(role.to_s)
  end

end
