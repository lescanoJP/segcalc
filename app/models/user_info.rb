class UserInfo < ApplicationRecord
  extend Enumerize

  has_one :vehicle
  has_one :house
  has_one :insurance_plan

  enumerize :marital_status, in: { single: 0, married: 1 }

  accepts_nested_attributes_for :vehicle
  accepts_nested_attributes_for :house

  def check_insurance_possibility
    vehicle.present? && house.present? && income.positive?
  end

  def is_sixty?
    age >= 60
  end

end
