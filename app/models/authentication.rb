class Authentication
  include MongoMapper::Document
  safe
  
  key :uid, String
  key :provider, String
  
  belongs_to :user
end