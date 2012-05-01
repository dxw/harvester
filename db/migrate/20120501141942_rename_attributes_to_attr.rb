class RenameAttributesToAttr < ActiveRecord::Migration
  def change
    rename_table :attributes, :attrs
  end
end
