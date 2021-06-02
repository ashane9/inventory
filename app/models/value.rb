class Value < ApplicationRecord
  has_one :item
  accepts_nested_attributes_for :item, reject_if: proc { |att| att['name'].blank? }
  has_one :autograph
  accepts_nested_attributes_for :autograph, reject_if: proc { |att| att['name'].blank? }
  
  def self.owner(owned_by)
    where(owned_by: owned_by)
  end

  def self.sum_total_value
    sum(:estimated_value)  
  end

  def self.item_value(owned_by)
    where(id: Item.where(owned_by: owned_by).select(:value_id).distinct)
  end

  def self.autograph_value(owned_by)
    where(id: Autograph.where(owned_by: owned_by).select(:value_id).distinct)
  end

end
