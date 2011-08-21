database = YAML::load(File.open("#{::Rails.root.to_s}/config/mongodb.yml"))[::Rails.env]

MongoMapper.connection = Mongo::Connection.new(database['host'], database['port'] )
MongoMapper.database = database['database']
if database['user'] and database['password']
  MongoMapper.database.authenticate(database['user'], database['password'])
end

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect if forked
   end
end