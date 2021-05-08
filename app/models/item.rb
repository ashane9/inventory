class Item < ApplicationRecord
  has_many :autographs, dependent: :destroy
  accepts_nested_attributes_for :autographs, allow_destroy: true, reject_if: proc { |att| att['name'].blank? }
  belongs_to :item_type
  belongs_to :value, optional: true
  belongs_to :purchase, optional: true
  has_one_attached :image

  validates :item_name, :presence => true

  def self.search_items(term)
    where("LOWER(item_name) LIKE ? or LOWER(description) LIKE ?", "%#{term}%", "%#{term}%").limit(5)
  end

  def self.count(owner)
    where(owned_by: owner).count
  end
end
