class CreatePagesAttributesJoinTable < ActiveRecord::Migration
  def change
    create_table :pages_attributes, id: false do |t|
      t.integer :page_id
      t.integer :attribute_id
    end
  end
end
