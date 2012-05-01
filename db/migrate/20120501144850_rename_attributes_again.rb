class RenameAttributesAgain < ActiveRecord::Migration
  def change
    rename_column :pages_attributes, :attribute_id, :attr_id
  end
end
