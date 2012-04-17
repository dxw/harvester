class CreateNewPages < ActiveRecord::Migration
  def change
    create_table :new_pages do |t|
      t.integer :page_id
      t.string :uri

      t.timestamps
    end
  end
end
