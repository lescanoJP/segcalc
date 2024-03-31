class CreateInsurancePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :insurance_plans do |t|
      t.string :auto
      t.string :disability
      t.string :home
      t.string :life
      t.belongs_to :user_info

      t.timestamps
    end
  end
end
