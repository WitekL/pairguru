class GenreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :movies_count
end
