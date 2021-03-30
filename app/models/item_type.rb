class ItemType < ApplicationRecord
  has_many :items


  def self.get_type_name(id)
    self.where(id: id).first.type_name
  end
end
