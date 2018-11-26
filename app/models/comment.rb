class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :title, presence: true
  validates :contents, presence: true

  validates :movie_id, uniqueness: {scope: :user_id, message: "can be commented only once!"}
end
