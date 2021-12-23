require_relative 'config/environment'
User.create(email: "default@example.com")

ApplicationRecord.connected_to(shard: :shard_2) do
  User.create(email: "shard2@example.com")
  load 'db/schema.rb'
  puts "Found user on shard2: " + User.find_by(email: "shard2@example.com").present?.to_s
  puts "Should NOT be present, since the schema load should have run on shard_2, and wiped our data clean. But schema load happened on default shard and wiped out our data there instead."
end

puts

ApplicationRecord.connected_to(shard: :default) do
  puts "Found user on default shard: " + User.find_by(email: "default@example.com").present?.to_s
  puts "Should be present, since the schema load should have run on shard_2, but schema load happened on default shard and wiped out our data"
end