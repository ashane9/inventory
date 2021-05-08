class AuthenticationsAutograph < ApplicationRecord
  self.primary_keys = :authentication_id, :autograph_id
  belongs_to :authentication
  belongs_to :autograph
end
