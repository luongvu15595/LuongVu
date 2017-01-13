class Micropost < ApplicationRecord
  belongs_to :user
  scope :sort_by_created_at, ->{order created_at: :desc}
  mount_uploader :picture, PictureUploader
  validates :user, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :picture_size

  private
  def picture_size
    if picture.size > 5.megabytes
      errors.add :picture, "should be less than 5MB"
    end
  end
end
