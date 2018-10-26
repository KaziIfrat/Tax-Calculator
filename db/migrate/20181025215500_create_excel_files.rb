class CreateExcelFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :excel_files do |t|

      t.timestamps
    end
  end
end
