class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.integer :year
      t.belongs_to :user_info, null: false, foreign_key: true

      t.timestamps
    end
  end
end
