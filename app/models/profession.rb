class Profession < ApplicationRecord
  has_many :autographs
  validates :profession_name, :presence => true
end