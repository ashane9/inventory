class Autograph < ApplicationRecord
  belongs_to :item
  has_one_attached :image
  belongs_to :purchase, optional: true
  belongs_to :authentication, optional: true
end
