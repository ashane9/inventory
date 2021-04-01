class Authentication < ApplicationRecord
  has_and_belongs_to_many :autographs, optional: true
end
