class Vehicle < ApplicationRecord
  belongs_to :user_info

  def is_recent_made?
    Date.current.year - year <= 5
  end
end
