class Autograph < ApplicationRecord
  belongs_to :item
  has_many_attached :image
  belongs_to :purchase, optional: true
  has_many :authentications_autographs, dependent: :destroy
  has_many :authentications, through: :authentications_autographs
  validates :name, :presence => true

  def self.get_item_name
    Item.where(id: self.item_id).first.item_name
  end

  def self.count(owner)
    where(owned_by: owner).count
  end

  def destroy  
    value = value_id
    purchase = purchase_id
    super
    Value.find(value).delete if value
    Purchase.find(purchase).delete if purchase
    super
  end
end
