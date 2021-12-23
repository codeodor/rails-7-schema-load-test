class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  connects_to shards: {
    default_shard: { writing: :default_shard, reading: :default_shard },
    shard_2: { writing: :shard_2, reading: :shard_2 }
  }
end
