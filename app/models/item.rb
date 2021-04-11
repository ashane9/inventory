class Item < ApplicationRecord
  has_many :autographs
  belongs_to :item_type
  belongs_to :value, optional: true
  belongs_to :purchase, optional: true
  has_one_attached :image

  validates :name, :presence => true

  def self.search_items(term)
    where("LOWER(item_name) LIKE ? or LOWER(description) LIKE ?", "%#{term}%", "%#{term}%").limit(5)
  end
end
