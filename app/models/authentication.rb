class Authentication < ApplicationRecord
  has_many :authentications_autographs
  has_many :autographs, through: :authentications_autographs
end
