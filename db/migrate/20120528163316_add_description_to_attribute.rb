class AddDescriptionToAttribute < ActiveRecord::Migration
  def change
    add_column :attrs, :description, :string
  end
end
