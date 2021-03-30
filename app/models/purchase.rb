class Purchase < ApplicationRecord
  has_many :items
  has_many :autographs
  belongs_to :purchase_type, optional: true
end
