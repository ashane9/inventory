class Value < ApplicationRecord
  has_one :item, dependent: :destroy
  accepts_nested_attributes_for :item, allow_destroy: true, reject_if: proc { |att| att['name'].blank? }
  has_one :autograph, dependent: :destroy
  accepts_nested_attributes_for :autograph, allow_destroy: true, reject_if: proc { |att| att['name'].blank? }
end
