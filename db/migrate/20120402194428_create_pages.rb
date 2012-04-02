class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :uri
      t.string :name

      t.timestamps
    end
  end
end
