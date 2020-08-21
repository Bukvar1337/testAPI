class Post < ApplicationRecord
  paginates_per 5
  belongs_to :user
  validates :title, presence: true, length: {minimum: 5}

end