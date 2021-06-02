class Purchase < ApplicationRecord
  has_many :items
  accepts_nested_attributes_for :items, reject_if: proc { |att| att['name'].blank? }
  has_many :autographs
  accepts_nested_attributes_for :autographs, reject_if: proc { |att| att['name'].blank? }
  belongs_to :purchase_type, optional: true

  def self.owner(owned_by)
    where(owned_by: owned_by)
  end

  def self.sum_total_cost
    sum(:total_cost)  
  end

  def self.item_purchases(owned_by)
    where(id: Item.where(owned_by: owned_by).select(:purchase_id).distinct)
  end

  def self.autograph_purchases(owned_by)
    where(id: Autograph.where(owned_by: owned_by).select(:purchase_id).distinct)
  end


end
