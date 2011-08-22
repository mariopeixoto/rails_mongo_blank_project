class Authentication
  include MongoMapper::Document
  
  key :uid, String
  key :provider, String
  
  belongs_to :user
end