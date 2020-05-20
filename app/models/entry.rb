class Entry
  include Mongoid::Document

  field :method, type: String
  field :path, type: String
  field :status, type: Integer
  field :nickname, type: String
  field :user_id, type: Integer
  field :visited_at, type: DateTime
end
