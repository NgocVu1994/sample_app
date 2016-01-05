class Micropost < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 1000000}
  validates :title, presence: true, length: { maximum: 2000 }
  validate  :picture_size
  before_update :set_time
  def set_time
    self.time_edit = Time.zone.now
  end

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end