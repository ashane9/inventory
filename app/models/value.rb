class Value < ApplicationRecord
  has_one :item
  accepts_nested_attributes_for :item, reject_if: proc { |att| att['name'].blank? }
  has_one :autograph
  accepts_nested_attributes_for :autograph, reject_if: proc { |att| att['name'].blank? }
end
