class UserInfo < ApplicationRecord
  extend Enumerize

  has_one :vehicle
  has_one :house

  enumerize :marital_status, in: { single: 0, married: 1 }

  accepts_nested_attributes_for :vehicle
  accepts_nested_attributes_for :house
end
