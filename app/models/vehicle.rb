class Vehicle < ApplicationRecord
  belongs_to :user_info

  validates :year, numericality: { greater_than_or_equal_to: 0 }

  def is_recent_made?
    Date.current.year - year <= 5
  end
end
