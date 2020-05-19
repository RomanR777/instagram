class Entry
  include Mongoid::Document

  field :path, type: String
  field :refered, type: String
  field :visited_at, type: DateTime
end
