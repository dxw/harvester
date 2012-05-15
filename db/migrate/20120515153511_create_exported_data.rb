class CreateExportedData < ActiveRecord::Migration
  def change
    create_table :exported_data do |t|
      t.integer :department_id
      t.string :uri

      t.timestamps
    end
  end
end
