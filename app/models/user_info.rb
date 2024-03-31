class UserInfo < ApplicationRecord
  has_one :car
  has_one :house
end
