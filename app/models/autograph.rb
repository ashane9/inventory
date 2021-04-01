class Autograph < ApplicationRecord
  belongs_to :item
  has_one_attached :image
  belongs_to :purchase, optional: true
  has_and_belongs_to_many :authentication, optional: true
end
