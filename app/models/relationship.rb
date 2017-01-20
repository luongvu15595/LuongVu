class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  validates :follower, presence: true
  validates :followed, presence: true
end
