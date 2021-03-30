class Item < ApplicationRecord
  has_many :autographs
  belongs_to :item_type
  #belongs_to :image, optional: true
  belongs_to :value, optional: true
  belongs_to :purchase, optional: true
  has_one_attached :image
end
