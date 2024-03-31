class CreateUserInfos < ActiveRecord::Migration[7.1]
  def change
    create_table :user_infos do |t|
      t.integer :age
      t.integer :dependents
      t.integer :income
      t.integer :marital_status
      t.string :risk_questions

      t.timestamps
    end
  end
end
