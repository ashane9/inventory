class Organization < ApplicationRecord
  has_many :autographs
  validates :org_name, :presence => true
end