class House < ApplicationRecord
  extend Enumerize
  belongs_to :user_info

  enumerize :ownership_status, in: { owned: 0, rented: 1 }
end
