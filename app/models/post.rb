class Post < ApplicationRecord
  paginates_per 5
  belongs_to :user
  has_many :comments
  validates :title, presence: true, length: {minimum: 5}

end