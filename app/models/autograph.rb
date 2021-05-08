class Autograph < ApplicationRecord
  belongs_to :item
  has_one_attached :image
  belongs_to :purchase, optional: true
  has_many :authentications_autographs
  has_many :authentications, through: :authentications_autographs
  validates :name, :presence => true
  # accepts_nested_attributes_for :authentications_autographs

  def self.count(owner)
    where(owned_by: owner).count
  end
end
