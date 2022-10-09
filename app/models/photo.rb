class Photo < ApplicationRecord
  has_one_attached :image
  validates :title,    length: { maximum: 30}
  validates :title,    presence: true
  validates :image,    presence: true
end
