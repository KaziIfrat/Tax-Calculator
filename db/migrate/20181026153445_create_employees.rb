class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.belongs_to :file, foreign_key: true
      t.string :name
      t.float :fest_bonus
      t.float :PF
      t.float :total_income
      t.timestamps
    end
  end
end
