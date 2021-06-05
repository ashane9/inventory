class Size < ApplicationRecord
  has_many :items


  def self.get_item_size(id)
    self.where(id: id).first.item_size
  end
end
