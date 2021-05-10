class Purchase < ApplicationRecord
  has_many :items
  accepts_nested_attributes_for :items, reject_if: proc { |att| att['name'].blank? }
  has_many :autographs
  accepts_nested_attributes_for :autographs, reject_if: proc { |att| att['name'].blank? }
  belongs_to :purchase_type, optional: true
end
