class Post < ApplicationRecord
  paginates_per 5
  belongs_to :user
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments, allow_destroy: true
  validates :title, presence: true, length: {minimum: 5}
  validates_associated :comments

end