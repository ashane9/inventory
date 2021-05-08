class Purchase < ApplicationRecord
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items, allow_destroy: true, reject_if: proc { |att| att['name'].blank? }
  has_many :autographs, dependent: :destroy
  accepts_nested_attributes_for :autographs, allow_destroy: true, reject_if: proc { |att| att['name'].blank? }
  belongs_to :purchase_type, optional: true
end
