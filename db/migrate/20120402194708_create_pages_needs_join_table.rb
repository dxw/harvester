class CreatePagesNeedsJoinTable < ActiveRecord::Migration
  def change
    create_table :pages_needs, id: false do |t|
      t.integer :page_id
      t.integer :need_id
    end
  end
end
