class CreateHouses < ActiveRecord::Migration[7.1]
  def change
    create_table :houses do |t|
      t.integer :ownership_status
      t.belongs_to :user_info, null: false, foreign_key: true

      t.timestamps
    end
  end
end
